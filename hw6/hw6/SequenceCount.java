import java.util.*;

import static java.util.Map.Entry;

// a MapReduce job that produces, for each 5-word sequence in the given
// files, the number of times that sequence appears
public class SequenceCount {
    
    public static void main(String[] args) {
        Mapper<String,String,List<String>,Integer> m =
	    new Mapper<String,String,List<String>,Integer>() {
            //return value:
            public List<Entry<List<String>,Integer>>
            apply(Entry<String,String> entry) {
                
                
                List<Entry<List<String>,Integer>> result =
                new ArrayList<Entry<List<String>,Integer>>();
                
                String content = entry.getValue();
                // break up the String into words
                String[] words = content.split("\\s");
                List<String> clean = new ArrayList<String>();
                
                // add to the clean list only the good words
                for (int a = 0; a < words.length; a++){
                    String[] tempArr = words[a].split("[^a-z']");
                    if (tempArr.length != 0 && !tempArr[0].equals(""))
                        clean.add(tempArr[0]);
                }
                
                // group up every 5 words
                for (int a = 0; a < clean.size() - 4; a++) {
                    List<String> temp = new ArrayList<String> ();
                    for (int b = 0; b <= 4; b++){
                        temp.add(clean.get(a+b));
                    }
                    result.add(new MREntry<List<String>,Integer>(temp, 1));
                }
                
                return result;
            }
        };
        
	    // sums the counts for each sequence
        Reducer<List<String>,Integer> r =
	    new Reducer<List<String>,Integer>() {
            public Integer
            apply(Entry<List<String>,List<Integer>> entry) {
                List<Integer> result = new ArrayList<Integer>();
                List<Integer> values = entry.getValue();
                int sum = 0;
                for (Integer i : values) {
                    sum += i;
                }
                return sum;
            }
        };
        
        Comparator<List<String>> c =
	    new Comparator<List<String>>() {
            public int compare(List<String> sa1, List<String> sa2) {
                StringBuffer s1 = new StringBuffer();
                StringBuffer s2 = new StringBuffer();
                for (String s : sa1)
                    s1.append(s);
                for(String s0 : sa2)
                    s2.append(s0);
                return s1.toString().compareTo(s2.toString());
            }
        };
        
        MiniMapReduce<String,String,List<String>,Integer> mr =
	    new MiniMapReduce<String,String,List<String>,Integer>(m,r,c);
        
	    // create a pair (filename, contents) for each file
        List<Entry<String,String>> entries =
	    new ArrayList<Entry<String,String>>();
        for(String s : args) {
            entries.add(new MREntry<String,String>(s, FileUtil.readFile(s).toLowerCase()));
        }
        
       	Map<List<String>,Integer> result = mr.mapReduce(entries);
        FileUtil.writeFile("seqcount.out", result);
    }
}
