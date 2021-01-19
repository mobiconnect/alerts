# ALERTS and NOTIFICATIONS

### IN-APP ALERTS
This featured module enables you to create 'in-app' alerts, which would allow you to send pop-up messages whenever a user opens your app or a particular function.
	
### PUSH NOTIFICATIONS
Push notifications are basically text messages that you can send to your application users. Apps do not need to be open for push notifications to be received.

# How to try
To use this sample code you should have already registered with AOtomot platform. Once you register you will have your worksmapce name and apik key available, place then in Url.swift file in "workspaceName" and "apiKey" and run your code.
```
struct Urls {

  static let workspaceName = ""
  static let apiKey = ""
  static let baseUrl = "https://\(workspaceName).aotomot.com/api/"
  
  // Onboarding
  static let onboarding = "\(baseUrl)onboarding?apiKey=\(apiKey)"

}
```

# Where can I find my apikey
Log into our [licensing manager](https://aotomot.com/login/) with your registered username and password. You can find the workspace name and apikey under your project.
![apiKey](https://user-images.githubusercontent.com/54090983/63316567-ac7b3100-c352-11e9-8038-ff91c287be7f.png)

# Where can I upload my push notification certificates in to your system.
After you have logged in to [licensing manager](https://aotomot.com/login/) you will find a section named 'PUSH NOTIFICATION CERTIFICATES' under your project. You need to paste your APNS certificate and private key into this section to start recieving push notifications in you app. It is as simple as this!

![iOSPushCerts](https://user-images.githubusercontent.com/54090983/63316845-cec17e80-c353-11e9-91a8-77e83d7a935a.png)

# API documentation
You can checkout our api documentation and try them [here](https://docs.aotomot.com/reference/notification-overview) 
