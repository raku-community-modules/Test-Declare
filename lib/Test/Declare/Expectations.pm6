use v6.c;

unit class Test::Declare::Expectations;

class Roughly {
    # transparaently to the user, everything is actually a 'rough'
    # ccmparison - but our default operator is eqv.
    has Sub $.op is default(&[eqv]);
    has $.rhs is required;

    # curry the actual comparison, ready for performing it. there
    # may be no point in doing this, but I'm still learning Perl6
    # and like to leave things like this around to remind me of
    # features.
    has $!comparison = $!op.assuming(*, $!rhs);

    method compare($got) {
        return $!comparison($got);
    }
}

sub make-rough($rv) {
    $rv.isa('Test::Declare::Expectations::Roughly')
        ?? $rv
        !! Roughly.new(rhs=>$rv)
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
