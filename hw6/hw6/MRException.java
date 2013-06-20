
// an exception thrown by a user-defined Mapper or Reducer implementation
// to indicate that the current invocation should be ignored, but
// processing of the rest of the data should continue
public class MRException extends Exception {}
