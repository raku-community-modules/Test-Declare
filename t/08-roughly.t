use v6.c;
use Test::Declare;
use Test::Declare::Suite;
use lib 't/lib';
use TDHelpers;

my class Numbers {
    method five { 5 }
    method twelve { 12 }
    method incr(Int $n is rw) { $n++ }
}

class MyTest does Test::Declare::Suite {
    method class { T::Math }
    method method { 'multiply' }
    method construct { \( num => 3 ) }
    my $n = 3;

    method tests {
        ${
            name => 'stdout',
            call => {
                class => Str,
                construct => \(value => 'Foo'),
                method => 'say',
            },
            expected => {
                stdout => roughly(&[~~], rx/^ Fo+ \n$/),
            },
        },
        ${
            name => 'mutation',
            call => {
                class => Numbers,
                method => 'incr',
            },
            args => \($n),
            expected => {
                # "$n will be greater than 3"
                mutates => roughly(&[>], 3),
            },
        },
        ${
            name => 'return',
            args => \(2),
            expected => {
                return-value => roughly(&[<], 10),
            },
        },
        ${
            name => 'seq',
            call => {
                class => Numbers,
                method => 'five',
            },
            expected => {
                return-value => roughly(&[~~], 1..10),
            },
        },
        ${
            name => 'negative seq',
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
