use v6.c;

unit class Test::Declarative::Expectations;

class Roughly {
    has Sub $.op is default(&[eqv]);
    has $.rhs is required;
    has $!comparison = $!op.assuming(*, $!rhs);

    method compare($got) {
        return $!comparison($got);
    }
}

sub make-rough($rv) {
    if $rv.isa('Test::Declarative::Expectations::Roughly') {
        return $rv;
    }
    return Roughly.new(rhs=>$rv);
}

has $.stdout;
has $.stderr;

has $.return-value;
has $.mutates;

has $.lives;
has $.dies;
has $.throws;

submethod BUILD(:$stdout, :$stderr, :$return-value, :$mutates, :$!lives, :$!dies, :$!throws) {
    if $stdout {
        $!stdout = make-rough($stdout);
    }
    if $stderr {
        $!stderr = make-rough($stderr);
    }
    if $return-value {
        $!return-value = make-rough($return-value);
    }
    if $mutates {
        $!mutates = make-rough($mutates);
    }
}
