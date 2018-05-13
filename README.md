NAME
====

Test::Declarative - Declare common test scenarios as data.

SYNOPSIS
========

    use Test::Declarative;

    use Module::Under::Test;

    declare(
        ${
            name => 'multiply',
            call => {
                class => 'Module::Under::Test',
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
                class => 'Module::Under::Test',
                construct => \(2),
                method => 'multiply',
            },
            args => \(multiplicand => 'four'),
            expected => {
                dies => True,
            },
        },
    );

DESCRIPTION
===========

Test::Declarative is an opinionated framework for writing tests without writing (much) code. The author viscerally hates bugs and strongly believes in the value of tests. Since most tests are code, they are susceptible to bugs, and so this module provides a way to express a wide variety of common testing scenarios purely in a declarative way.

AUTHOR
======

Darren Foreman <darren.s.foreman@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2018 Darren Foreman

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
