import java.io.*;
import java.util.*;
import static java.util.Map.Entry;

public class FileUtil { 

	// read the contents of the file fname into a String
    public static String readFile(String fname) {
        try {
            StringBuffer sb = new StringBuffer(1024);       
            BufferedReader reader = new BufferedReader(new FileReader(fname));
            char[] chars = new char[1024];
            int numRead = 0;        
            while( (numRead = reader.read(chars)) > -1){    
                sb.append(String.valueOf(chars, 0, numRead));
            }
            reader.close();
            return sb.toString();
        } catch (IOException e) {               
            System.out.println("Can't read file, assuming empty string for " +
                               fname);
            return "";
        }
    }

	// write the contents of a map to a file named fname
    public static <K,V> void writeFile(String fname, Map<K,V> map) {
	try {
	    BufferedWriter writer = new BufferedWriter(new FileWriter(fname));
	    Set<Entry<K,V>> entries = map.entrySet();
	    for(Entry<K,V> entry : entries) {
		writer.write(entry.getKey() + " : ");
		writer.write(entry.getValue() + "\n");
	    }
	    writer.close();
	} catch (IOException e) {
	    System.out.println("Can't write file " + fname);
	}
    }

	// parse a string of the form "[e1, e2, ..., en]" into a list of its elements
	// we assume the elements are comma-separated and have a single space after
	// each comma
    public static List<String> parseList(String l) {
	List<String> result = new ArrayList<String>();
	
	String[] items = l.split(",");
	for (String i : items) {
	    String trimmed = i.substring(1);
	    if(trimmed.charAt(trimmed.length() - 1) == ']')
		trimmed = trimmed.substring(0, trimmed.length() - 1);
	    result.add(trimmed);
	}
	return result;
    }

}
