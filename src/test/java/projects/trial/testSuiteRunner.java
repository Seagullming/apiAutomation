package projects.trial;

import com.intuit.karate.junit5.Karate;

class testSuiteRunner {
    
    @Karate.Test
    Karate testDetails() {
        return new Karate().feature("details").relativeTo(getClass());
    }    

}
