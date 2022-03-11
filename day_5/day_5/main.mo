import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";

actor {
  //Challenge 1 : Write a function is_anonymous that takes no arguments but returns true is the caller is anonymous and false otherwise.
  public shared({caller}) func is_anonymous() : async Bool {
    return Principal.isAnonymous(caller);
  };

  //Challenge 2 : Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
  let favoriteNumber = HashMap.HashMap<Principal, Nat> (0, Principal.equal, Principal.hash);

  //Challenge 3 : Write two functions - add_favorite_number that takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller. This function has no return value. Show_favorite_number that takes no argument and returns n of type ?Nat, n is the favorite number of the person as defined in the previous function or null if the person hasn't registered.
  //public shared({caller}) func add_favorite_number(n : Nat) : async () {
  //  favoriteNumber.put(caller, n);
  //};

  public shared({caller}) func show_favorite_number() : async ?Nat {
    return (favoriteNumber.get(caller));
  };

  //Challenge 4 : Rewrite your function add_favorite_number so that if the caller has already registered his favorite number, the value in memory isn't modified. This function will return a text of type Text that indicates "You've already registered your number" in that case and "You've successfully registered your number" in the other scenario.
  public shared({caller}) func add_favorite_number(n : Nat) : async Text {
    if (favoriteNumber.get(caller) == null) {
      favoriteNumber.put(caller, n);
      return "You've successfully registered your number";
    };
    return "You've already registered your number";
  };

  //Challenge 5 : Write two functions update_favorite_number & delete_favorite_number
  public shared({caller}) func update_favorite_number(n : Nat) : async ?Nat {
      return favoriteNumber.replace(caller, n);
  };

  public shared({caller}) func delete_favorite_number() : async () {
    favoriteNumber.delete(caller);
  };

  //Challenge 6 : Write a function deposit_cycles that allow anyone to deposit cycles into the canister. This function takes no parameter but returns n of type Nat corresponding to the amount of cycles deposited by the call.
  public func deposit_cycles() : async Nat {
    let amount : Nat = Cycles.available();
    return Cycles.accept(amount);
  };

  //Challenge 7 : Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the number of cycles you want to withdraw from the canister and send it to caller asumming the caller has a callback called deposit_cycles()
  /*let owner = msg.caller;
  public shared({caller}) func withdraw_cycles(n : Nat) : async () {

  };*/

  //Challenge 8 : Rewrite the counter (of day 1) but this time the counter will be kept accross ugprades. Also declare a variable of type **Nat¨¨ called version_number that will keep track of how many times your canister has been upgraded.
  stable var counter : Nat = 0;

  public func increment_counter(n : Nat) : async Nat {
    counter += n;
    return counter;
  };
  public func clear_counter() : async () {
    counter := 0;
  };


};
