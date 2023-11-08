import 'drug.dart';
//export based on size requires dependency : "collection: ^1.14.13"
import 'package:collection/collection.dart';

class ReferenceList {
  //  static rank map
  static Map rankMap = {"rank0" : [],
                        "rank1" : [],
                        "rank2" : [],
                        "rank3" : [],
                        "rank4" : []};

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
    rankMap = {"rank0" : [],
              "rank1" : [],
              "rank2" : [],
              "rank3" : [],
              "rank4" : []};
  }
}