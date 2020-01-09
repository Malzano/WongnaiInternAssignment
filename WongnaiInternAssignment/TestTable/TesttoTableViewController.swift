//
//  TesttoTableViewController.swift
//  TestTable
//
//  Created by อธิคม ปิยะบงการ on 1/5/2563 BE.
//  Copyright © 2563 BE อธิคม ปิยะบงการ. All rights reserved.
//

import UIKit

class TesttoTableViewController: UITableViewController {
    public var header : [String] = []
    public var pic : [String] = []
    public var wod : [String] = []
    public var likeCount : [Int] = []
    private var tm = 0
    var refreshControls = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("TESTTEST")
        getJSON()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            self.refresh(sender: self)
        }
        
    }
    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        getJSON()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return header.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "someItem", for: indexPath) as! CustomTableViewCell
        let urlI = URL(string: pic[indexPath.row])!
        try!( cell.pic.image = UIImage(data: Data(contentsOf: urlI)))
        cell.header.text = header[indexPath.row]
        cell.like.image = UIImage(named:"like")
        cell.likeCount.text = String(likeCount[indexPath.row])
        cell.desc.text = wod[indexPath.row]
        // Configure the cell...
        return cell
    }
    private func getJSON() {
        guard let JSONURL = URL(string: "https://api.500px.com/v1/photos?feature=popular&page=1")else{return}
        URLSession.shared.dataTask(with: JSONURL) { (data, response
        , error) in
        guard let data = data else{return}
        do {
        let decoder = JSONDecoder()
        let JsonData = try decoder.decode(Photos.self, from: data)
           //print(JsonData)
            self.header = []
            self.pic = []
            self.wod = []
            self.likeCount = []
            for photo in JsonData.photos{
                self.header.append(photo.name)
                self.pic.append(photo.image_url.first!)
                self.wod.append(photo.description)
                self.likeCount.append(photo.positive_votes_count)
            }
//            print(self.header.first!)
//            print(self.header.count)
        }catch let err{
        print("Err", err)
        }
        }.resume()
      
    }

}
struct Photos: Codable {
    let photos: [data]
    struct data: Codable {
        let image_url: [String]
        let name : String
        let description : String
        let positive_votes_count : Int
    }
}
