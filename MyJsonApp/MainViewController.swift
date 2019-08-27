//
//  MainViewController.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/23.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var countrys = ["台灣", "香港", "日本", "美國", "澳洲"]
    var countryJSonCode = ["tw", "hk", "jp", "us", "au"]
    
    var mediaTypes = ["電影", "書籍", "iOS App", "iTunes Music", "Apple Music"]
    var mediaJSonCode = ["movies", "books", "ios-apps", "itunes-music", "apple-music"]
    
    var feedTypes = ["熱門電影"]
    var feedJSonCode = ["top-movies"]
    
    var genres = ["全部", "紀錄片", "動作與冒險"]
    var genreJSonCode = ["all", "documentary", "action-and-adventure"]
    
    var resultsLimits = ["10", "25", "50", "100"]
    
    var urlStr: String?
    var location = "tw"
    var media = "movie"
    var feed = "top-movies"
    var genre = "all"
    var limit = "10"
    
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var mediaPicker: UIPickerView!
    @IBOutlet weak var feedPicker: UIPickerView!
    @IBOutlet weak var genrePicker: UIPickerView!
    @IBOutlet weak var limitPicker: UIPickerView!
    @IBOutlet weak var allowSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBSegueAction func showMovieResult(_ coder: NSCoder) -> ResultTableViewController? {
        
        location = countryJSonCode[countryPicker.selectedRow(inComponent: 0)]
        media = mediaJSonCode[mediaPicker.selectedRow(inComponent: 0)]
        feed = feedJSonCode[feedPicker.selectedRow(inComponent: 0)]
        genre = genreJSonCode[genrePicker.selectedRow(inComponent: 0)]
        limit = resultsLimits[limitPicker.selectedRow(inComponent: 0)]
        
        let isAllowExplicit = allowSwitch.isOn ? "non-explicit.json":"explicit.json"
        let index = mediaPicker.selectedRow(inComponent: 0)
        
        urlStr = "https://rss.itunes.apple.com/api/v1/"
            + location + "/" + media + "/" + feed + "/"
            + genre + "/" + limit + "/" + isAllowExplicit
        
        return ResultTableViewController(coder: coder, index: index, urlStr: urlStr)
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

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 0:
            return countrys.count
        case 1:
            return mediaTypes.count
        case 2:
            return feedTypes.count
        case 3:
            return genres.count
        case 4:
            return resultsLimits.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 0:
            return countrys[row]
        case 1:
            return mediaTypes[row]
        case 2:
            return feedTypes[row]
        case 3:
            return genres[row]
        case 4:
            return resultsLimits[row]
        default:
            return nil
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            if mediaPicker.selectedRow(inComponent: 0) == 1 {
                let feedSize: Int? = feedTypes.count
                if row <= 1 {
                    feedTypes = ["熱門免費系列"]
                    feedJSonCode = ["top-free"]
                } else {
                    feedTypes = ["熱門免費系列", "熱門付費系列"]
                    feedJSonCode = ["top-free", "top-paid"]
                }
                if feedSize != feedTypes.count {
                    feedPicker.reloadAllComponents()
                    feedPicker.selectRow(0, inComponent: 0, animated: true)
                }
                
            }
        }
        
        if pickerView.tag == 1 {
            switch row {
            case 0:
                headline.text = "電影"
                feedTypes = ["熱門電影"]
                feedJSonCode = ["top-movies"]
                genres = ["全部", "紀錄片", "動作與冒險"]
                genreJSonCode = ["all", "documentary", "action-and-adventure"]
                
            case 1:
                headline.text = "書籍"
                feedTypes = ["熱門免費系列", "熱門付費系列"]
                feedJSonCode = ["top-free", "top-paid"]
                if countryPicker.selectedRow(inComponent: 0) <= 1 {
                    feedTypes = ["熱門免費系列"]
                    feedJSonCode = ["top-free"]
                }
                genres = ["全部"]
                genreJSonCode = ["all"]
                
            case 2:
                headline.text = "iOS App"
                feedTypes = ["『編』愛新App", "『編』愛新遊戲", "熱門免費系列", "iPad免費排行", "暢銷排行", "iPad暢銷排行", "熱門付費系列"]
                feedJSonCode = ["new-apps-we-love", "new-games-we-love", "top-free", "top-free-ipad", "top-grossing", "top-grossing-ipad", "top-paid"]
                genres = ["全部"]
                genreJSonCode = ["all"]
                
            case 3:
                headline.text = "iTunes Music"
                feedTypes = ["熱門曲目", "最新音樂", "近期推出", "熱門專輯", "熱門歌曲"]
                feedJSonCode = ["hot-tracks", "new-music", "recent-releases", "top-albums", "top-songs"]
                genres = ["全部"]
                genreJSonCode = ["all"]
                
            case 4:
                headline.text = "Apple Music"
                feedTypes = ["Coming Soon", "熱門歌單", "近期推出", "熱門專輯", "熱門歌曲"]
                feedJSonCode = ["coming-soon", "hot-tracks", "recent-releases", "top-albums", "top-songs"]
                genres = ["全部"]
                genreJSonCode = ["all"]
                
            default: break
            }
            feedPicker.reloadAllComponents()
            feedPicker.selectRow(0, inComponent: 0, animated: true)
            genrePicker.reloadAllComponents()
            genrePicker.selectRow(0, inComponent: 0, animated: true)
        }
        
    }
    
}
