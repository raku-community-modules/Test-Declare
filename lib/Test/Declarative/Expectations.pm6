use v6.c;

class Test::Declarative::Expectations {
    has Str $.stdout;
    has Str $.stderr;

    has Any $.return-value;
    has Any $.mutates;

    has Bool $.lives;
    has Bool $.dies;
    has Str $.throws;
}
