
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import CoreData

/* This class holds our Context and Persistent CK Container. We'll access this ManagedObjectContext to save and/or change our data from the Proptocols.*/


class CoreDataManager {
    
    //MARK: - Properties
    public class var shared: CoreDataManager {
        struct Static {
            static let instance: CoreDataManager = CoreDataManager()
        }
        return Static.instance
    }
    
    lazy private var persistentContainer: NSPersistentCloudKitContainer = {
        //The 'name' in the CKContainer initializer below NEEDS to be the same name as the .xcdatamodeld file in your project.
        let container = NSPersistentCloudKitContainer(name: "MusicList")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Core Data Error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var mainThreadManagedObjectContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    
    
    
    
}
