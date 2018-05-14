use v6.c;
use Test::Declarative;
use Test::Declarative::Suite;
use lib 't/lib';
use TDHelpers;

my class Numbers {
    method five { 5 }
    method twelve { 12 }
}

class MyTest does Test::Declarative::Suite {
    method class { T::Math }
    method method { 'multiply' }
    method construct { \( num => 3 ) }

    method tests {
        ${
            name => '3x2 < 10',
            args => \(2),
            expected => {
                return-value => roughly(&[<], 10),
            },
        },
        ${
            name => '3x4 > 10',
            args => \(4),
            expected => {
                return-value => roughly(&[>], 10),
            },
        },
        ${
            name => '5 is in 1..10',
            call => {
                class => Numbers,
                method => 'five',
            },
            expected => {
                return-value => roughly(&[~~], 1..10),
            },
        },
        ${
            name => '12 is not in 1..10',
            call => {
                class => Numbers,
                method => 'twelve',
            },
            expected => {
                return-value => roughly(&[!~~], 1..10),
            },
        },
    }
}

MyTest.new.run-me;
