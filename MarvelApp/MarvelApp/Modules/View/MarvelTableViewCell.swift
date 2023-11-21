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

    var isExpanded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with viewModel: MarvelCellViewModel) {
        MarvelName.text = "Name: \(viewModel.name ?? "")"
        MarvelRating.text = "Rate: \(viewModel.rating ?? "")"
        MarvelYear.text = "Year: \(viewModel.year ?? 0)"
        DescriptionLabel.text = "Description: \(viewModel.description ?? "description ?? "")"

        var marvelLogo = "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg"
        var imageUrl = viewModel.image ?? marvelLogo
        
        if let imageUrl = URL(string: imageUrl),
            let imageUrl = URL(string: marvelLogo) {
            MarvelImage.kf.setImage(with: imageUrl)
        }
    }
    
    func didPressed() {
        if isExpanded {
            LoaderView.isHidden = true
            ActiveIndicator.stopAnimating()
            DescriptionLabel.isHidden = true
        } else {
            LoaderView.isHidden = false
            ActiveIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.LoaderView.isHidden = true
                self?.ActiveIndicator.stopAnimating()

                self?.DescriptionLabel.isHidden = false
            }
        }
        isExpanded = !isExpanded
        layoutIfNeeded()
        layoutSubviews()
    }
}
