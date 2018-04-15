# Engineering Choices

## Third Party Libraries
I chose not to use any third party libraries for the following reasons 1) I wanted a lightweight project with as little dependencies as possible. 2) I wanted to showcase my working knowledge of standard Apple frameworks  (specifically `CoreLocation` and `NSURLSession`).

## Protocol Oriented Programming
To open up the possibily for unit testing, I created a few helper classes using protocols. `AlertHelper`, `DataFetcher`, and `MainThreadHelper` are designed to be swapped out for mocks.

## AutoLayout (Interface Builder vs programmatic)
I mostly used Interface Builder for this project and most of the constraints are configured in the storyboard. However, I did add programmatic layouts in `RestaurantSelectionViewController` and `IndicatorHeaderView` . This was done for two reasons. 1) I wanted to showcase my working knowledge of programmatic layouts 2) Adding a `UIActivityIndicatorView` to the `UICollectionView` contained in `RestaurantSelectionViewController` is much easier in my opinion than doing it via IB.
3) I created a reusable `IndicatorHeaderView` that was used in two places, this would have been more difficult to do via Interface Builder.

## Extras
I decided to add a few extra features to the App that (in my opinion) made the App feel more complete.
- `RestaurantSelectionViewController` is a `UICollectionView` which supports multiple restaurants. The directions given  in this assignment only asked to query `api/company/1` but if we needed to query a list of companies, the presentation would allow for this.
- The `LocationsTableViewController` displays each location's distance relative to the user's coordinates. Additionally, there is a button that allows for the user to sort the list of locations.
- The `DetailsTableViewController` allows for copying & pasting of the address, driving directions via `Safari`  and also allows for the user to make make a phone call to the restaurant. Although these elements were very esay to implement, I think it adds a nice touch.
