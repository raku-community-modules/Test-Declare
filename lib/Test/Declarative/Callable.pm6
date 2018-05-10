use v6.c;

class Test::Declarative::Callable {
    has Str $.class is required;
    has Str $.method is required;
    has Capture $.construct;
    has $.obj = self.construct ?? ::($!class).new(|self.construct)
                               !! ::($!class).new();

    has $.args is rw;

    method call() {
        return self.args ?? self.obj."$!method"(|self.args) !! self.obj."$!method"();
    }
}
