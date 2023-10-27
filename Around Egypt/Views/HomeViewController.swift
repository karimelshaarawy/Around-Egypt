//
//  HomeViewController.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
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
        experiences.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.recommendedCollectionView.reloadData()
            }
        }
    }
    

    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experiences.experienceViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recommendedCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier, for: indexPath) as! RecommendedExperienceCollectionViewCell
        cell.fetchDataFromViewModel(experience: experiences.experienceViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 340, height: 200)
    }
    
    
}
