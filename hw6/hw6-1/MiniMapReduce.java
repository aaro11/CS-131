import java.util.*;

import static java.util.Map.Entry;

// a simple implementation of Google's MapReduce framework
public class MiniMapReduce<KIn,VIn,KOut,VOut> {
    
    protected Mapper<KIn,VIn,KOut,VOut> mapper;
    protected Reducer<KOut,VOut> reducer;
    protected Comparator<KOut> comp;
    
    public MiniMapReduce(Mapper<KIn,VIn,KOut,VOut> m, Reducer<KOut,VOut> r) {
        this(m,r,null);
    }
    
    public MiniMapReduce(Mapper<KIn,VIn,KOut,VOut> m, Reducer<KOut,VOut> r,
                         Comparator<KOut> c) {
        mapper = m;
        reducer = r;
        comp = c;
    }
    
    
	// perform the map, using the user's Mapper implementation
    protected List<Entry<KOut,VOut>> map(List<Entry<KIn,VIn>> l) {
        List<Entry<KOut,VOut>> result = new ArrayList<Entry<KOut,VOut>>();
        for(Entry<KIn,VIn> entry : l) {
        	try {
            	result.addAll(this.mapper.apply(entry));
        	}
        	catch (MRException e){};
        }
        return result;
    }
    
	// combine all tuples with the same key in the given list of entries
	// this method is invoked on the results of the above map method
    protected SortedMap<KOut,List<VOut>> shuffle(List<Entry<KOut,VOut>> l) {
        SortedMap<KOut,List<VOut>> map = new TreeMap<KOut,List<VOut>>(comp);
        
        for(Entry<KOut,VOut> entry : l) {
            KOut key = entry.getKey();
            VOut value = entry.getValue();
            List<VOut> vals;
            if(map.containsKey(key)) {
                vals = map.get(key);
                vals.add(value);
            } else {
                vals = new ArrayList<VOut>();
                vals.add(value);
                map.put(key, vals);
            }
        }
        return map;
    }
    
    
	// perform the reduce, using the user's Reducer implementation
    protected SortedMap<KOut,VOut> reduce(SortedMap<KOut,List<VOut>> map) {
        Set<Entry<KOut,List<VOut>>> entries = map.entrySet();
        SortedMap<KOut,VOut> result = new TreeMap<KOut,VOut>(comp);
        for(Entry<KOut,List<VOut>> entry : entries) {
        	try {
        		VOut reduce = this.reducer.apply(entry);
        		result.put(entry.getKey(), reduce);
        	}
        	catch (MRException e){	};
        }
        return result;
    }
    
	// the entry point for MapReduce
    public SortedMap<KOut,VOut> mapReduce(List<Entry<KIn,VIn>> entries) {
        return reduce(shuffle(map(entries)));
    }
    
}
