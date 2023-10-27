//
//  HomeViewController.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    @IBOutlet weak var mostRecentCollectionView: UICollectionView!
    var experiences: ExperiencesViewModel = ExperiencesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        // Do any additional setup after loading the view.
    }
    func initCollectionView(){
        recommendedCollectionView.register(RecommendedExperienceCollectionViewCell.nib, forCellWithReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier)
        recommendedCollectionView.delegate = self
        recommendedCollectionView.dataSource = self
        experiences.getRecommendedExperiences()
        experiences.reloadRecommendedCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.recommendedCollectionView.reloadData()
            }
        }
        experiences.getRecentExperiences()
        experiences.reloadRecentCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.mostRecentCollectionView.reloadData()
            }
        }
        
        mostRecentCollectionView.register(RecommendedExperienceCollectionViewCell.nib, forCellWithReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier)
        mostRecentCollectionView.delegate = self
        mostRecentCollectionView.dataSource = self
    }
    

    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendedCollectionView{
            return experiences.experienceViewModels.count}
        else{
            return experiences.recentExperienceViewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recommendedCollectionView{
            let cell = recommendedCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier, for: indexPath) as! RecommendedExperienceCollectionViewCell
            cell.fetchDataFromViewModel(experience: experiences.experienceViewModels[indexPath.row])
            return cell
        }
        
        else{
            let cell = mostRecentCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier, for: indexPath) as! RecommendedExperienceCollectionViewCell
            cell.fetchDataFromViewModel(experience:experiences.recentExperienceViewModels[indexPath.row])
            return cell}
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 340, height: 200)
    }
}
    
