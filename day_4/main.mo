import C "custom";
import A "animal";
import List "mo:base/List";
import Array "mo:base/Array";

actor {
  //Challenge 1: Create two files called custom.mo and main.mo, create your own type inside custon.mo and import it in your main.mo file. In main, create a public function fun that takes no argument but return a value of your custom type.
  public func fun() : async C.Person {
    let person : C.Person = {
      name = "John Doe";
      age = 29;
      hair_color = "Black";
    };
    return person;
  };

  //Challenge 2: Create a new file called animal.mo with at least 2 property (specie of type Text, energy of type Nat), import this type in your main.mo and create a variable that will store an animal.
  var animal_variable : A.Animal = {
    specie = "Jaguar";
    energy = 5;
  };

  //Challenge 4: In main.mo create a public function called create_animal_then_takes_a_break that takes two parameter : a specie of type Text, an number of energy point of type Nat and returns an animal.
  public func create_animal_then_takes_a_break(s : Text, e : Nat) : async A.Animal {
    let new_animal : A.Animal = {
      specie = s;
      energy = e;
    };
    return A.animal_sleep(new_animal)
  };

  //Challenge 5: In main.mo, import the type List from the base Library and create a list that stores animal.
  var animal_list : List.List<A.Animal> = List.nil<A.Animal>();
  
  //Challenge 6 : In main.mo, create a function called push_animal that takes an animal as parameter and returns nothing this function should add this animal to your list created in challenge 5. Then create a second functionc called get_animals that takes no parameter but returns an Array that contains all animals stored in the list.
  public func push_animal(a : A.Animal) : async () {
    animal_list := List.push<A.Animal>(a, animal_list);
  };
  
  public func get_animals() : async [A.Animal] {
    return List.toArray<A.Animal>(animal_list);
  };

  
};
