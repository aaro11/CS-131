import java.util.*;

import static java.util.Map.Entry;

public class RandomPhrase {

    public static String genPhrase(Map<String,List<String>> mostcommon,
				   String word, int numSeqs) {
	// start the string with the word
	String result = word;
	
	for (int a = 0; a < numSeqs; a++){
	    // add a blank space to the last 
	    result += " ";
	    // if the tree doesn't contain the word, return null
	    if (!mostcommon.containsKey(word)){
		return null;
	    }

	    // if not, add to the string the characters in that list
	    else {
		//go until before the last one (this is to handle the LAST space)
		for (int b = 0; b < 3; b++) 
		    result += mostcommon.get(word).get(b) + " ";
		word = mostcommon.get(word).get(3);
		result += word;
	    }
	}
	return result;
    }

    public static void main(String[] args) {
	String mostcommon = FileUtil.readFile("mostcommonseq.out");
	String[] lines = mostcommon.split("\\n");
	Map<String,List<String>> entries =
	    new TreeMap<String,List<String>>();
	for(String line : lines) {
	    int colon = line.indexOf(':');
	    String first = line.substring(0, colon - 1);
	    String seq = line.substring(colon + 2);
	    List<String> seqL = FileUtil.parseList(seq);
	    entries.put(first, seqL);	      
	}
	
	String word = args[0];
	int numSeqs = Integer.parseInt(args[1]);
	System.out.println(genPhrase(entries, word, numSeqs));
    }
}
