module {
  public type Animal = {
    specie       : Text;
    energy        : Nat;
  };

  //Challenge 3 : In animal.mo create a public function called animal_sleep that takes an Animal and returns the same Animal where the field energy has been increased by 10.
  public func animal_sleep(animal : Animal) : Animal {
    let temp_animal : Animal = {
      specie = animal.specie;
      energy = (animal.energy + 10);
    };
    return temp_animal;
  };
};
