//
//  BaseViewController.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var parentView: UIView!
    
    var userData: [User] = []
    var savedUserData: [User] = []
    var dataRepository = DataRepository()
    
    private lazy var usersViewController: UsersViewController = {

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        self.addChildViewController(childViewController: viewController)
        viewController.loadeDelegate = self
        viewController.selectOfRow = self
        return viewController
    }()

    private lazy var savedUsersViewController: SavedUsersViewController = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SavedUsersViewController") as! SavedUsersViewController
        self.addChildViewController(childViewController: viewController)
        viewController.selectOfRow = self
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataRepository.datasource.delegate = self
        searchBar.delegate = self
        updateView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadData(page: 1)
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        view.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func loadData(page: Int) {
        self.dataRepository.call(page: page)
     }
    
    @IBAction func onClickSegment(_ sender: Any) {
        updateView()
    }
   
    func updateView() {
        
        switch segmentControl.selectedSegmentIndex {
            case 0:
                usersViewController.view.isHidden = false
                savedUsersViewController.view.isHidden = true
            case 1:
                usersViewController.view.isHidden = true
                savedUsersViewController.view.isHidden = false
            default:
                break
        }
    }
    
    private func addChildViewController(childViewController: UIViewController) {
            
        addChild(childViewController)
        self.parentView.addSubview(childViewController.view)
        
        let childView = childViewController.view
        childView?.translatesAutoresizingMaskIntoConstraints = false
        childView?.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        childView?.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        childView?.widthAnchor.constraint(equalTo: parentView.widthAnchor).isActive = true
        childView?.heightAnchor.constraint(equalTo: parentView.heightAnchor).isActive = true

        childViewController.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        childViewController.didMove(toParent: self)
        
    }

    private func removeChildViewController(childviewController: UIViewController?) {
        
        childviewController!.willMove(toParent: nil)
        childviewController!.view.removeFromSuperview()
        childviewController!.removeFromParent()
    }
    
    func getUserOfId(id: String) -> User {
        var newUser : User?
        for user in userData {
            if user.login.uuid == id {
                return user
            }
        }
        return newUser!
    }
}

extension BaseViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.usersViewController.search(text: searchText)
        self.savedUsersViewController.search(text: searchText)
        
        if searchText.isEmpty {
            view.endEditing(true)
        }
    }
}

extension BaseViewController : SearchDataDelegate {
    func getData(result: SearchResults) {
        self.usersViewController.userData += result.results
        self.usersViewController.isUpdate = false
        self.usersViewController.usersTableView.reloadData()
        self.userData += result.results
    }
}

extension BaseViewController: LoadeDataDelegate {
    func getUsersData(index: Int) {
        self.loadData(page: index)
    }
}

extension BaseViewController: SelectOfRow {
    func getSelect(id: String) {
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "UsersDetailViewController") as! UsersDetailViewController
                
                nextVC.savedUser = self
            self.navigationController?.navigationBar.backItem?.title = "Users"
            self.navigationController?.pushViewController(nextVC, animated: true)
            nextVC.user = self.getUserOfId(id: id)
        }
    }
}

extension BaseViewController: SavedUser {
    func getUser(id: String, isFavourite: Bool) {
        var changeUser : User?
        for (index, user) in userData.enumerated() {
            if user.login.uuid == id {
                userData[index].isFavourite = isFavourite
                changeUser = userData[index]
            }
        }
        self.usersViewController.userData = self.userData
        self.usersViewController.usersTableView.reloadData()
        
        guard let user = changeUser else { return }
        if isFavourite {
            savedUserData.append(user)
        } else {
            for (index, value) in savedUserData.enumerated() {
                if value.login.uuid == id {
                    savedUserData.remove(at: index)
                }
            }
        }
        self.savedUsersViewController.userData = self.savedUserData
        self.savedUsersViewController.usersTableView.reloadData()
    }
}
