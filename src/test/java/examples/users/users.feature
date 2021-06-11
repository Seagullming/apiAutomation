Feature: Trial test suite

  Background:
    * url 'https://api.tmsandbox.co.nz/v1/'

  @test:1001
  Scenario: Sending request to api and the 'Name' field returned in the value of 'Carbon credits'
    Given path 'Categories/6327/Details.json'
    And param catalogue = 'false'

    When method get
    Then status 200

    And match response.Name == 'Carbon credits'

  @test:1002
  Scenario: Sending request and check if the boolean value of 'CanRelist' field equal to true
    Given path 'Categories/6327/Details.json'
    And param catalogue = 'false'

    When method get
    Then status 200

    And match response.CanRelist == true

  @test:1003
  Scenario: Sending request and
    Given path 'Categories/6327/Details.json'
    And param catalogue = 'false'

    When method get
    Then status 200

    * def isGalleryContainsCorrectContent =
    """
    function(x)
    {
       for(var i = 0; i < response.Promotions.length; i++)
       {
         karate.log("i=",i);
         karate.log("length=",response.Promotions.length);
         if(response.Promotions[i].Name == "Gallery")
         {
            var stringCheck = JSON.stringify(response.Promotions[i].Description);
            karate.log("type=",typeof (stringCheck));
            karate.log("value=",stringCheck);
            if(stringCheck.includes("Good position in category"))
            {
              karate.log("wrong!");
              return false;
            }
         }
       }
    }
    """

    And match each response.Promotions[*].Description == '#? isGalleryContainsCorrectContent(_)'
