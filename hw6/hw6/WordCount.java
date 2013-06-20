import java.util.*;

import static java.util.Map.Entry;

// a MapReduce job that computes word counts for the contents of
// a given set of files
public class WordCount {
    
    public static void main(String[] args) {
	    // produces pairs of the form (word, 1) for each word 
        Mapper<String,String,String,Integer> m =
	    new Mapper<String,String,String,Integer>() {
            public List<Entry<String,Integer>>
            apply(Entry<String,String> entry) {
                List<Entry<String,Integer>> result =
                new ArrayList<Entry<String,Integer>>();
                
                String content = entry.getValue();
                // break up the String into words
                String[] words = content.split("\\s");
                for (String w : words) {
                    if(w.length() > 0)
                        result.add(new MREntry<String,Integer>(w, 1));
                }
                return result;
            }
        };
        
	    // sums the counts for each word, producing a singleton list
	    // containing this sum
        Reducer<String,Integer> r =
	    new Reducer<String,Integer>() {
            public Integer
            apply(Entry<String,List<Integer>> entry) {
                List<Integer> result = new ArrayList<Integer>();
                List<Integer> values = entry.getValue();
                int sum = 0;
                for (Integer i : values) {
                    sum += i;
                }
                return sum;
            }
            
        };
        
        MiniMapReduce<String,String,String,Integer> mr =
	    new MiniMapReduce<String,String,String,Integer>(m, r);
        
	    // create a pair (filename, contents) for each file
        List<Entry<String,String>> entries =
	    new ArrayList<Entry<String,String>>();
        for(String s : args) {
            entries.add(new MREntry<String,String>(s, FileUtil.readFile(s)));
        }
        
       	Map<String,Integer> result = mr.mapReduce(entries);
        FileUtil.writeFile("wordcount.out", result);
    }
}
