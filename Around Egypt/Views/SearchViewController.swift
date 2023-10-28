//
//  SearchViewController.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 28/10/2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    var experiences: ExperiencesViewModel = ExperiencesViewModel()
    var searchText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.text = searchText
        initializeCollectionView()
        initializeHideKeyboard()
    }
    func initializeCollectionView(){
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(RecommendedExperienceCollectionViewCell.nib, forCellWithReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier)
        if let searchText = searchText {
            experiences.getSearchedForExperiences(searchWord: searchText)
        }
        experiences.reloadRecommendedCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
            }
        }
    }


    
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experiences.experienceViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendedExperienceCollectionViewCell.identifier, for: indexPath) as! RecommendedExperienceCollectionViewCell
            cell.fetchDataFromViewModel(experience: experiences.experienceViewModels[indexPath.row])
        cell.reload = searchCollectionView.reloadData
            return cell
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 340, height: 200)
    }
}

extension SearchViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true)
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        experiences.getSearchedForExperiences(searchWord: searchBar.text ?? "")
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
