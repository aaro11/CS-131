import static java.util.Map.Entry;

// represents a (key,value) pair
public class MREntry<K,V> implements Entry<K,V> {
    protected K key;
    protected V value;
    public MREntry(K key, V value) {
        this.key = key;
        this.value = value;
    }
    public K getKey() { return key; }
    public V getValue() { return value; } 
    public V setValue(V value) {
	throw new UnsupportedOperationException();
    }
}
