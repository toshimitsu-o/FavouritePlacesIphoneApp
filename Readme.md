#  FavouritePlaces

May 2023

The app to manage favourite places as a list which includes information of places with pictures, geographic locations, map, and sunrise/sunset times. User can add, edit, and delete places. Data is saved using CoreData.

## Learning Journal

### Week 6

- How to use CoreData for persistent data and setup Context
- How to setup a CoreData entity with attributes
- How to setup PersistenceHandler
- How to set sort order to FetchRequest
- How to solve reordering items in CoreData [Source](https://stackoverflow.com/questions/59742218/swiftui-reorder-coredata-objects-in-list)

### Week 7

- How to implement MVVM pattern
- How to use different property wrappers
- How to download images from url
- How to use cache
- How to implement async operations
- How to test CoreData context

### Week 8

- How to load default sample data
- How to set up Map view and access geo location
- How to update Map view and move with animation

### Week 9

- How to solve error from loading cache image by wrapping in DispatchQueue.main.async
- How to size a sub view by adding .frame(width:, height:)
- How to create a thumbnail map view

### Week 10

- How to fetch timezone data via API
- How to fetch sunrise/sunset time data via API
- How to convert date format using DateFormatter()
- How to use ProgressView()

## Changelog

### Milestone 1

- Implement CoreData persistence data
- Add Place entity to CoreData
- Add a master view to list Place items with adding item feature
- Add edit mode to master view
- Add delete and move features
- Add a detail view to display name and notes of a place
- Implement MVVM pattern
- Add image download feature
- Add location attributes
- Add eidt mode for place details
- Add thumbnail image and location details to list row

### Milestone 2

- Add feature to load default place data for when there is no place data saved
- Move some of delete and add processes to view model file
- Add Map location view
- Add update feature to save geo location data and location name to place item list
- Add map thumbnail view in detail view to show a small map

### Milestone 3

- Add feature to update the place name from the location name in the map
- Add feature to show time zone of a place in detail view
- Add feature to show sunrise/sunset time of a place in detail view
- Add app icon
- Set accent colour and heading colour

## Video

Demonstrating the excution of code, explanation of the code.
[YouTube Video](https://youtu.be/7vBlhm8NiuY)
