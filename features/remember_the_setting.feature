Feature: remember the previous setting when go back to the home page
  
  As a website user
  So that I can quickly review the movies on the previous preferences
  I want to see the previous setting when go back to the home page
  
Background: movies have been added to database
  
  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page
  
Scenario: go back to the home page from detail page
  When I check the following ratings: PG
  And I uncheck the following ratings: G, PG-13, R
  And I press "ratings_submit"
  Then I should see "The Incredibles"
  And I should not see "Chocolat"
  When I follow "More about The Incredibles"
  Then I should be on the details page for "The Incredibles"
  When I follow "Back to movie list"
  Then I should see "Raiders of the Lost Ark"
  And I should not see "The Terminator"
  
 Scenario: uncheck all ratings
   When I uncheck the following ratings: G, R, PG, PG-13, NC-17
   And I press "ratings_submit"
   Then I should see all the movies