import 'drug.dart';

//  cross-reference check to determain what's the most likely drug in the list
//  @drugList   a list of drugs to check, mush fetch drug object before hands
//  @target     user input, property of the drug that's been searched
//  @return     a map of lists of drugs based on priority
Map<String, List<Drug>> crossReference(List<Drug> drugList, Drug target) {
    Map<String, List<Drug>> priorityMap = {
      "noMatch" : [],
      "priority1" : [],
      "priority2" : [],
      "priority3" : [],
      "priority4" : []
    };
    for (Drug drug : drugList) {
      if (drug.priority < 0) {
        drug.compare();
      }
      switch (drug.priority) {
        case 0:
          priorityMap["noMatch"].add(drug);
          break;
        case 1:
          priorityMap["priority1"].add(drug);
          break;
        case 2:
          priorityMap["priority2"].add(drug);
          break;
        case 3:
          priorityMap["priority3"].add(drug);
          break;
        case 4:
          priorityMap["priority4"].add(drug);
          break;
      }
    }
    return priorityMap;
}