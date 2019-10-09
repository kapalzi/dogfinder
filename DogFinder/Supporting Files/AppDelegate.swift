//
//  AppDelegate.swift
//  DogFinder
//
//  Created by Krzysztof Kapała on 20/07/2019.
//  Copyright © 2019 Krzysztof Kapała. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var token: String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        self.fillDbWithTestData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func fillDbWithTestData() {
        
        var dogImage = UIImage(named: "doberman")
        var dogImageData = dogImage?.jpegData(compressionQuality: 0.01)
        var dogImageBase = dogImageData?.base64EncodedString()
        let dog1 = Dog(id: "0", breed: "Doberman", longitude: 51.059254, latitude: 17.022787, seenDate: Date(), photo: dogImageBase!, user: "Admin")

        dogImage = UIImage(named: "borzoi")
        dogImageData = dogImage?.jpegData(compressionQuality: 0.1)
        dogImageBase = dogImageData?.base64EncodedString()
        let dog2 = Dog(id: "0", breed: "Borzoi", longitude: 51.059284, latitude: 17.022123, seenDate: Date(), photo: dogImageBase!, user: "Admin")

        dogImage = UIImage(named: "dalmatian")
        dogImageData = dogImage?.jpegData(compressionQuality: 0.1)
        dogImageBase = dogImageData?.base64EncodedString()
        let dog3 = Dog(id: "0", breed: "Dalmatian", longitude: 51.059534, latitude: 17.022623, seenDate: Date(), photo: dogImageBase!, user: "Admin")

        DogFinderApi.sharedInstance.addDog(dog1)
        DogFinderApi.sharedInstance.addDog(dog2)
        DogFinderApi.sharedInstance.addDog(dog3)
    }
    

}

