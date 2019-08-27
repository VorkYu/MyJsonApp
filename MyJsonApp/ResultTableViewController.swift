//
//  ResultTableViewController.swift
//  MyJsonApp
//
//  Created by VorkYu on 2019/8/23.
//  Copyright © 2019 VorkYu. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {

    struct PropertyKeys {
        static let loverCell = "movieCell"
    }
    
    var index: Int
    var urlStr: String?
    var movieDataset = [Results]()
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    init?(coder: NSCoder, index:Int, urlStr: String?) {
        self.index = index
        self.urlStr = urlStr
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let urlStr = urlStr {
            showIndicator()
            getMovieData(urlStr: urlStr)
        }
    }
    
//    weak var activityIndicatorView: UIActivityIndicatorView!
    func showIndicator() {
        self.tableView.backgroundView = activityIndicatorView
//        self.activityIndicatorView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    
    @IBSegueAction func showDetail(_ coder: NSCoder) -> DetailViewController? {
        if let row = tableView.indexPathForSelectedRow?.row {
            let movieDetail = movieDataset[row]
            return DetailViewController(coder: coder, index: index, movieDetail: movieDetail)
        } else {
            return nil
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieDataset.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.loverCell, for: indexPath) as? ResultTableViewCell else { return UITableViewCell() }
        
        let movieData = movieDataset[indexPath.row]
        cell.update(with: movieData)
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ResultTableViewController {
    func getMovieData(urlStr: String) {
        if let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let MovieResults = try JSONDecoder().decode(MovieData.self, from: data)
                        self.movieDataset = MovieResults.feed.results
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch  {
                        let controller = UIAlertController(title: "錯誤", message: "查無資料", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "確定", style: .default) { (action) in
                        self.navigationController?.popViewController(animated: true)
                        }
                        
                        controller.addAction(alertAction)
                        self.present(controller, animated: true, completion: nil)
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
