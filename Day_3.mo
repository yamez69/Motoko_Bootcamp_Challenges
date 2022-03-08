import Array "mo:base/Array";
import Iter  "mo:base/Iter";

actor {

  //Challenge 1: Create an add function
  public func add(n : Nat, m : Nat) : async Nat {
    return (n + m);
  };

  //Challenge 2: Create a square function
  public func square(n : Nat) : async Nat {
    return (n * n);
  };

  //Challenge 3: Create a days_to_second function
  public func days_to_seconds(n : Nat) : async Nat {
    //One day in terms of seconds can be calculated as 24 hours/day x 60 minutes/hour x 60 seconds/minute
    return (n * 24 * 60 * 60);
  };

  //Challenge 4: Create increment_counter & clear_counter functions
  var counter : Nat = 0;

  public func increment_counter(n : Nat) : async Nat {
    counter += n;
    return counter;
  };
  public func clear_counter() : async () {
    counter := 0;
  };

  //Challenge 5: Create a divide function returning a bool indicating if 2 natural numbers can divide by one another
  public func divide(n : Nat, m : Nat) : async Bool {
    if(n % m == 0) {
      return true;
    } else {
      return false;
    };
  };

  //Challenge 6: Create is_even function that determines if the number input is even
  public func is_even(n : Nat) : async Bool {
    if(n % 2 == 0) {
      return true;
    } else {
     return false; 
    };
  };

  //Challenge 7: Write a function sum_of_array that takes an array of natural numbers and returns the sum. This function will returns 0 if the array is empty.
  public func sum_of_array(array : [Nat]) : async Nat {
    var sum : Nat = 0;

    for (value in array.vals()) {
      sum += value;
    };

    return sum;
  };

  //Challenge 8: Write a function maximum that takes an array of natural numbers and returns the maximum value in the array. This function will returns 0 if the array is empty.
  public func maximum(array : [Nat]) : async Nat {
    var max : Nat = 0;

    for (value in array.vals()) {
      if(value > max) max := value;
    };

    return max;
  };

  //Challenge 9: Write a function remove_from_array that takes 2 parameters : an array of natural numbers and a natural number n and returns a new array where all occurences of n have been removed (order should remain unchanged).
  public func remove_from_array(array : [Nat], n : Nat) : async [Nat] {
    var counter : Nat = 0;

    for(value in array.vals()) {
      if(value != n) {
        counter += 1;
      };
    };

    let tmp_array : [var Nat] = Array.init<Nat>(counter, 0);
    counter := 0;

    for(value in array.vals()) {
      if(value != n) {
        tmp_array[counter] := value;
        counter += 1;
      };
    };
    
    let new_array : [Nat] = Array.freeze(tmp_array);
    return new_array;
  };

  //Challenge 10: Implement a function selection_sort that takes an array of natural numbers and returns the sorted array 
  public func selection_sort(array : [Nat]) : async [Nat] {
    var counter : Nat = 0;
    var temp : Nat = 0;
    var i : Nat = 0;
    var j : Nat = 0;
    for(value in array.vals()) counter += 1;
    //Check if array has only one value, meaning it cannot be sorted, and returns the array if the condition is met
    if (counter < 2) return array;

    let tmp_array : [var Nat] = Array.thaw(array);
    let size : Nat = counter - 1;

    for (i in Iter.range(0, size)) {
      var min : Nat = i;
      
      for (j in Iter.range(i + 1, size)) {
        if(tmp_array[min] > tmp_array[j]){
          min := j;
        };

        if(min != i) {
          temp := tmp_array[i];
          tmp_array[i] := tmp_array[min];
          tmp_array[min] := temp;
        };
      };
    };

    let new_array : [Nat] = Array.freeze(tmp_array);
    return new_array;
  };
  
};
