//
//  Exercises+CoreDataProperties.swift
//
//
//  Created by Роман on 10.10.2024.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(Exercises)
public class Exercises: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercises> {
        return NSFetchRequest<Exercises>(entityName: "Exercises")
    }

    @NSManaged public var descript: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var titleExercises: String?
    @NSManaged public var category: NSSet?
    @NSManaged public var training: NSSet?

}

// MARK: Generated accessors for category
extension Exercises {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}
// MARK: Generated accessors for training
extension Exercises {

    @objc(addTrainingObject:)
    @NSManaged public func addToTraining(_ value: Training)

    @objc(removeTrainingObject:)
    @NSManaged public func removeFromTraining(_ value: Training)

    @objc(addTraining:)
    @NSManaged public func addToTraining(_ values: NSSet)

    @objc(removeTraining:)
    @NSManaged public func removeFromTraining(_ values: NSSet)

}
extension Exercises : Identifiable {

}
