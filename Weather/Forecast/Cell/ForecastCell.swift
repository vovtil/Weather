//
//  ForecastCell.swift
//  Weather
//
//  Created by Ефремов Владимир on 16.09.2018.
//  Copyright © 2018 OrangeSoda. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurate(item: ForecastItem) {
        self.titleLabel.text = item.title
        self.subTitleLabel.text = item.subTitle
        self.descriptionLabel.text = item.description
        ApiManager.loadImage(by: item.iconName) { [weak self ] image in
            self?.icon.image = image
        }
    }

}
