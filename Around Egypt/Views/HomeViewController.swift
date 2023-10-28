//
//  HomeViewController.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    
    @IBOutlet weak var mostRecentCollectionView: UICollectionView!
    var experiences: ExperiencesViewModel = ExperiencesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
//        initializeHideKeyboard()
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
            cell.reload = recommendedCollectionView.reloadData
            return cell
        }
        
        else{
            let cell = mostRecentCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier, for: indexPath) as! RecommendedExperienceCollectionViewCell
            cell.fetchDataFromViewModel(experience:experiences.recentExperienceViewModels[indexPath.row])
            cell.reload = mostRecentCollectionView.reloadData
            return cell}
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 340, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedCollectionView{
            var vc = ExperienceMainPage(experience: experiences.experienceViewModels[indexPath.row])
            vc.reload = recommendedCollectionView.reloadData
            let hostingController = UIHostingController(rootView: vc)
            self.present(hostingController, animated: true)
        }else{
            var vc = ExperienceMainPage(experience: experiences.recentExperienceViewModels[indexPath.row])
            vc.reload = mostRecentCollectionView.reloadData
            let hostingController = UIHostingController(rootView: vc)
            self.present(hostingController, animated: true)        }

    }
}

extension HomeViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.searchText = searchBar.text
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func initializeHideKeyboard(){
    //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
    target: self,
    action: #selector(dismissMyKeyboard))
    //Add this tap gesture recognizer to the parent view
    view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
    //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
    //In short- Dismiss the active keyboard.
    view.endEditing(true)
    }
}
    
