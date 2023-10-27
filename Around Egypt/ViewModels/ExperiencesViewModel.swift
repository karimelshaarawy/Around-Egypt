//
//  ExperiencesViewModel.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import Foundation

class ExperiencesViewModel{
    var reloadCollectionView: (() -> Void)?
    
    var experienceViewModels = [ExperienceViewModel](){
        didSet{
            reloadCollectionView?()
        }
    }
    
    
     func getRecommendedExperiences() {
        var result:[Datum] = []
        APIManager.getRecommendedExperiences {[weak self] experiences, error in
            if error != nil {
                print(error ?? "ERROR")
            }else{
                if let experiences = experiences{
                    
                    if(experiences.count > 0){
                        self?.changeDatumToViewModels(datum: experiences)
                    }                }
            }
            
        }
        
    }
    
    func changeDatumToViewModels(datum: [Datum]){
        var result = [ExperienceViewModel]()
        for data in datum{
            result.append(ExperienceViewModel(experience: data))
        }
        experienceViewModels = result
    }
    
}
