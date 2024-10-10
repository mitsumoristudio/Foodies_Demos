# Foodies (Instructions)
 Foodies App was designed to satisfy your taste buds by allowing the user to interact popular International cuisines. 
 The target is setup for IOS 17.5 minimum and configured to be utilizied for Iphone 12 and above.
 For building and running the app, click on the Product and Run button through XCode and it will diplay the parent view
 (ContentView).

## App Focus Area
The Food App offers variety of friendly features which makes it great experience for cooking at home.
Search and Filter Options: Search button to find recipes based on world cuisine types and filters alphabetically.
Recipes Collections: Access the curated collection from your favorite confection. Simple one touch design
to scroll through recipes in which the combination of ScrollView and LazyVStack does not create new items unless
the user needs to render and display onscreen. 
Images are cached on disk/memory using KingFisher api, as Swifts Async Image has issues rendering the image based on
image size and processing. 
Design Implmentation: Having done some research on conventional UI interface from social media, cooking recipes apps,
came to decision to apply the Grid View from URL image with shadow, masking and overlaying the cuisine and dish name.
Adjusted the resolution and aligment if the user sees the UIView in dimmer setting. 


Built in countdown timer

