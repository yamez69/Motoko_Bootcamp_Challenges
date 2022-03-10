module {
  //Challenge 7: Write a function is_null that takes l of type List<T> and returns a boolean indicating if the list is null .

  public type List<T> = ?(T, List<T>);
  
  //Challenge 8 : Write a function last that takes l of type List<T> and returns the optional last element of this list
  public func last<T> (l : List<T>) : ?T {
    switch(l) {

      case(null) {null};
      case(?(x, null)) {?x};
      case(?(_, t)) {last<T>(t)};

    }
  };

  //Challenge 9 : Write a function size that takes l of type List<T> and returns a Nat indicating the size of this list.
  public func size<T> (l : List<T>) : Nat {
    func f(l : List<T>, n : Nat) : Nat {
      switch(l) {

        case(null) {0};
        case(?(_, t)) {f(t, n + 1)};

      }
    };
    f(l, 0)
  };

  //Challenge 10 : Write a function get that takes two arguments : l of type List<T> and n of type Nat this function should return the optional value at rank n in the list.
  public func get<T> (l : List<T>, n : Nat) : ?T {
    switch(l, n) {

      case (null, _) {null};
      case ( (?(h, t)), 0 ) {?h};
      case ( (?(_, t)), _) {get<T>(t, (n - 1))};

    }
  };

  //Challenge 11 : Write a function reverse that takes l of type List and returns the reversed list.
  public func reverse<T> (l : List<T>) : List<T> {
    func f(l : List<T>, l2 : List<T>) : List<T> {
      switch(l) {

        //case(null) {l2};
        //case(?(h, t)) {f(t, ?(h, l2))};

      }
    };
    f(l, null)
  };

};
