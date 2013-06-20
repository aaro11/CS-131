import java.util.*;

import static java.util.Map.Entry;

public interface Reducer<K,V> {
    V apply(Entry<K,List<V>> entry)  throws MRException  ;
}
