/* Bepen Neupane
 * bneupane@u.rochester.edu
 * CSC 214 Fall 2018 - Project 3, 11/24/18
 * I affirm that I have not given or received any unauthorized help on this assignment, and that this work is my own.
 */

The project is called Memories. The app lets you store memories and categorize them as either happy or sad. The localization languages are English and Spanish. 

I have included the use of UserDefaults in the about screen which can be reached by pressing the '?' button. There is a launch screen and a custom icon. I use MVC design pattern. Everything is data persistent. I do not use a URLSession. Auto layout is supported. The app works properly on all iOS devices on Xcode. 

My five view controllers are called, MasterViewController, DetailViewController, AboutViewController, ColorViewController, and ExtraViewController. ColorViewController can be reached with the "Color" button, ExtraViewController can be reached with the 'X' button. The MasterViewController contains sectioned table views, sectioned as "Happy" or "Sad" and supports adding and deleting. I didn't really see a point to including movement so I removed it since order doesn't really matter in this app, only sections. I have an alert that lets the user enter info when they press the '+'. I have a second alert that makes the user choose between "Happy" and "Sad". I have a third alert that prevents the user from having two of the same memories. I have a fourth alert that makes the user go to settings to change their location preferences in case they didn't grant my app permission. I use Core Location and display the user's location in the Detail View Controller which can be accessed by pressing on a memory that the user has created. I included a default memory called "Happy!!!". The user cannot delete every memory, only all but one memory can be deleted. I have two gestures, double tap and pinch. To use it, press the "Color" button, then in the new screen, you can double tap to change the color or pinch by pressing the "option" key on the keyboard and pressing the mouse and moving it to simulate a complete pinch and release. 

On iPads, I decided to make the AboutViewController a pop up because it doesn't contain important information to the user so I didn't want it to take up the whole screen. ColorVC and ExtraVC are full screen on iPad. To navigate away, simply press and drag mouse from the left edge towards the middle, there is no back navigation button because I wanted it to occupy the full screen.

So overall, the only requirement I didn't satisfy was the URLSession one.
