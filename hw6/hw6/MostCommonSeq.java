import java.util.*;

import static java.util.Map.Entry;

public class MostCommonSeq {
    
    public static void main(String[] args) {
        Mapper<List<String>,Integer,String,List<String>> m =
	    new Mapper<List<String>,Integer,String,List<String>>() {
            //return value:
            public List<Entry<String,List<String>>>
            apply(Entry<List<String>,Integer> entry) {
                
                // return list
                List<Entry<String,List<String>>> result =
                new ArrayList<Entry<String,List<String>>>();

		// content
		List<String> content = entry.getKey();

		// the rest of the string (not including the 1st element)
		List<String> rest = new ArrayList<String>();

		// get the number (getValue) and swap it with the first value
		// of the list
		Integer temp = entry.getValue();
		rest.add(temp.toString());
		    
		// add the rest of the list (indexes 1-4) to rest
		for (int b = 1; b < 5; b++)
		    rest.add(content.get(b));

		// add the first word and the new list into the result
		result.add(new MREntry<String,List<String>>(content.get(0), rest));
		    
                return result;     
            }
        };
        
        Reducer<String,List<String>> r =
	    new Reducer<String,List<String>>() {
            public List<String>
            apply(Entry<String,List<List<String>>> entry) {
                
		// return list
		List<String> result = new ArrayList<String>();

		// for the list 
		List<List<String>> temp = entry.getValue();

		// most common sequence
		List<String> highest = new ArrayList<String>();

		// set the lowest to 0 (it will always be > 0)
		// this will go through the list and check if the number is greater
		// if it's greater, it'll set the low to a new value
		int low = 0;
		for (int a = 0; a < temp.size(); a++)
		    if (Integer.parseInt(temp.get(a).get(0)) > low){
			highest = temp.get(a);
			low = Integer.parseInt(highest.get(0));
		    }

		// adds the 4 characters after the integer
		for (int b = 1; b < 5; b++)
		    result.add(highest.get(b));
		
		return result;                
            }
        };
        
        MiniMapReduce<List<String>,Integer,String,List<String>> mr = 
	    new MiniMapReduce<List<String>,Integer,String,List<String>>(m, r);
        
        List<Entry<List<String>,Integer>> entries =
	    new ArrayList<Entry<List<String>,Integer>>();
        
        String seqcounts = FileUtil.readFile("seqcount.out");
        String[] lines = seqcounts.split("\\n");
        for(String line : lines) {
            String seq = line.substring(0, line.indexOf(']') + 1);
            List<String> seqL = FileUtil.parseList(seq);
            String count = line.substring(line.indexOf(':') + 2);
            entries.add(new MREntry<List<String>,Integer>(
                                                          seqL, Integer.parseInt(count)));
        }
        
       	Map<String,List<String>> result = mr.mapReduce(entries);
        FileUtil.writeFile("mostcommonseq.out", result);
    }
}
