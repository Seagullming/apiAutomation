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
  Scenario: Sending request and check the Promotions element with Name = "Gallery" has a Description that contains the text "2x larger image"
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
         var result = false;
         if(response.Promotions[i].Name == "Gallery")
         {
            var stringCheck = response.Promotions[i].Description;
            if(!stringCheck.contains("2x larger image"))
            {
              karate.log("Following string doesn't contain expected result: (Actual)" , response.Promotions[i].Description);
              karate.log("Expected: 2x larger image");
              result = false;
            }
            else if(stringCheck.contains("2x larger image"))
            {
              karate.log("Expected string \" 2x larger image\" is included");
              result = true;
            }
         }
         else if(response.Promotions[i].Name != "Gallery")
         {
            continue;
         }
         return result;
       }

    }
    """

    And match each response.Promotions[*] == '#? isGalleryContainsCorrectContent(_)'
