//
//  ViewController.swift
//  GDTest
//
//  Created by Сергей Шестаков on 15.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class ListOfPeopleViewController: UIViewController {
    
    // MARK: - Subviews
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var featchingMore = false
    var items = [PersonObject]()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        addPerson()
    }
    // MARK: - Methods
    @objc private func addPerson() {
        ApiManager.sharedInstance.getRundomUser { (json: JSON) in
            if let results = json["results"].array {
                for entry in results {
                    self.items.append(PersonObject(json: entry))
                }
                DispatchQueue.main.async {
                    self.featchingMore = false
                    self.tableView.reloadData()
                }
            }
        }
    }


}
// MARK: - TableViewDelegate, TableViewDataSource
extension ListOfPeopleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        }
        let person = self.items[indexPath.row]
        if let url = NSURL(string: person.pictureURL) {
            if let data = NSData(contentsOf: url as URL) {
                cell?.imageView?.image = UIImage(data: data as Data)
            }
        }
        cell!.textLabel?.text = person.fullName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        let person = self.items[indexPath.row]
        profileVC?.fullName = person.fullName
        if let url = NSURL(string: person.pictureURLFull) {
            if let data = NSData(contentsOf: url as URL) {
                profileVC?.image = UIImage(data: data as Data)!
            }
        }
        profileVC?.email = person.email
        profileVC?.dataBorn = person.dataBorn
        profileVC?.age = person.age
        profileVC?.time = person.gmt
        profileVC?.gender = person.gender
        self.navigationController?.pushViewController(profileVC!, animated: true)
    }
    //MARK: - ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentTop = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        
        if contentTop > contentHight - scrollView.frame.height {
            if !featchingMore {
                beginUpdateTableView()
            }
        }
    }
    func beginUpdateTableView() {
        featchingMore = true
        addPerson()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
}

