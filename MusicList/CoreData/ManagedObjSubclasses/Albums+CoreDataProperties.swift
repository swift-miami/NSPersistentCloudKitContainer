//
//  Albums+CoreDataProperties.swift
//  MusicList
//
//  Created by Dylan  on 2/20/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//
//

import Foundation
import CoreData


extension Albums {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Albums> {
        return NSFetchRequest<Albums>(entityName: "Albums")
    }

    @NSManaged public var dateUpdated: Date?
    @NSManaged public var releaseYear: String?
    @NSManaged public var title: String?
    @NSManaged public var uuid: String?
    @NSManaged public var band: Band?

}
