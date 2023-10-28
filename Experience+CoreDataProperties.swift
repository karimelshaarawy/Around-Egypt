//
//  Experience+CoreDataProperties.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 28/10/2023.
//
//

import Foundation
import CoreData


extension Experience {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Experience> {
        return NSFetchRequest<Experience>(entityName: "Experience")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var coverPhoto: String?
    @NSManaged public var locationDescription: String?
    @NSManaged public var noOfLikes: Int64
    @NSManaged public var recommended: Int64
    @NSManaged public var viewsNumber: Int64
    @NSManaged public var isLiked: Bool
    @NSManaged public var address: String?

}

extension Experience : Identifiable {

}
