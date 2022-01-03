# Advent of Code 2021

Implementation of some test problems from [Advent of Code 2021](https://adventofcode.com/2021).

## Setup

If you are using RVM, it should select the correct ruby version and create a gemset for you. If not, it might be a good idea to create a new gemset for yourself, as per your environment.

Run `bundle install` to install the test and linting frameworks. If the `bundle` command is not found you may also need to install bundler (`gem install bundler`) if it's not set up globally on your system.

## Working

Working on this usually follows the following pattern.

Create a branch
---------------

`./branch <branch_name>`

Usually I make some changes.

Run Locally
-----------

`./run`

This will run the individual challenges.

Run Linter
----------

`./lint`

Commit, or Ship
---------------

If you want to commit and keep working run:

`./commit`

If you want to commit and are done, ship it!

`./ship`

This merges the branch to main.

Credits
-------

[Advent of Code](https://adventofcode.com/2021/about) is a fun coding challenge I use to practive coding challenges,
although I rarely do them as they're released over Advent.
