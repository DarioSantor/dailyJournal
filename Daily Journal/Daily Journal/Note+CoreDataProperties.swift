//
//  Note+CoreDataProperties.swift
//  Daily Journal
//
//  Created by Santos, Dario Ferreira on 22/12/2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Note : Identifiable {

}
