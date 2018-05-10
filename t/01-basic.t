use v6.c;

use Test::Declarative;

class T::Math {
    has Int $.num;

    method multiply(Int $a) returns Int {
        return $!num * $a; 
    }

    method as-word returns Str {
        my %words = 
            1 => 'one',
            2 => 'two',
            3 => 'three',
        ;
        return %words{$!num};
    }

    method speak {
        say self.as-word();
    }

    method add(Cool :$adder) returns Cool {
        return $!num+$adder;
    }

    method stern {
        note self.as-word();
    }
}

class T::NoConstruct {
    has Int $.num is rw;

    method blurt() {
        if $!num {
            say 'GOT NUM: ' ~ $!num;
        }
        else {
            say 'NO NUM';
        }
    }
}

declare(
    ${
        name => 'empty blurt',
        call => {
            class => 'T::NoConstruct',
            method => 'blurt',
        },
        expected => {
            stdout => "NO NUM\n",
        },
    },
    ${
        name => 'full blurt',
        call => {
            class => 'T::NoConstruct',
            construct => \(num => 1),
            method => 'blurt',
        },
        expected => {
            stdout => "GOT NUM: 1\n",
        },
    },
    ${
        name => 'multiply',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'multiply',
        },
        args => \(8),
        expected => {
            return-value => 16,
        },
    },
    ${
        name => 'multiply fail',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'multiply',
        },
        args => \("eight"),
        expected => {
            dies => True,
            throws => 'Exception',
        },
    },
    ${
        name => 'word',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'as-word',
        },
        expected => {
            return-value => 'two',
        },
    },
    ${
        name => 'word lives',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'as-word',
        },
        expected => {
            lives => True,
        },
    },
    ${
        name => 'stern',
        call => {
            class => 'T::Math',
            construct => \( num => 3 ),
            method => 'stern',
        },
        expected => {
            stderr => "three\n",
        },
    },
    ${
        name => 'speak',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'speak',
        },
        expected => {
            stdout => "two\n",
        },
    },
    ${
        name => 'add',
        call => {
            class => 'T::Math',
            construct => \( num => 2 ),
            method => 'add',
        },
        args => \(adder => 4.5),
        expected => {
            return-value => 6.5,
        },
    },
);
