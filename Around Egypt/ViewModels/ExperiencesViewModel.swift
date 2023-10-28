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
       APIManager.getRecentExperiences {[weak self] experiences, error in
           if error != nil {
               print(error ?? "ERROR")
           }else{
               if let experiences = experiences{
                   
                   if(experiences.count > 0){
                       self?.recentExperienceViewModels = self!.changeDatumToViewModels(datum: experiences)
                   }                }
           }
           
       }
       
   }
    
    func getSearchedForExperiences(searchWord:String) {
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
    
}
