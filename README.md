# festival

Hackaton

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Modèles de donnée

```mermaid
classDiagram
class Role{
    <<enumeration>>
    ADMIN
    USER
}
class EventStatus{
    <<enumeration>>
    OPEN_TICKETING
    LAST_TICKETS
    COMPLETE
}
class Festival {
    -String id
    -EventStatus status
    -String name
    -String city
    -String postalCode
    -String majorField
    -String webSite
    -String creatorId
    -String contactEmail
    -Int availableTickets
}
class User{
    -String id
    -Role role
    -String email
    -String[] favoriteFestivals
}    
```
