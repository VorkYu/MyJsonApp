//
//  IndicatorModel.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/27.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import Foundation
import UIKit

struct Loading {
    let tableView: UITableView
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    func setLoadingScreen() {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2)
//        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)

        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)

        // Sets spinner
        spinner.style = .large
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()

        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)

        tableView.addSubview(loadingView)

    }
    
    func removeLoadingScreen() {
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
}
