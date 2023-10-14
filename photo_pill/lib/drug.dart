class Drug implements Comparable<Drug>{
    //attributes are set to "DEFAULT" by default
    String name = "DEFAULT";
    String color = "DEFAULT";
    String shape = "DEFAULT";
    String size = "DEFAULT";
    int priority = -1;

    //  constructor
    //  make sure to pass in "DEFAULT" if user input is empty
    Drug(this.name, this.color, this.shape, this.size);

    //  display current info
    void displayInfo() {
        print('Drug Name: $name');
        print('Color: $color');
        print('Shape: $shape');
        print('Size: $size');
    }
  
    //  compare drug with target drug, set priority accordingly
    //  @otherDrug      the target drug from user input
    //  @return         the priority of current drug
    int compare(Drug otherDrug) {
        int temp = 0;
        if (name == otherDrug.name) {
        temp++;
        }
        if (color == otherDrug.color) {
        temp++;
        }
        if (shape == otherDrug.shape) {
        temp++;
        }
        if (size == otherDrug.size) {
        temp++;
        }
        priority = temp;
        return temp;
    }
    
    //  compare 2 drugs based on their similarity to target drug (i.e., priority)
    //  @otherDrug      another Drug on the cross-referencing list
    //  @return         if this drug has more priority
    @override
    int compareTo(Drug otherDrug) {
        if (priority > otherDrug.priority) {
          return 1;
        } else if (priority < otherDrug.priority) {
          return -1;
        } else {
          return 0;
        }
    }
}