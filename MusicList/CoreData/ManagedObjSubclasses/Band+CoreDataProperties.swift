//
//  Band+CoreDataProperties.swift
//  MusicList
//
//  Created by Dylan  on 2/20/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//
//

import Foundation
import CoreData


extension Band {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Band> {
        return NSFetchRequest<Band>(entityName: "Band")
    }

    @NSManaged public var dateUpdated: Date?
    @NSManaged public var name: String?
    @NSManaged public var uuid: String?
    @NSManaged public var albums: NSSet?

}

// MARK: Generated accessors for albums
extension Band {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: Albums)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: Albums)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}
