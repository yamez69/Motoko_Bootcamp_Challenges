import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import List "mo:base/List";
import HTTP "http";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

actor {
  //Challenge 1 : Create an actor in main.mo and declare the following types - TokenIndex of type Nat & Error which is a variant type with multiples tags :
  type TokenIndex = Nat;
  public type Error = {
    #err_1 : Text;
    #err_2 : Text;
    #err_3 : Text;
  };

  //Challenge 2 : Declare an HashMap called registry with Key of type TokenIndex and value of type Principal. This will keeep track of which principal owns which TokenIndex.
  let registry = HashMap.HashMap<TokenIndex, Principal> (0, Nat.equal, Hash.hash);

  //Challenge 3 : Declare a variable of type Nat called nextTokenIndex, initialized at 0 that will keep track of the number of minted NFTs.
  //Write a function called mint that takes no argument. This function should : Returns a result of type Result and indicate an error in case the caller is anonymous. If the user is authenticated : associate the current TokenIndex with the caller (use the HashMap we've created) and increase nextTokenIndex.
  var nextTokenIndex : Nat = 0;

  public shared ({caller}) func mint() : async Result.Result<(), Text> {
    if (Principal.isAnonymous(caller)) {
        return #err("You need to be authenticated");
    } else {
      registry.put(nextTokenIndex, caller);
      nextTokenIndex += 1;
      return #ok;
    };
  };

  //Challenge 4 : Write a function called transfer that takes two arguments : to of type Principal & tokenIndex of type Nat.
  public shared ({caller}) func transfer(to : Principal, TokenIndex : Nat) : async Result.Result<(), Text> {
    switch (Principal.isAnonymous(caller)) {
      case (true) return #err("You need to be authenticated");
      case (false) {
        switch (registry.get(TokenIndex)) {
          case (?Principal) return #err("You are not the owner of this");
          case (caller) {
            registry.put(TokenIndex, to);
            return #ok;
          };
        }
      };
      //case (_) return #err("Unexpected error");
    }
  };

  //Challenge 5 : Write a function called balance that takes no arguments but returns a list of tokenIndex owned by the called.
  public shared ({caller}) func balance() : async List.List<Nat> {
    var balance : List.List<Nat> = null;
    /*for ((k, v) in registry.entries()) {
      if (v == caller) {
        balance := List.push<Nat>(k, balance);
      };
    return balance;
    };*/
    let filtered = HashMap.mapFilter<Nat,Principal,Principal>(registry, Nat.equal, Hash.hash, func(k : Nat, v : Principal): ?Principal { if (v == caller) ?v else null});
    for (value in filtered.keys()) {
      balance := List.push<Nat>(value, balance);
    };
    return balance;
  };

  //Challenge 6 : Write a function called http_request that should return a message indicating the number of nft minted so far and the principal of the latest minter. (Use the section on http request in the daily guide).
  public query func http_request(request : HTTP.Request) : async HTTP.Response {
    let amount : Nat = registry.size();
  
    switch (registry.get(amount)) {
      case (null) {
        let response = {
          body = Text.encodeUtf8("No NFTs have been minted so far!");
          headers = [("Content-Type", "text/html; charset=UTF-8")];
          status_code = 200 : Nat16;
          streaming_strategy = null;
        };
        return response;
      };
      case (_) {
        let total : Text = Nat.toText(amount);
        var lastID : Principal = Principal.fromText("2vxsx-fae");
        for (value in registry.vals()) {
          lastID := value;
        };
        let response = {
          body = Text.encodeUtf8( total # " NFTs have been minted so far! The latest NFT was minted by " # Principal.toText(lastID));
          headers = [("Content-Type", "text/html; charset=UTF-8")];
          status_code = 200 : Nat16;
          streaming_strategy = null;
        };
        return response;
      };
    }
  };

  //Challenge 7 : Modify the actor so that you can safely upgrade it without loosing any state.
  private stable var registryEntries : [(TokenIndex, Principal)] = [];
 
  private let finalRegistry : HashMap.HashMap<TokenIndex, Principal> = HashMap.fromIter<TokenIndex, Principal>(registry.entries(), 10, Nat.equal, Hash.hash);
  
  system func preupgrade() {
    registryEntries := Iter.toArray(finalRegistry.entries());
	};
	
	system func postupgrade() {
    registryEntries := [];
	};

};
