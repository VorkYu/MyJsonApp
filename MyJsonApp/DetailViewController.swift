//
//  DetailViewController.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/23.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDir: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailMan: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    
    
    var index: Int
    var movieDetail: Results
    
    init?(coder: NSCoder, index: Int, movieDetail: Results) {
        self.index = index
        self.movieDetail = movieDetail
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle(index: index)
        downLoadImg(with: movieDetail.artworkUrl100)
        movieName.text = movieDetail.name
        movieDir.text = movieDetail.artistName
        movieRelease.text = movieDetail.releaseDate
        
    }
    
    func setTitle(index: Int){
        switch index {
        case 0:
            detailTitle.text = "片名"
            detailMan.text = "導演"
            detailDate.text = "上映日期"
        case 1, 2:
            detailTitle.text = "名稱"
            detailMan.text = "作者"
            detailDate.text = "日期"
        case 3, 4:
            detailTitle.text = "歌名"
            detailMan.text = "歌手"
            detailDate.text = "日期"
        default:
            break
        }
    }
    
    func downLoadImg(with url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.movieImg.image = image
                }
            }
        }
        task.resume()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
