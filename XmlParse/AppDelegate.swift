//
//  AppDelegate.swift
//  XmlParse
//
//  Created by Hoang Le on 1/2/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import UIKit
import AEXML

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let request = AEXMLDocument()
        let root = request.addChild(name:"Processes")
        let process = root.addChild(name:"Process")
        process.addChild(name:"FactoryID",value:"*工場ID")
        process.addChild(name:"FactoryName",value:"工場名")
        process.addChild(name:"LineID",value:"*ラインID")
        let elements = process.addChild(name:"Elements")
        for _ in 0...4 {
            let elelment = elements.addChild(name:"Elelment")
            elelment.addChild(name:"ElementID",value:"*工場ID")
            elelment.addChild(name:"ElementNo",value:"No")
            elelment.addChild(name:"Target",value:"対象")
        }
        let movie = process.addChild(name:"Movie")
        movie.addChild(name:"MovieID",value:"*工場ID")
        movie.addChild(name:"MoviePath",value:"動画パスの相対値")
        movie.addChild(name:"MovieName",value:"動画名")
        
        let dataXml = request.xml.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        deleteExistingFile(path: "testXml.xml")
        saveFileInDocumentDirectory(fileName: "testXml.xml", data: dataXml) { (arg0) in
            let (isSave,url) = arg0
            if isSave, let url = url {
                print("url: \(url)")
            }
        }
        return true
    }
    
    func saveFileInDocumentDirectory(fileName:String,data:Data,onResult: @escaping ((Bool,URL?)) -> Void){
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try data.write(to: fileURL, options: .atomic)
            onResult((true,fileURL))
        }catch let exp {
            print("GETTING EXCEPTION \(exp.localizedDescription)")
            onResult((false,nil))
        }
    }
    
    func deleteExistingFile(path: String) {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            
            let fileURL = documentDirectory.appendingPathComponent(path)
            try fileManager.removeItem(at: fileURL)
        }catch _ as NSError {}
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

