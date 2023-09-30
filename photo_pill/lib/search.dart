import 'drug.dart';
import 'package:collection/collection.dart';

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