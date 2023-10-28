//
//  ExperiencesViewModel.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation
import UIKit
import CoreData

class ExperiencesViewModel{
    var reloadRecommendedCollectionView: (() -> Void)?

    var reloadRecentCollectionView: (() -> Void)?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var experiencesArr = [Experience]()

    var experienceViewModels = [ExperienceViewModel](){
        didSet{
            reloadRecommendedCollectionView?()
        }
    }
    
    var recentExperienceViewModels = [ExperienceViewModel](){
        didSet{
            reloadRecentCollectionView?()
        }
    }
    
    
     func getRecommendedExperiences() {
         var recommendedArr = [Experience]()
         do{
             let request = Experience.fetchRequest()
             let pred = NSPredicate(format: "recommended == %@", NSNumber(value: 1))
             request.predicate = pred
             recommendedArr = try context.fetch(request)
             
         }catch{
             
         }
         if(recommendedArr.count>0){
             experienceViewModels = changeExperienceToViewModels(datum: recommendedArr)
         }
         
         
        APIManager.getRecommendedExperiences {[weak self] experiences, error in
            if error != nil {
                print(error ?? "ERROR")
            }else{
                if let experiences = experiences{
                    
                    if(experiences.count > 0){
                        self?.experienceViewModels = self!.changeDatumToViewModels(datum: experiences)
                    }                }
            }
            
        }
        
    }
    
    func getRecentExperiences() {
        do{
            experiencesArr = try context.fetch(Experience.fetchRequest())
            
        }catch{
            
        }
        if(experiencesArr.count != 0){
            recentExperienceViewModels = changeExperienceToViewModels(datum: experiencesArr)
        }
        
            
            APIManager.getRecentExperiences {[weak self] experiences, error in
                if error != nil {
                    print(error ?? "ERROR")
                }else{
                    if let experiences = experiences{
                        
                        if(experiences.count > 0){
                            self?.recentExperienceViewModels = self!.changeDatumToViewModels(datum: experiences)
                            self?.saveExperiences(data: self?.recentExperienceViewModels ?? [])
                        }                }
                }
                
            }
       
   }
    
    func getSearchedForExperiences(searchWord:String) {
        var searchedForArr = [Experience]()
        do{
            let request = Experience.fetchRequest()
            let pred = NSPredicate(format: "title CONTAINS[cd] %@", searchWord)
            request.predicate = pred
            searchedForArr = try context.fetch(request)
            
        }catch{
            
        }
        if(searchedForArr.count>0){
            experienceViewModels = changeExperienceToViewModels(datum: searchedForArr)
        }
        
        APIManager.getSearchedExperiences(searchText: searchWord){[weak self] experiences, error in
           if error != nil {
               print(error ?? "ERROR")
           }else{
               if let experiences = experiences{
                   
                   if(experiences.count > 0){
                       self?.experienceViewModels = self!.changeDatumToViewModels(datum: experiences)
                   }                }
           }
           
       }
       
   }
   
    
    func changeDatumToViewModels(datum: [Datum])->[ExperienceViewModel]{
        var result = [ExperienceViewModel]()
        for data in datum{
            result.append(ExperienceViewModel(experience: data))
        }
//        experienceViewModels = result
        return result
    }
    
    func changeExperienceToViewModels(datum: [Experience])->[ExperienceViewModel]{
        var result = [ExperienceViewModel]()
        for data in datum{
            result.append(ExperienceViewModel(experience: data))
        }
//        experienceViewModels = result
        return result
    }
    
    func saveExperiences(data: [ExperienceViewModel]){
        for element in data{
            let newExperience = Experience(context: context)
            newExperience.id = element.id
            newExperience.title = element.title
            newExperience.address = element.address
            newExperience.coverPhoto = element.coverPhoto
            newExperience.locationDescription = element.description
            newExperience.isLiked = element.isLiked
            newExperience.noOfLikes = Int64(element.noOfLikes)
            newExperience.viewsNumber = Int64(element.viewsNumber)
            newExperience.recommended = Int64(element.recommended)
            
            do {
                try self.context.save()
            }catch{
                
            }
            
        }
    }
    
}
