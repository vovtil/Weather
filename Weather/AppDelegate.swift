//
//  AppDelegate.swift
//  Weather
//
//  Created by Ефремов Владимир on 15.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //initializeRealm()
        
        let vc = ForecastRouter.assembleModule()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [vc]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
    
    private func initializeRealm() {
        let realm = try! Realm()
        guard realm.isEmpty else { return }
        
        let path = Bundle.main.path(forResource: "city.list.json", ofType: nil)
        let url = URL(fileURLWithPath: path!)
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard json is [AnyObject] else {
                assert(false, "failed to parse")
                return
            }
            do {
                let cities = try jsonDecoder.decode([CityModel].self, from: data)
                let realm = try! Realm()
                for city in cities {
                    try! realm.write {
                        realm.add(city)
                    }
                }
            } catch {
                print("failed to convert data")
            }
        } catch let error {
            print(error)
        }
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


}

