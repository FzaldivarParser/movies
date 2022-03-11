
# Project Movies

## General Info

- Architecture: MVVM
- Design patterns: Coordinator, Singleton
- [Style guide](https://github.com/raywenderlich/swift-style-guide)

## Main Modules

- Data: Models of the application. Here we can find the structs and the logic for the cache.
- Network: Layer that works with Alamofire to fetch information.
- UI: Main layer of the architecture. Inside this module you can find subgroups of data. Each subgroups have:
  - View Controller
  - View Model
  - Coordinator
  - Storyboard
- Util: protocols, extensions and other files that make the code more easy to understand and develop.

## Questions

1- Single Responsibility Principle: (S in S O L I D). Each module should have only one responsibility over a part of the application. The main purpose of this principle is the encapsulation of the code. 

2- Characteristics of clean code:
  - Understand and apply S O L I D principles.
  - Use right names for each part of the code (variables, functions, etc)
  - Create solutions that are reusable (in the app you can see three main screens but is only one module - Movies- )
  - Define an style guide. With this, the code of every member of the team should be similar. This will help to incorporate new members of the team in a more easy way.
  - First think, then code. 

## Notes

The api link in the description of the challenge is v4. This version is not completed, for example it does not have movies by category (popular, top rated, upcoming), so I used v3. 
