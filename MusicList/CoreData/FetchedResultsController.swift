//
//  FetchedResultsController.swift
//  MusicList
//
//  Created by Dylan  on 2/18/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import CoreData

struct FetchedResultsController: CanReadFromDatabase {
 
    //MARK: -
    func configureBandFetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        let bandFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.band.name)
        
        let sortDescriptors = NSSortDescriptor(key: "dateUpdated", ascending: true)
        bandFetchRequest.sortDescriptors = [sortDescriptors]
        bandFetchRequest.predicate = NSPredicate(value: true)
        
        let bandsFetchedResultsController = NSFetchedResultsController(fetchRequest: bandFetchRequest, managedObjectContext: mainThreadManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try bandsFetchedResultsController.performFetch()
        }
        catch let error as NSError {
            print("Error fetching Bands: \(error)")
        }
        return bandsFetchedResultsController
    }
    
    
    func configureAlbumsFetchedResultsController(predicate: NSPredicate) -> NSFetchedResultsController<NSFetchRequestResult> {
        let albumsFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityNames.albums.name)
        
        let sortDescriptors = NSSortDescriptor(key: "title", ascending: true)
        
        albumsFetchRequest.sortDescriptors = [sortDescriptors]
        albumsFetchRequest.predicate = predicate
        
        let albumsFetchedResultsController = NSFetchedResultsController(fetchRequest: albumsFetchRequest, managedObjectContext: mainThreadManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try albumsFetchedResultsController.performFetch()
        }
        catch let error as NSError {
            fatalError("Error Fetching Albums \(error)")
        }
        return albumsFetchedResultsController
    }
    
}
