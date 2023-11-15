import 'drug.dart';
//export based on size requires dependency : "collection: ^1.14.13"

class ReferenceList {
  //  static rank map
  static Map rankMap = {
    "rank0": [],
    "rank1": [],
    "rank2": [],
    "rank3": [],
    "rank4": []
  };

  //  fetch drug list
  //  @aipMap Map constructed by api requests
  //  @return a list of drug object
  static List<Drug> fetch(Map apiMap) {
    var drugs = apiMap["ndcPropertyList"]["ndcProperty"];
    print("Printed drugs: " + drugs);
    List<Drug> drugList = List<Drug>.empty(growable: true);
    for (var item in drugs) {
      String id = item["rxcui"];
      var propertyList = item["propertyConceptList"]["propertyConcept"];
      String color = "";
      String shape = "";
      String size = "";
      for (var concept in propertyList) {
        if (concept["propName"] == "COLORTEXT") {
          color = concept["propValue"];
        }
        if (concept["propName"] == "SHAPETEXT") {
          shape = concept["propValue"];
        }
        if (concept["propName"] == "SIZE") {
          size = concept["propValue"];
        }
      }
      drugList.add(Drug("", id, color, shape, size));
    }
    return drugList;
  }

  //  build rank map
  //  @drugList           the referencing list
  //  @target             target drug
  //  @return             the rank map
  static Map build(List<Drug> drugList, Drug target) {
    clean();
    for (Drug drug in drugList) {
      drug.getRank(target);
      if (drug.rank == -1) {
        throw const FormatException('rank not acquired.');
      }
      if (drug.rank == 0) {
        rankMap["rank0"].add(drug);
      }
      if (drug.rank == 1) {
        rankMap["rank1"].add(drug);
      }
      if (drug.rank == 2) {
        rankMap["rank2"].add(drug);
      }
      if (drug.rank == 3) {
        rankMap["rank3"].add(drug);
      }
      if (drug.rank == 4) {
        rankMap["rank4"].add(drug);
      }
    }
    return rankMap;
  }

  // clean rank map
  static void clean() {
    rankMap = {"rank0": [], "rank1": [], "rank2": [], "rank3": [], "rank4": []};
  }

  // export result
  static List<Drug> export() {
    List<Drug> list = List<Drug>.empty();
    if (rankMap["rank4"].length != 0) {
      list.addAll(rankMap["rank4"]);
    }
    if (rankMap["rank3"].length != 0) {
      list.addAll(rankMap["rank3"]);
    }
    if (rankMap["rank2"].length != 0) {
      list.addAll(rankMap["rank2"]);
    }
    if (rankMap["rank1"].length != 0) {
      list.addAll(rankMap["rank1"]);
    }
    return list;
  }
}
