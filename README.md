# KIWI Instructions

First checkout the project and start the **kiwiTest.xcodeproj** file, there are no third party dependencies, so it’s pretty simple. In case you want to build on a real device, add your bundle ID project settings. 
 
# User Interface:
Just build the app and you will see the loading screen while the data is being fetched from the API. After the successful data retrieval, top five destinations are shown (or less) and the image from the first destination is presented. On each destination tap, another image appears which is correlated to the destination location. Also there is a “BUY” button which opens another web view to buy the concrete flight. 

On each tap, the image is downloaded and cached upon retrieval in order not to ping the server all the time, so if you switch between two locations, there is a request only once. Portrait and landscape mode are supported as well. In case of an error an alert is presented (turn the internet off and restart the app or try to tap a destination to try it out). Of course, this can be done in much more detail if Reachability class is used, but it would go outside of scope of this test project and it was mentioned to avoid 3rd party libs or other solutions. Everything you in this project is custom made, so nothing has been copied or used from some other source. 

You can also play with custom dates in order to see different offers for the date selected (just change the date on your iPhone).

 
# Architecture:
* MMVM-C is used as an app design pattern since it complements apples native, out of the box, MVC for UIKit and it's new MVVM in SwiftUI. Coordinator takes the role of presenting the application flow (like push, pop etc.).
* Networking module is independent and can be implemented anywhere. It is based on Apple's “URLSession” and generics so no third party libs have been used.
* There is a custom loading screen and alert for the user feedback. 
* Unit tests are made for view models and moc JSON of products list and details
* Reusable components have been made (like imageview and button) for illustration purposes. 
* File organisation: 
    * App - App related data
    * Views
    * ViewControllers
    * ViewModels
    * Lib - all custom made libraries with the main one being the networking module under “Networking” 
    * Resources - storyboards, strings, images

