# wearer
Wearer is an iOS app that allow to match your outfits with local weather conditions.
This app has been created as a project for Apple Developer Academy of Naples by
Alberto Mura, Francesco De Simone, Nunzio Ricci and Pietro Ciuci.

## Tutorial

### Intro

One of most challenging topics about our project is the API implementation.
In order to take updated weather informations we need to retrive this data from an online
service, so we decided to adopt [open-meteo.com](https://open-meteo.com/).

### NetworkManager

We created a class named NetworkManager that provides the ``get`` async method that return 
data from a given url:
```
/// return a data from given link
///
/// - Parameters:
///   - url: string of the url
/// - Returns: A tuple containing data and response from the server.
func get(url: String) async throws -> (Data, URLResponse)
```
