import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";

actor {
  //Challenge 9 : In a new file, copy and paste the functionnalities you've created in challenges 2 to 5. This time the hashmap and all records should be preserved accross upgrades.
  var favoriteNumber = HashMap.HashMap<Principal, Nat> (0, Principal.equal, Principal.hash);
  stable var entries : [(Principal, Nat)] = [];

  public shared({caller}) func show_favorite_number() : async ?Nat {
    return (favoriteNumber.get(caller));
  };

    public shared({caller}) func add_favorite_number(n : Nat) : async Text {
    if (favoriteNumber.get(caller) == null) {
      favoriteNumber.put(caller, n);
      return "You've successfully registered your number";
    };
    return "You've already registered your number";
  };

  public shared({caller}) func update_favorite_number(n : Nat) : async ?Nat {
      return favoriteNumber.replace(caller, n);
  };

  public shared({caller}) func delete_favorite_number() : async () {
    favoriteNumber.delete(caller);
  };

  system func preupgrade() {
    entries := Iter.toArray(favoriteNumber.entries());
  };

  system func postupgrade() {
    favoriteNumber := HashMap.fromIter<Principal, Nat>(entries.vals(), 0, Principal.equal, Principal.hash);
    entries := [];
  };

};
