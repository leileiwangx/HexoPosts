---
title: pytest Quick Start Guide
date: 2021-06-15 16:05:22
tags:
  - pytest
---

## Writing and Running Tests

- Organizing files and packages
- Useful command-line options
- Configuration: pytest.ini file

### Installing pytest
https://packaging.python.org/guides/installing-using-pip-and-virtualenv/
python -m venv .env
source .env/bin/activate
pip install pytest
pytest --version


### Writing and running tests
Note that there's no need to create classes; just simple functions and plain assert statements are enough, but if you want to use classes to group tests you can do so:

    class TestMechanics:

        def test_player_hit(self):
            ...

        def test_player_health_flask(self):
            ...
Grouping tests can be useful when you want to put a number of tests under the same scope: you can execute tests based on the class they are in, apply markers to all of the tests in a class (Chapter 3, Markers and Parametrization), and create fixtures bound to a class (Chapter 4, Fixtures).

### Running tests
> pytest

This will find all of the test_*.py and *_test.py modules in the current directory and below recursively, and will run all of the tests found in those files
You can reduce the search to specific directories

> pytest tests/core tests/contrib

You can also mix any number of files and directories:

> pytest tests/core tests/contrib/test_text_plugin.py

You can execute specific tests by using the syntax <test-file>::<test-function-name>:

> pytest tests/core/test_core.py::test_regex_matching

You can execute all of the test methods of a test class:

> pytest tests/contrib/test_text_plugin.py::TestPluginHooks

You can execute a specific test method of a test class using the syntax <test-file>::<test-class>::<test-method-name>:
> pytest tests/contrib/test_text_plugin.py::TestPluginHooks::test_registration

show a more verbose output, -v

>  pytest tests/core -v

To see which tests there are without running them, use the --collect-only  flag:
--collect-only is especially useful if you want to execute a specific test but can't remember its exact name.
pytest tests/core --collect-only

### Powerful asserts
Contrary to other frameworks, you don't need to remember various self.assert* or self.expect* functions.

here's an example of a failure:

________________________ test_default_health ________________________

    def test_default_health():
        health = get_default_health('warrior')
>       assert health == 95
E       assert 80 == 95

tests\test_assert_demo.py:25: AssertionError

#### Text differences
When showing the explanation for short strings, pytest uses a simple difference method:
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
#### Lists
Assertion failures for lists also show only differing items by default:
E       AssertionError: assert ['long sword'...et', 'shield'] == ['long sword', 'shield']
E         At index 1 diff: 'warrior set' != 'shield'
E         Left contains more items, first extra item: 'shield'
E         Use -v to get the full diff

Note that pytest shows which index differs, and also that the -v flag can be used to show the complete difference between the lists:
E       AssertionError: assert ['long sword'...et', 'shield'] == ['long sword', 'shield']
E         At index 1 diff: 'warrior set' != 'shield'
E         Left contains more items, first extra item: 'shield'
E         Full diff:
E         - ['long sword', 'warrior set', 'shield']
E         ?               ---------------
E         + ['long sword', 'shield']
#### Dictionaries and sets
Dictionaries are probably one of the most used data structures in Python, so, unsurprisingly, pytest has specialized representation for them:
E       AssertionError: assert {'knight': 95...'warrior': 85} == {'sorcerer': 50, 'warrior': 85}
E         Omitting 1 identical items, use -vv to show
E         Differing items:
E         {'sorcerer': 55} != {'sorcerer': 50}
E         Left contains more items:
E         {'knight': 95}
E         Use -v to get the full diff

E         Extra items in the left set:
E         'knight'


### How does pytest do it?
By default, Python's assert statement does not provide any details when it fails, but as we just saw, pytest shows a lot of information about the variables and expressions involved in a failed assertion. So how does pytest do it?

Pytest is able to provide useful exceptions because it implements a mechanism called assertion rewriting.
ssertion rewriting works by installing a custom import hook that intercepts the standard Python import mechanism. When pytest detects that a test file (or plugin) is about to be imported, instead of loading the module, it first compiles the source code into an abstract syntax tree (AST) using the built-in ast module. Then, it searches for any assert statements and rewrites them so that the variables used in the expression are kept so that they can be used to show more helpful messages if the assertion fails. Finally, it saves the rewritten pyc file to disk for caching

#### Checking exceptions: pytest.raises
