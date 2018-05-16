[![Build Status](https://travis-ci.org/darrenf/p6-test-declare.svg?branch=master)](https://travis-ci.org/darrenf/p6-test-declare)

NAME
====

Test::Declare - Declare common test scenarios as data.

SYNOPSIS
========

    use Test::Declare;

    use Module::Under::Test;

    declare(
        ${
            name => 'multiply',
            call => {
                class => Module::Under::Test,
                construct => \(2),
                method => 'multiply',
            },
            args => \(multiplicand => 4),
            expected => {
                return-value => 8,
            },
        },
        ${
            name => 'multiply fails',
            call => {
                class => Module::Under::Test,
                construct => \(2),
                method => 'multiply',
            },
            args => \(multiplicand => 'four'),
            expected => {
                dies => True,
            },
        },
        ${
            name => 'multiply fails',
            call => {
                class => Module::Under::Test,
                construct => \(2),
                method => 'multiply',
            },
            args => \(multiplicand => 8),
            expected => {
                return-value => roughly(&[>], 10),
            },
        },
    );

DESCRIPTION
===========

Test::Declare is an opinionated framework for writing tests without writing (much) code. The author viscerally hates bugs and strongly believes in the value of tests. Since most tests are code, they are susceptible to bugs, and so this module provides a way to express a wide variety of common testing scenarios purely in a declarative way.

USAGE
=====

Direct usage of this module is via the exported subroutine `declare`.

declare(${ … }, ${ … })
-----------------------

`declare` takes an array of hashes describing the test scenarios and expectations. Each hash should look like this:

  * name

The name of the test, for developer understanding in the TAP output.

  * call

A hash describing the code to be called.

    * class

The actual concrete class - not a string representation, and not an instance either.

    * method

String name of the method to call.

    * construct

If required, a [Capture](Capture) of the arguments to the class's `new` method.

  * args

If required, a [Capture](Capture) of the arguments to the instance's method.

  * expected

A hash describing the expected behaviour when the method gets called.

    * return-value

The return value of the method, which will be compared to the actual return value via `eqv`.

    * lives/dies/throws

`lives` and `dies` are booleans, expressing simply whether the code should work or not. `throws` should be an Exception type.

    * stdout/stderr

Strings against which the method's output/error streams are compared, using `eqv` (i.e. not a regex).

SEE ALSO
========

[Test::Declare::Comparisons](Test::Declare::Comparisons) - for fuzzy matching including some naive/rudimentary attempts at copying the [Test::Deep](Test::Deep) interface where Perl 6 does not have it builtin.

[Test::Declare::Suite](Test::Declare::Suite) - for a role which bundles tests together against a common class/method, to reduce repetition.

AUTHOR
======

Darren Foreman <81590+darrenf@users.noreply.github.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2018 Darren Foreman

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

