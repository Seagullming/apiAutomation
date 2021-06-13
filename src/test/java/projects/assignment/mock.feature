Feature: Trial test suite

  Background:
    * url 'https://api.tmsandbox.co.nz/v1/'

  @test:1001
  Scenario: The value of 'Name' field in response should be 'Carbon credits'
    Given path 'Categories/6327/Details.json'
    And param catalogue = 'false'

    When method get
    Then status 200

    And match response.Name == 'Carbon credits'

  @test:1002
  Scenario: Boolean value of 'CanRelist' should be returned as true;
    Given path 'Categories/6327/Details.json'
    And param catalogue = 'false'

    When method get
    Then status 200

    And match response.CanRelist == true

  @test:1003
  Scenario: If 'Name' field equals to 'Gallery', '2x larger image' should be included in the value of the field
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
              karate.log("id:",response.Promotions[i].Id);
              result = false;
            }
            else if(stringCheck.contains("2x larger image"))
            {
              karate.log("Expected string \" 2x larger image\" is included");
              karate.log("id:",response.Promotions[i].Id);
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
