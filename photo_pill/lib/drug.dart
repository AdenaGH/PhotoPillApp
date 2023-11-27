
class Drug implements Comparable<Drug> {
  //  attributes are set to "DEFAULT" by default
  String name = "DEFAULT";
  String id = "DEFAULT";
  String color = "DEFAULT";   //{"propName":"COLORTEXT","propValue":"WHITE"}
  String shape = "DEFAULT";   //{"propName":"SHAPETEXT","propValue":"barrel shaped"}
  String size = "DEFAULT";    //{"propName":"SIZE","propValue":"11 mm"}
  int rank = -1;

  //  constructor
  Drug.empty();
  //  pass in "" if empty input
  Drug(String name, String id, String color, String shape, String size) {
    if (name.isNotEmpty) {
      this.name = name;
    }
    if (id.isNotEmpty) {
      this.id = id;
    }
    if (color.isNotEmpty) {
      this.color = color;
    }
    if (shape.isNotEmpty) {
      this.shape = shape;
    }
    if (size.isNotEmpty) {
      this.size = size;
    }
  }

  //  get & set rank
  //  @target       target drug
  int getRank(Drug target) {
    int temp = 0;
    if (target.name != "DEFAULT" && target.name == name) {
      temp++;
    } else if (target.id != "DEFAULT" && target.id == id) {
      temp++;
    }
    if (target.color != "DEFAULT" && target.color == color) {
      temp++;
    }if (target.shape != "DEFAULT" && target.shape == shape) {
      temp++;
    }if (target.size != "DEFAULT" && target.size == size) {
      temp++;
    }
    rank = temp;
    return rank;
  }

  //  compareTo based on rank
  //  @drug         another drug in the referencing list
  //  @return       1 with higher rank, 0 with same rank, -1 with lower rank
  //  @exception    if any of the 2 drugs in comparison has no rank, throw exception
  @override
  int compareTo(Drug drug) {
    if (rank == -1 || drug.rank == -1) {
      throw const FormatException('rank not acquired.');
    }
    if (rank > drug.rank) {
      return 1;
    } else if (rank < drug.rank) {
      return -1;
    } else {
      return 0;
    }
  }
  
  //  print all info
  //  @return     all existing info of current drug
  String info() {
    String s = "";
    if (name != "DEFAULT") {
      s += "Name: $name\t";
    }
    if (id != "DEFAULT") {
      s += "ID: $id\t";
    }
    if (color != "DEFAULT") {
      s += "Color: $color\t";
    }
    if (shape != "DEFAULT") {
      s += "Shape: $shape\t";
    }
    if (size != "DEFAULT") {
      s += "Dosage: $size\t";
    }
    if (s.isEmpty) {
      return "Empty info";
    }
    return s;
  }
}

