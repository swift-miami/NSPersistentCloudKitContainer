
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import CoreData

protocol CanReadFromDatabase {
}

extension CanReadFromDatabase {
    //Getting our Managed Object Context From the Core Data Manager
    var mainThreadManagedObjectContext: NSManagedObjectContext {
        get {
            CoreDataManager.shared.mainThreadManagedObjectContext
        }
    }
    
    var bandsFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        get {
            let controller = FetchedResultsController().configureBandFetchedResultsController()
            return controller
        }
    }
    
    
    //MARK: BANDS METHODS
    func bandsCount() -> Int {
        if let allBands = bandsFetchedResultsController.fetchedObjects as? [Band] {
            return allBands.count
        }
        else {
            return 0
        }
    }
    
    
    //MARK: - ALBUMS METHODS
    func configureAlbumsController(with predicate: NSPredicate) -> NSFetchedResultsController<NSFetchRequestResult> {
        let controller = FetchedResultsController().configureAlbumsFetchedResultsController(predicate: predicate)
        return controller
    }
    
    
    
    
    
    
    
    
    
    
}
