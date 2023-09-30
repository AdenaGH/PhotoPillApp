import 'drug.dart';
import 'package:collection/collection.dart';

//  cross-reference check to determain what's the most likely drug in the list
//  @drugList   a list of drugs to check, mush fetch drug object before hands
//  @target     user input, property of the drug that's been searched
//  @return     a priority queue of drugs
PriorityQueue<Drug> crossReference(List<Drug> drugList, Drug target) {
    PriorityQueue<Drug> pq = PriorityQueue<Drug>();
    for (Drug drug in drugList) {
      if (drug.priority < 0) {
        drug.compare(target);
      }
    }
    pq.addAll(drugList);
    return pq;
}