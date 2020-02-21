
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import CoreData

protocol CanWriteToDatabase {
    
}

extension CanWriteToDatabase {
    
    //Get the context we'll use for our Core Data Saving Operations
    var mainThreadManagedObjectContext: NSManagedObjectContext {
        get {
            return CoreDataManager.shared.mainThreadManagedObjectContext
        }
    }
    
    
    
    //MARK: -  Saving Items to Core Data
    func saveBandToCoreData(bandName: String) {
        let bandToAdd = NSEntityDescription.insertNewObject(forEntityName: EntityNames.band.name, into: mainThreadManagedObjectContext) as! Band
        
        //Create our uuid to make sure we can access the correct bands
        let bandUUID = UUID().uuidString
        
        bandToAdd.uuid = bandUUID
        bandToAdd.name = bandName
        bandToAdd.dateUpdated = Date()
        
        print("SAVING BAND TO CORE DATA")
        //Save Context
        saveContext()
    }
    
    func saveAlbumToCoreData(albumTitle: String, albumYear: String, band: Band) {
        let albumToAdd = NSEntityDescription.insertNewObject(forEntityName: EntityNames.albums.name, into: mainThreadManagedObjectContext) as! Albums
        
        let albumUUID = UUID().uuidString
        
        albumToAdd.uuid = albumUUID
        albumToAdd.band = band
        albumToAdd.title = albumTitle
        albumToAdd.releaseYear = albumYear
        albumToAdd.dateUpdated = Date()
        
        
        //Save Context
        saveContext()
    }
    
    
    //Saving the Context
    func saveContext() {
        if mainThreadManagedObjectContext.hasChanges {
            mainThreadManagedObjectContext.performAndWait {
                do {
                    try self.mainThreadManagedObjectContext.save()
                }
                catch let error as NSError {
                    fatalError("Unable to save Managed Object Context: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func batchDeleteCoreData(for entity: EntityNames) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            try mainThreadManagedObjectContext.execute(batchDeleteRequest)
            saveContext()
        }
        catch let error as NSError {
            print("Error \(error)")
        }
    }
}
