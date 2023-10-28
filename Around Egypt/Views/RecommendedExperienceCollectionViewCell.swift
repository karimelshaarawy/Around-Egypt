//
//  RecommendedExperienceCollectionViewCell.swift
//  Around Egypt
//
//  Created by Karim Elshaarawy on 27/10/2023.
//

import UIKit
import Kingfisher

class RecommendedExperienceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var recomendedImageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    
    var postLike: ((@escaping ()->Void) -> Void)?
    var reload: (() -> Void)?

    
    static let identifier = "RecommendedExperienceCollectionViewCell"
    static var nib : UINib{
        return UINib(nibName: identifier , bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    func fetchDataFromViewModel(experience: ExperienceViewModel){
        imageView.kf.setImage(with: URL(string: experience.coverPhoto))
        locationNameLabel.text = experience.title
        likesNumberLabel.text = "\(experience.noOfLikes)"
        likeButton.imageView!.image = experience.isLiked ? UIImage(named: "like") : UIImage(named: "unlike")
        viewsLabel.text = "\(experience.viewsNumber)"
        recomendedImageView.image = experience.recommended == 1 ? UIImage(named: "star") : UIImage(named: "")
        postLike = experience.addLike
        
    }
    
    @IBAction func postLikeAction(_ sender: Any) {
        if let postLike = postLike{
            postLike(reload!)

        }
    }
    
}
