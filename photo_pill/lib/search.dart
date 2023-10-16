import 'drug.dart';
//export based on size requires dependency : "collection: ^1.14.13"
import 'package:collection/collection.dart';

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

    //  export the result in order
    //  1st order: priority
    //  2nd order: size "large" "small"
    //  @sizeText   patient's input
    //  @return a list of drug
    List<Drug> export(String sizeText) {
        if (sizeText == "small") {
            return sortSmall();
        } else if (sizeText == "large") {
            return sortLarge();
        } else {
            return [];//"mid" in progress
        }
    }

    //  export the result in min order
    //  1st order: priority
    //  2nd order: size "small"
    //  @return a list of drug
    List<Drug> sortSmall() {
        List<Drug> list = List<Drug>.empty();
        list.addAll(sortSmallHelper(map["priority3"]));
        list.addAll(sortSmallHelper(map["priority2"]));
        list.addAll(sortSmallHelper(map["priority1"]));
        list.addAll(sortSmallHelper(map["noMatch"]));
        return list;
    }

    //Helper
    List<Drug> sortSmallHelper(List<Drug> priorityList) {
        List<Drug> list = List<Drug>.empty();
        PriorityQueue<Drug> minq = PriorityQueue<Drug>((a,b)=>a.compareTo(b));
        if (priorityList.size != 0) {
            for (Drug drug in priorityList) {
                minq.add(drug);
            }
            list.add(minq.removeFirst());
        }
        return list;
    }

    //  export the result in min order
    //  1st order: priority
    //  2nd order: size "large"
    //  @return a list of drug
    List<Drug> sortLarge() {
        List<Drug> list = List<Drug>.empty();
        list.addAll(sortLargeHelper(map["priority3"]));
        list.addAll(sortLargeHelper(map["priority2"]));
        list.addAll(sortLargeHelper(map["priority1"]));
        list.addAll(sortLargeHelper(map["noMatch"]));
        return list;
    }

    //Helper
    List<Drug> sortLargeHelper(List<Drug> priorityList) {
        List<Drug> list = List<Drug>.empty();
        PriorityQueue<Drug> minq = PriorityQueue<Drug>((a,b)=>b.compareTo(a));
        if (priorityList.size != 0) {
            for (Drug drug in priorityList) {
                minq.add(drug);
            }
            list.add(minq.removeFirst());
        }
        return list;
    }

}


//  cross-reference check to determain what's the most likely drug in the list
//  @drugList   a list of drugs to check, mush fetch drug object before hands
//  @target     user input, property of the drug that's been searched
//  @return     a map of lists of drugs based on priority
Map<String, List<Drug>> crossReference(List<Drug> drugList, Drug target) {
    Map<String, List<Drug>> priorityMap = {
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