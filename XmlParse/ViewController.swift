//
//  ViewController.swift
//  XmlParse
//
//  Created by Hoang Le on 1/2/19.
//  Copyright © 2019 Hoang Le. All rights reserved.
//

import UIKit
import Foundation
import AEXML

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(fileURLWithPath: documentsPathForFileName(name: "testXml.xml"))
        guard let data = try? Data(contentsOf: url) else { return }
        // example of using NSXMLParserOptions
        var options = AEXMLOptions()
        options.parserSettings.shouldProcessNamespaces = false
        options.parserSettings.shouldReportNamespacePrefixes = false
        options.parserSettings.shouldResolveExternalEntities = false
        
        do {
            let xmlDoc = try AEXMLDocument(xml: data, options: options)
            // prints the same XML structure as original
            for process in xmlDoc.root.children  {
                for child in process.children {
                    if child.children.count == 0{
                        print("Name: \(child.name) Value: \(child.value ?? "")")
                    }else {
                        print("Name: \(child.name) Value:\n \(child.xml)")
                    }
                }
            }
        }
        catch {
            print("\(error)")
        }
        
    }
    
    func documentsPathForFileName(name: String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return "\(documentsPath)/\(name)"
    }
    
}
