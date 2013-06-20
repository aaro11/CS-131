import java.util.*;

import static java.util.Map.Entry;

// interface for the user-defined map function
public interface Mapper<K1,V1,K2,V2> {
    List<Entry<K2,V2>> apply(Entry<K1,V1> item)  throws MRException ;
}

