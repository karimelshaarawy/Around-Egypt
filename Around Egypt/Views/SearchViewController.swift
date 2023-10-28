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
        // Do any additional setup after loading the view.
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
}
