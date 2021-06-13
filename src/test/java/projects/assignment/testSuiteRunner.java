package projects.assignment;

import com.intuit.karate.junit5.Karate;

class testSuiteRunner {
    
    @Karate.Test
    Karate testSuite() {
        return new Karate().feature("mock").relativeTo(getClass());
    }    

}
