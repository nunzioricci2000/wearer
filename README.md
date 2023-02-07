# wearer
This is a nice projected developed by Nunzio Ricci and his infinite mokeys.
In this project we decided to implement weather APIs, thanks to Open-Meteo.com. About the implementation of this feature, we divided the problem in 2 main parts. First of all we decided to create a class to handle networking and then we created a class to manage specificately the open-meteo requests.
The network manager has an asyncronous function `get` that returns data from a given link. In the Open-Meteo class we have a method called `foreground`. This method takes as arguments latitude and longitude and retrives an `OMResponse` instance, that is a struct built based on Open-meteo responses.
Maybe you are asking yourself where we retrived location data (latitude and longitude). We created a nice class named `locationHandler`, this class implements some methods to get the actual location by using Apple's core location package. How does this communicate with the open-meteo class? To reduce the coupling and the scalability we decided that we can call all this objects separately in the presentation logic and 
..:)epoiilrestololascioategorpello 
