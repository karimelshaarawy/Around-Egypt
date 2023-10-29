//
//  ExperienceViewModel.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation
import UIKit
import CoreData

class ExperienceViewModel: ObservableObject{

    
    var id: String
    var title: String
    var coverPhoto: String
    var description: String
   @Published var noOfLikes: Int
    var recommended: Int
    var viewsNumber: Int
   @Published var isLiked: Bool = false
    var address: String
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    init(experience:Datum){
        id = experience.id ?? "0"
        title = experience.title ?? ""
        coverPhoto = experience.coverPhoto ?? ""
        description = experience.description ?? ""
        noOfLikes = experience.likesNo ?? 0
        recommended = experience.recommended ?? 0
        viewsNumber = experience.viewsNo ?? 0
        address = (experience.city?.name ?? "" ) + ", Egypt"
        isLiked = isLikedLocation()
        
    }
    
    
    init(experience:Experience){
        id = experience.id ?? "0"
        title = experience.title ?? ""
        coverPhoto = experience.coverPhoto ?? ""
        description = experience.locationDescription ?? ""
        noOfLikes = Int(experience.noOfLikes)
        recommended = Int(experience.recommended)
        viewsNumber = Int(experience.viewsNumber)
        address = experience.address ?? ""
        isLiked = isLikedLocation()

    }
    
    
    func addLike(reload:@escaping()->Void)->Void{
        if(isLiked == false){
            APIManager.postLikeRequest(id: id) {[weak self] likes, error in
                if(error == nil){
                    self!.isLiked = true
                    if let likes = likes{
                        self?.noOfLikes = likes
                        let likedLocation = LikedLocations(context: self!.context)
                        likedLocation.id = self?.id
                        do {
                            try self?.context.save()
                        }catch{
                            
                        }
                        reload()
                    }
                    
                }
            }
        }
    }
    
    func isLikedLocation()->Bool{
        var likes = [LikedLocations]()
        do{
            let request = LikedLocations.fetchRequest()
            let pred = NSPredicate(format: "id == %@", id)
            request.predicate = pred
            likes = try context.fetch(request)
            
        }catch{
            
        }
        if(likes.count == 0){
            return false
        }
        return true
    }
    
    
}


