## TravelApp

TravelApp is an app that helps you find the cheapest flight route available. You select the city of departure and the city of arrival, then the app presents the cheapest route and its final price. 

### Architecture

The architecture used do build app was MVP with Coordinators. Each view was built using view code and your attributes cannot access by others class.

#### Coordinator
The coordinator is responsible for managing the navigation flow in the app. 

#### ViewControllers
The presentation of views is managed by the ViewController.

#### Presenters
The data manipulation, user actions and requests are responsibilities the Presenter.

#### Repository
The repository is responsible for connecting the presenter to the network layer, sending the necessary data for resquest and making small treatments of the response received before returning it to the presenter 

#### TravelManager
Travel Manager is the class responsible for finding the cheapest route available. It must know each city and available connections.

### Tests

For the test, the XCTest and the following libraries were used 
- [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing): for the preview unit tests 
- [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs): to stub your network requests

### Installation:

It requires iOS 13 and Xcode 11.
