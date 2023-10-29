//
//  LikedLocations+CoreDataProperties.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 29/10/2023.
//
//

import Foundation
import CoreData


extension LikedLocations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedLocations> {
        return NSFetchRequest<LikedLocations>(entityName: "LikedLocations")
    }

    @NSManaged public var id: String?

}

extension LikedLocations : Identifiable {

}
