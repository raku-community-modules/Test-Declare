use v6.c;

class Test::Declarative::Result {
    has Str $.status is rw;
    has %.streams is rw;
    has Exception $.exception is rw;
    has Any $.return-value is rw;
}
