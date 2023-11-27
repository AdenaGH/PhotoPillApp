import 'drug.dart';
//export based on size requires dependency : "collection: ^1.14.13"

class ReferenceList {
  //  static rank map
  static Map rankMap = {"rank0" : <Drug>[],
                        "rank1" : <Drug>[],
                        "rank2" : <Drug>[],
                        "rank3" : <Drug>[],
                        "rank4" : <Drug>[]};
  
  //  fetch drug list
  //  @aipMap Map constructed by api requests
  //  @return a list of drug object
  static List<Drug> fetch(Map apiMap) {
    var drugs;
    Set checked = {};
    try {
      drugs = apiMap["ndcPropertyList"]["ndcProperty"];
    } catch (e) {
      throw const FormatException('api data not formated correctly');
    }
    if  (drugs.isEmpty) {
      throw const FormatException('empty api data');
    }
    List<Drug> drugList = <Drug>[];
    for (Map item in drugs) {
      if (item.keys.isEmpty) {
        continue;
      }
      String id = item["rxcui"];
      String color = "";
      String shape = "";
      String size = "";
      try {
        if (!checked.contains(id)) {
          var propertyList = item["propertyConceptList"]["propertyConcept"];
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
          checked.add(id);
        }
      } catch (e) {
        print("drug omitted: $id");
        continue;
      }
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
    List<Drug> list = <Drug>[];
    if (rankMap["rank4"].length != 0) {
      List temp = rankMap["rank4"];
      for (var item in temp) {
        list.add(item);
      }
    }
    if (rankMap["rank3"].length != 0) {
      List temp = rankMap["rank3"];
      for (var item in temp) {
        list.add(item);
      }
    }
    if (rankMap["rank2"].length != 0) {
      List temp = rankMap["rank2"];
      for (var item in temp) {
        list.add(item);
      }
    }
    if (rankMap["rank1"].length != 0) {
      List temp = rankMap["rank1"];
      for (var item in temp) {
        list.add(item);
      }
    }
    return list;
  }
}
