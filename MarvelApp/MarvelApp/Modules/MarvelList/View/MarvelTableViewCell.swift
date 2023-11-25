//
//  MarvelTableViewCell.swift
//  MarvelApp
//
//  Created by Dalia on 17/11/2023.
//

import UIKit
import Kingfisher

class MarvelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var MarvelImage: UIImageView!
    @IBOutlet weak var MarvelName: UILabel!
    @IBOutlet weak var MarvelRating: UILabel!
    @IBOutlet weak var MarvelYear: UILabel!
    @IBOutlet weak var LoaderView: UIView!
    @IBOutlet weak var ActiveIndicator: UIActivityIndicatorView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        MarvelName.text = nil
        MarvelYear.text = nil
        MarvelImage.image = nil
        MarvelRating.text = nil
        DescriptionLabel.text = nil
        LoaderView.isHidden = true
        ActiveIndicator.stopAnimating()
        chevron.image = UIImage(systemName: "chevron.down")
    }
    
    func configure(with viewModel: MarvelCellViewModel) {
        MarvelName.text = "Name: \(viewModel.name ?? "")"
        MarvelRating.text = "Rate: \(viewModel.rating ?? "")"
        MarvelYear.text = "Year: \(viewModel.year ?? 0)"
        DescriptionLabel.text = "Description: \(viewModel.description ?? "")"
        let marvelLogo = "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg"
        let imageUrl = viewModel.image ?? marvelLogo
        
        if let imageUrl = URL(string: imageUrl),
           let imageUrl = URL(string: marvelLogo) {
            MarvelImage.kf.setImage(with: imageUrl)
        }
        chevron.image = (isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"))
    }
    
    func updateCellUIForExpansion() {
        chevron.image = UIImage(systemName: "chevron.up")
        LoaderView.isHidden = false
        ActiveIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.updateCellUIForContraction()
            self?.DescriptionLabel.isHidden = false
        }
    }
    
    func updateCellUIForContraction() {
        chevron.image = UIImage(systemName: "chevron.down")
        LoaderView.isHidden = true
        ActiveIndicator.stopAnimating()
        DescriptionLabel.isHidden = true
    }
    
    func toggleCellExpansion() {
        isExpanded = !isExpanded
        
        if isExpanded {
            updateCellUIForExpansion()
        } else {
            updateCellUIForContraction()
        }
        
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.layoutIfNeeded()
            self.layoutSubviews()
        }, completion: nil)
    }
}
