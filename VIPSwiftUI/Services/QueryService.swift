//
//  QueryService.swift
//  VIPSwiftUI
//
//  Created by Siradanai.s on 6/7/2566 BE.
//

import UIKit
import CoreData

class QueryService {
    static let shared = QueryService()
    
    let context: NSManagedObjectContext
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
}
