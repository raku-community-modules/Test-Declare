use v6.c;

use Test::Declarative;

role Test::Declarative::Suite {
    method class { … }
    method method { … }
    method tests { … }
    method construct returns Capture { … }

    method run-me {
        my @tests = self.tests;
        @tests.map:{
            for <class method construct> -> $attr {
                if $_{'call'}{$attr}:!exists { $_{'call'}{$attr} = self."$attr"(); }
            }
        };
        declare(@tests);
    }
}
