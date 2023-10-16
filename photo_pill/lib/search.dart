import 'drug.dart';

class PriorityMap {
    Map<String, List<Drug>> map = {
        "noMatch" : List<Drug>.empty(),
        "priority1" : List<Drug>.empty(),
        "priority2" : List<Drug>.empty(),
        "priority3" : List<Drug>.empty()
    };
    bool isEmpty = true;

    //  constructor
    //  run search by default
    PriorityMap(List<Drug> drugList, Drug target) {
        map = crossReference(drugList, target);
        isEmpty = false;
    }

    //  update map with new input, start fresh
    //  @drugList   a list of drugs to check, mush fetch drug object before hands
    //  @target     user input, property of the drug that's been searched
    void update(List<Drug> drugList, Drug target) {
        map = crossReference(drugList, target);
        isEmpty = false;
    }

    //  append new input the the map
    //  @drugList   a list of drugs to check, mush fetch drug object before hands
    //  @target     user input, property of the drug that's been searched
    void append(List<Drug> drugList, Drug target) {
        if (isEmpty) {
            update(drugList, target);
        }
        for (Drug drug in drugList) {
            if (drug.priority < 0) {
                drug.compare(target);
            }
            List<Drug> list;
            switch (drug.priority) {
                case 1:
                    list = map["priority1"];
                    break;
                case 2:
                    list = map["priority2"];
                    break;
                case 3:
                    list = map["priority3"];
                    break;
                default:
                    list = map["noMatch"];
                    break;
            }
            bool flag = true;
            for (Drug existed in list) {
                if (existed.compare(drug) == 3) {
                    flag = false;
                }
            }
            if (flag) {
                drug.compare(target);
                list.add(drug);
            }
        }
    }
    
    //  clean map
    void clean() {
        map = {
        "noMatch" : List<Drug>.empty(),
        "priority1" : List<Drug>.empty(),
        "priority2" : List<Drug>.empty(),
        "priority3" : List<Drug>.empty()
        };
        isEmpty = true;
    }
}


//  cross-reference check to determain what's the most likely drug in the list
//  @drugList   a list of drugs to check, mush fetch drug object before hands
//  @target     user input, property of the drug that's been searched
//  @return     a map of lists of drugs based on priority
Map<String, List<Drug>> crossReference(List<Drug> drugList, Drug target) {
    Map<String, List<Drug>> priorityMap = {
        "noMatch" : List<Drug>.empty(),
        "priority1" : List<Drug>.empty(),
        "priority2" : List<Drug>.empty(),
        "priority3" : List<Drug>.empty()
    };
    List<Drug> list1 = [];
    List<Drug> list2 = [];
    List<Drug> list3 = [];
    List<Drug> list0 = [];
    if (drugList.isEmpty) {
      return priorityMap;
    }
    for (Drug drug in drugList) {
        if (drug.priority < 0) {
            drug.compare(target);
        }
        switch (drug.priority) {
            case 1:
                list1.add(drug);
                break;
            case 2:
                list2.add(drug);
                break;
            case 3:
                list3.add(drug);
                break;
            default:
                list0.add(drug);
                break;
        }
    }
    priorityMap["noMatch"] = list0;
    priorityMap["priority1"] = list1;
    priorityMap["priority2"] = list2;
    priorityMap["priority3"] = list3;
    return priorityMap;
}