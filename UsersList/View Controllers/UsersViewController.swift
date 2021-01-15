//
//  UsersViewController.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var loadeDelegate : LoadeDataDelegate?
    var selectOfRow : SelectOfRow?
    
    var userData : [User] = []
    var searchData : [User] = []
    var isSearch = false
    var isUpdate = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usersTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        usersTableView.dataSource = self
        usersTableView.delegate = self
        usersTableView.backgroundColor = .white
    }
    
    func search(text: String) {
        if !text.isEmpty {
            isSearch = true
            searchData = userData.filter({ (array: User) -> Bool in
               if array.name.first.lowercased().contains(text.lowercased()) ||
                  array.name.last.lowercased().contains(text.lowercased()) ||
                  array.location.country.lowercased().contains(text.lowercased()) ||
                  array.location.street.name.lowercased().contains(text.lowercased()) ||
                  array.location.street.number == Int(text) ||
                  array.gender.lowercased().contains(text.lowercased())
                {
                    return true
                } else {
                    return false
                }
            })
        } else {
            isSearch = false
        }
        usersTableView.reloadData()
    }
    
    func addData(index : Int) {
        if (index > (page * 20) - 5) && !isUpdate {
            isUpdate = true
            self.page += 1
            self.loadeDelegate?.getUsersData(index: self.page)
        }
    }
}

extension UsersViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearch ? searchData.count : userData.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersTableViewCell
        let users = isSearch ? searchData : userData
        
        guard !users.isEmpty else { return cell }
        self.addData(index: indexPath.row)
        let user = users[indexPath.row]
        cell.style(person: Person(user: user))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearch ? searchData[indexPath.row] : userData[indexPath.row]
        self.selectOfRow?.getSelect(id: user.login.uuid)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
