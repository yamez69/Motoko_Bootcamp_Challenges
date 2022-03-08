import Nat8 "mo:base/Nat8";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Nat32 "mo:base/Nat32";
import Iter  "mo:base/Iter";
import Blob "mo:base/Blob";
import Array "mo:base/Array";

actor {
  //Challenge 1: Write a function nat_to_nat8 that converts a Nat n to a Nat8. Make sure that your function never trap.
  public func nat_to_nat8(n : Nat) : async Nat8 {
    return (Nat8.fromNat(n));
  };

  //Challenge 2: Write a function max_number_with_n_bits that takes a Nat n and returns the maximum number than can be represented with only n-bits.
  public func max_number_with_n_bits(n : Nat) : async Nat {
    return ((2 ** n) - 1);
  };

  //Challenge 3: Write a function decimal_to_bits that takes a Nat n and returns a Text corresponding to the binary representation of this number.
  public func decimal_to_bits(n : Nat) : async Text {
    var value : Nat = n;
    var bits : Text = "";

    while (value != 0) {
      let tmp : Text = Nat.toText(value % 2);
      bits := Text.concat(tmp, bits);
      value := value / 2;
    };
    return bits;
  };

  //Challenge 4 : Write a function capitalize_character that takes a Char c and returns the capitalized version of it.
  public func capitalize_character(c : Char) : async Text {
    var tmp_num : Nat32 = Char.toNat32(c);
    tmp_num := tmp_num - 32;
    let tmp_char : Char = Char.fromNat32(tmp_num);
    return (Char.toText(tmp_char));
  };

  //Challenge 5: Write a function capitalize_text that takes a Text t and returns the capitalized version of it.
  public func capitalize_text(t : Text) : async Text {
    var tmp : Text = "";
    for (char in t.chars()) {
      var tmp_num : Nat32 = Char.toNat32(char);
      tmp_num := tmp_num - 32;
      let cap : Char = Char.fromNat32(tmp_num);
      tmp := Text.concat(tmp, Text.fromChar(cap))
    };
    return tmp;
  };

  //Challenge 6: Write a function is_inside that takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .
  public func is_inside(t : Text, c : Char) : async Bool {
    for (char in t.chars()) {
      if (c == char) return true;
    };
    return false;
  };

  //Challenge 7: Write a function trim_whitespace that takes a text t and returns the trimmed version of t. Note
  public func trim_whitespace(t : Text) : async Text {
    var tmp : Text = t;
    var whitespace : Text = Text.fromChar(' ');
    tmp := Text.trim(t, #text(whitespace));
    return tmp;
  };

  //Challenge 8: Write a function duplicated_character that takes a Text t and returns the first duplicated character in t converted to Text.
  public func duplicated_character(t : Text) : async Text {
    var tmp1 : Char = ' ';
    var tmp2 : Char = ' ';
    var counter : Nat = 0;
    let tmp : Text = t;
    //var j : Nat = 0;
    //let size : Nat = t.chars();
    for (char1 in t.chars()) {
      tmp1 := char1;
      if (counter > 0) {
        for (char2 in tmp.chars()) {
          tmp2 := char2;
          if (tmp1 == tmp2) return Char.toText(char2);

        };
      };
      
      counter += 1;
    };
    return t;
  };

  //Challenge 9: Write a function size_in_bytes that takes Text t and returns the number of bytes this text takes when encoded as UTF-8.
  public func size_in_bytes(t : Text) : async Nat {
    let utf8 : Blob = Text.encodeUtf8(t);
    return utf8.size();
  };

  //Implement a function bubble_sort that takes an array of natural numbers and returns the sorted array
  public func bubble_sort(array : [Nat]) : async [Nat] {
    var temp : Nat = 0;
    var i : Nat = 0;
    let size : Nat = array.size();
    //Check if array has only one value, meaning it cannot be sorted, and returns the array if the condition is met
    if (size < 2) return array;

    let tmp_array : [var Nat] = Array.thaw(array);
    
    while (i < (size - 1)) {
      var j : Nat = 0;

      while (j < (size - i - 1)) {
        if (tmp_array[j] > tmp_array[j + 1]) {

          temp := tmp_array[j];
          tmp_array[j] := tmp_array[j + 1];
          tmp_array[j + 1] := temp;

        };

        j += 1;
      };

      i += 1;
    };

    let new_array : [Nat] = Array.freeze(tmp_array);
    return new_array;
  };

};
