---
title: pytest Quick Start Guide
date: 2021-06-15 16:05:22
tags:
  - pytest
---

# Writing and Running Tests

- Organizing files and packages
- Useful command-line options
- Configuration: pytest.ini file

## Installing pytest
### pip and virtualenv
[guides/installing-using-pip-and-virtualenv/](https://packaging.python.org/guides/installing-using-pip-and-virtualenv/)
`python -m venv .env`
`source .env/bin/activate`
`pip install pytest`
`pytest --version`

### Writing and running tests
Note that there's no need to create classes; just simple functions and plain assert statements are enough, but if you want to use classes to group tests you can do so:
```python
    class TestMechanics:

        def test_player_hit(self):
            ...

        def test_player_health_flask(self):
            ...
```
Grouping tests can be useful when you want to put a number of tests under the same scope: you can execute tests based on the class they are in, apply markers to all of the tests in a class (Chapter 3, Markers and Parametrization), and create fixtures bound to a class (Chapter 4, Fixtures).

### Running tests
`> pytest`
This will find all of the test_*.py and *_test.py modules in the current directory and below recursively, and will run all of the tests found in those files.You can reduce the search to specific directories
`> pytest  tests/core  tests/contrib`
You can also mix any number of files and directories:
`> pytest  tests/core  tests/contrib/test_text_plugin.py`
You can execute specific tests by using the syntax `test-file`::`test-function-name`:
`> pytest  tests/core/test_core.py::test_regex_matching`
You can execute all of the test methods of a test class:
`> pytest  tests/contrib/test_text_plugin.py::TestPluginHooks`
You can execute a specific test method of a test class using the syntax `test-file`::`test-class`::`test-method-name`:
`> pytest  tests/contrib/test_text_plugin.py::TestPluginHooks::test_registration`
show a more verbose output, -v
`> pytest tests/core -v`
To see which tests there are without running them, use the --collect-only  flag:
--collect-only is especially useful if you want to execute a specific test but can't remember its exact name.
`> pytest tests/core --collect-only`

### Powerful asserts
Contrary to other frameworks, you don't need to remember various self.assert* or self.expect* functions.
here's an example of a failure:
```
________________________ test_default_health ________________________

    def test_default_health():
        health = get_default_health('warrior')
>       assert health == 95
E       assert 80 == 95

tests\test_assert_demo.py:25: AssertionError
```
#### Text differences
When showing the explanation for short strings, pytest uses a simple difference method:
```
E         - warrior
E         + sorcerer
Longer strings show a smarter delta, using difflib.ndiff to quickly spot the differences
E       AssertionError: assert 'A battle-har... and weapons.' == 'A battle-hard... and weapons.'
E         - A battle-hardened veteran, favors heavy armor and weapons.
E         ?                            ^ ^^^^
E         + A battle-hardened veteran, can equip heavy armor and weapons.
E         ?                            ^ ^^^^^^^
Multiline strings are also treated specially:
E       AssertionError: assert 'A seasoned v... \n' == 'A seasoned ve... \n'
E         - A seasoned veteran of many battles. High Strength and Dexterity
E         ?                                     -----
E         + A seasoned veteran of many battles. Strength and Dexterity
E           allow to yield heavy armor and weapons, as well as carry
E         - more equipment while keeping a light roll. Weak in magic.
E         ?               ---------------------------
E         + more equipment. Weak in magic.
```
#### Lists
Assertion failures for lists also show only differing items by default:
```
E       AssertionError: assert ['long sword'...et', 'shield'] == ['long sword', 'shield']
E         At index 1 diff: 'warrior set' != 'shield'
E         Left contains more items, first extra item: 'shield'
E         Use -v to get the full diff
```
Note that pytest shows which index differs, and also that the -v flag can be used to show the complete difference between the lists:
```
E       AssertionError: assert ['long sword'...et', 'shield'] == ['long sword', 'shield']
E         At index 1 diff: 'warrior set' != 'shield'
E         Left contains more items, first extra item: 'shield'
E         Full diff:
E         - ['long sword', 'warrior set', 'shield']
E         ?               ---------------
E         + ['long sword', 'shield']
```
#### Dictionaries and sets
Dictionaries are probably one of the most used data structures in Python, so, unsurprisingly, pytest has specialized representation for them:
```
E       AssertionError: assert {'knight': 95...'warrior': 85} == {'sorcerer': 50, 'warrior': 85}
E         Omitting 1 identical items, use -vv to show
E         Differing items:
E         {'sorcerer': 55} != {'sorcerer': 50}
E         Left contains more items:
E         {'knight': 95}
E         Use -v to get the full diff

E         Extra items in the left set:
E         'knight'
```

#### How does pytest do it?
By default, Python's assert statement does not provide any details when it fails, but as we just saw, pytest shows a lot of information about the variables and expressions involved in a failed assertion. So how does pytest do it?

Pytest is able to provide useful exceptions because it implements a mechanism called assertion rewriting.
ssertion rewriting works by installing a custom import hook that intercepts the standard Python import mechanism. When pytest detects that a test file (or plugin) is about to be imported, instead of loading the module, it first compiles the source code into an abstract syntax tree (AST) using the built-in ast module. Then, it searches for any assert statements and rewrites them so that the variables used in the expression are kept so that they can be used to show more helpful messages if the assertion fails. Finally, it saves the rewritten pyc file to disk for caching

### Checking exceptions: pytest.raises
Testing that exceptions are raised in the appropriate circumstances is just as important as testing the main functionality of APIs. It is also important to make sure that exceptions contain an appropriate and clear message to help users understand the issue.

```python
def create_character(name: str, class_name: str) -> Character:
    """
    Creates a new character and inserts it into the database.

    :raise InvalidCharacterNameError:
        if the character name is empty.

    :raise InvalidClassNameError:
        if the class name is invalid.

    :return: the newly created Character.
    """
    ...

def test_empty_name():
    with pytest.raises(InvalidCharacterNameError):
        create_character(name='', class_name='warrior')


def test_invalid_class_name():
    with pytest.raises(InvalidClassNameError):
        create_character(name='Solaire', class_name='mage')
```
#### Checking exception messages
In the previous examples, we only verified that the code was raising the appropriate exception type, but not the actual message.
pytest.raises can receive an optional match argument, which is a regular expression string that will be matched against the exception message, as well as checking the exception type. For more details, go to: https://docs.python.org/3/howto/regex.html. We can use that to improve our tests even further:
```python
def test_empty_name():
    with pytest.raises(InvalidCharacterNameError,
                       match='character name empty'):
        create_character(name='', class_name='warrior')

def test_invalid_class_name():
    with pytest.raises(InvalidClassNameError,
                       match='invalid class name: "mage"'):
        create_character(name='Solaire', class_name='mage')
```

### Checking warnings: pytest.warns

```python
def get_initial_hit_points(player_class: Union[PlayerClass, str]) -> int:
    if isinstance(player_class, str):
        msg = 'Using player_class as str has been deprecated' \
              'and will be removed in the future'
        warnings.warn(DeprecationWarning(msg))
        player_class = get_player_enum_from_string(player_class)
    ...

def test_get_initial_hit_points_warning():
    with pytest.warns(DeprecationWarning):
        get_initial_hit_points('warrior')
```
As with pytest.raises, pytest.warns can receive an optional match argument, which is a regular expression string. 
```python
def test_get_initial_hit_points_warning():
    with pytest.warns(DeprecationWarning,
                      match='.*str has been deprecated.*'):
        get_initial_hit_points('warrior')
```

### Comparing floating point numbers: pytest.approx
Numbers that we consider equal in the real world are not so when represented by computer hardware:
```
 0.1 + 0.2 == 0.3
 False
```
When writing tests, it is very common to compare the results produced by our code against what we expect as floating point values. As shown above, a simple == comparison often won't be sufficient. A common approach is to use a known tolerance instead and use abs to correctly deal with negative numbers:
```python
def test_simple_math():
    assert abs(0.1 + 0.2) - 0.3 < 0.0001
```
But besides being ugly and hard to understand, it is sometimes difficult to come up with a tolerance that works in most situations. The chosen tolerance of 0.0001 might work for the numbers above, but not for very large numbers or very small ones.

pytest.approx solves this problem by automatically choosing a tolerance appropriate for the values involved in the expression, providing a very nice syntax to boot:

```python
def test_approx_simple():
    assert 0.1 + 0.2 == approx(0.3)
```

You can read the above as assert that 0.1 + 0.2 equals approximately to 0.3.
But the  approx function does not stop there; it can be used to compare:
Sequences of numbers:
```python
      def test_approx_list():
          assert [0.1 + 1.2, 0.2 + 0.8] == approx([1.3, 1.0])
```
Dictionary values (not keys):
```python
      def test_approx_dict():
          values = {'v1': 0.1 + 1.2, 'v2': 0.2 + 0.8}
          assert values == approx(dict(v1=1.3, v2=1.0))
```
numpy arrays:
```python
      def test_approx_numpy():
          import numpy as np
          values = np.array([0.1, 0.2]) + np.array([1.2, 0.8])
          assert values == approx(np.array([1.3, 1.0]))
```
When a test fails, approx provides a nice error message displaying the values that failed and the tolerance used:
```
    def test_approx_simple_fail():
>       assert 0.1 + 0.2 == approx(0.35)
E       assert (0.1 + 0.2) == 0.35 ± 3.5e-07
E        + where 0.35 ± 3.5e-07 = approx(0.35)
```