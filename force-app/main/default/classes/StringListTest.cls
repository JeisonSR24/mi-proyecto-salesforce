public with sharing class StringListTest {
    
    public static List<String> generateStringList(Integer size) {
        List<String> stringList = new List<String>();
        
        for(Integer i = 0; i < size; i++) {
            stringList.add('Test ' + i);
        }
        
        System.debug('Generated String List: ' + stringList);
        
        return stringList;
    }
}