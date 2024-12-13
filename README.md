[![Actions Status](https://github.com/raku-community-modules/Test-Declare/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Test-Declare/actions) [![Actions Status](https://github.com/raku-community-modules/Test-Declare/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Test-Declare/actions) [![Actions Status](https://github.com/raku-community-modules/Test-Declare/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Test-Declare/actions)

NAME
====

Test::Declare - Declare common test scenarios as data.

CAVEAT
------

The author is a novice at Raku. Please be nice if you've stumbled across this and have opinions to express. Furthermore I somehow failed to notice the pre-existence of a Perl `Test::Declare`, to which this code is **no relation**. Apologies for any confusion; I renamed late in the day, being fed up with the length of my first choice of `Test::Declarative`.

SYNOPSIS
========

```raku
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
            # requires Test::Declare::Comparisons
            return-value => roughly(&[>], 10),
        },
    },
);
```

DESCRIPTION
===========

Test::Declare is an opinionated framework for writing tests without writing (much) code. The author hates bugs and strongly believes in the value of tests. Since most tests are code, they themselves are susceptible to bugs; this module provides a way to express a wide variety of common testing scenarios purely in a declarative way.

USAGE
=====

Direct usage of this module is via the exported subroutine `declare`. The tests within the distribution in [t/](https://github.com/raku-community-modules/Test-Declare/tree/main/t) can also be considered to be a suite of examples which exercise all the options available.

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

If required, a [Capture](https://docs.raku.org/type/Capture.html) of the arguments to the class's `new` method.

  * args

If required, a [Capture](https://docs.raku.org/type/Capture.html) of the arguments to the instance's method.

  * expected

A hash describing the expected behaviour when the method gets called.

    * return-value

The return value of the method, which will be compared to the actual return value via `eqv`.

    * lives / dies / throws

`lives` and `dies` are booleans, expressing simply whether the code should work or not. `throws` should be an Exception type.

    * stdout / stderr

Strings against which the method's output/error streams are compared, using `eqv` (i.e. not a regex).

SEE ALSO
========

Elsewhere in this distribution:

  * `Test::Declare::Comparisons` - for fuzzy matching including some naive/rudimentary attempts at copying the [Test::Deep](https://metacpan.org/pod/Test::Deep) interface where Raku does not have it builtin.

  * [Test::Declare::Suite](https://github.com/raku-community-modules/Test-Declare/tree/main/lib/Test/Declare/Suite.rakumod) - for a role which bundles tests together against a common class / method, to reduce repetition.

AUTHOR
======

Darren Foreman

COPYRIGHT AND LICENSE
=====================

Copyright 2018 Darren Foreman

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

