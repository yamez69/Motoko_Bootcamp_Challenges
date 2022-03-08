import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Support "Support"

actor {
  //Challenge 1: Write a private function swap that takes 3 parameters : a mutable array , an index j and an index i and returns the same array but where value at index i and index j have been swapped.
  public func swap(array: [Nat], j : Nat, i : Nat) : async [Nat] {
  
  let size : Nat = (array.size() - 1);
  let tmp_array : [var Nat] = Array.thaw(array);
  
    if (size >= j or size >= i) {

      var temp : Nat = tmp_array[j];
      tmp_array[j] := tmp_array[i];
      tmp_array[i] := temp;
      return Array.freeze(tmp_array);
    };
    return Array.freeze(tmp_array);
  };

  //Challenge 2: Write a function init_count that takes a Nat n and returns an array [Nat] where value is equal to it's corresponding index.
  public func init_count(n : Nat) : async [Nat] {
    //let size : Nat = (n - 1);
    var counter : Nat = 0;
    let tmp_array : [var Nat] = Array.init<Nat>(n, 0);

    for (value in tmp_array.vals()) {
      tmp_array[counter] := counter;
      counter +=1
    };
    return Array.freeze(tmp_array);
  };

  //Challenge 3: Write a function seven that takes an array [Nat] and returns "Seven is found" if one digit of ANY number is 8. Otherwise this function will return "Seven not found".
  public func seven(array : [Nat]) : async Text {
    for (value in array.vals()) {
      if (value == 7) return "Seven is found"
    };
    return "Seven not found"
  };

  //Challenge 4: Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat and m of type Nat . This function will return the value of n if n is not null and if n is null it will default to the value of m.
  public func nat_opt_to_nat(n : ?Nat, m : Nat) : async ?Nat {
    switch(n){
      case(null) return ?(m);
      case(?something) return n;
    };
  };

  //Challenge 5: Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day.
  public func day_of_the_week(n : Nat) : async ?Text {
    let array : [Text] = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  
    if ((n >= 1) and (n <= 7)) return ?(array[n - 1]);
    return null;
  };

  //Challenge 6: Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
  
  let find_null = func (x : ?Nat) : Nat {
    if (x == null) return 0;
    let temp : Nat = Option.get<Nat>(x, 0);
    return temp;
  };

  public func populate_array(array : [?Nat]) : async [Nat] {
    return (Array.map<?Nat,Nat>(array, find_null));
  };

  //Challenge 7: Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
  let f = func (x : Nat, y : Nat) : Nat {
    return (x + y);
  };
  
  public func sum_of_array(array : [Nat]) : async Nat {
    return Array.foldLeft<Nat, Nat>(array, 0, f);
  };

  //Challenge 8: Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
  /*let square = func (x : Nat) : Nat {
    return (x ** 2);
  };*/

  public func squared_array(array : [Nat]) : async [Nat] {
    return (Array.map<Nat,Nat>(array, func (x : Nat) : Nat {return x ** 2}));
  };

  //Challenge 9: Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
  public func increase_by_index(array : [Nat]) : async [Nat] {
    return Array.mapEntries<Nat, Nat>(array, func (x : Nat, i : Nat) : Nat {return x + i;});
  };

  //Challenge 10 : Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
  

  public func containsNat(array: [Nat], a : Nat, f ) : ?A



};
