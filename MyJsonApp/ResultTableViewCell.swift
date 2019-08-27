//
//  ResultTableViewCell.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/23.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with movieData: Results) {
        loading.startAnimating()
        setImageView(from: movieData.artworkUrl100)
        detailLabel.text = movieData.name
    }
    
    func setImageView(from url: URL) {
        detailImg.image = nil
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.detailImg.image = image
                    self.loading.stopAnimating()
                }
            }
        }
        
        task.resume()
    }
}
