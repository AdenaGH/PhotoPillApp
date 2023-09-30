class Drug implements Comparable<Drug>{
    String name = "DEFAULT";
    String color = "DEFAULT";
    String shape = "DEFAULT";
    String size = "DEFAULT";
    int priority = 0;

    Drug(this.name, this.color, this.shape, this.size);

    void displayInfo() {
        print('Drug Name: $name');
        print('Color: $color');
        print('Shape: $shape');
        print('Size: $size');
    }
  
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