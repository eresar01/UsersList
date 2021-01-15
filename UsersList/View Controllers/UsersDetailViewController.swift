//
//  UsersDetailViewController.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import UIKit
import MapKit

class UsersDetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var remuveButton: UIButton!
    
    var savedUser : SavedUser?
    
    var index = 0
    var user : User?
    var person : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        person = Person(user: user!)
        
        loadViewData(person : person!)
        imageStyle(image: self.userImage)
        buttonStyle()
        defaultData()
    }
    
    func loadViewData(person : Person) {
        self.userImage.showImage(url: person.picture)
        self.showLocation(mapView: self.mapView, location: person.coordinates)
        self.nameLabel.text = person.name
        self.genderLabel.text = person.genderAndPhone
        self.countryLabel.text = person.country
        self.addressLabel.text = person.address
    }
    
    func defaultData() {
        self.navigationItem.title = person!.name
        let backButton = UIBarButtonItem()
        backButton.title = "Users"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.backgroundColor = .systemGray5
        self.saveButton.layer.cornerRadius =  self.saveButton.frame.height / 2
    }
    
    func imageStyle(image : UIImageView) {
        image.layer.cornerRadius = self.userImage.frame.width / 2
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
    }
    
    func showLocation(mapView : MKMapView, location : LocationUser) {
        let coordinate = CLLocationCoordinate2D(latitude:
                                                    location.latitude, longitude: location.longitude)
        let annotations = MKPointAnnotation()
            annotations.coordinate = coordinate
        self.mapView.addAnnotation(annotations)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }

    func buttonStyle() {
        
        switch person!.isFavourite {
        case true:
            self.saveButton.backgroundColor = UIColor.systemGray4
            self.saveButton.isEnabled = false
            self.remuveButton.isHidden = false
            self.saveButton.setTitleColor(UIColor.black, for: .normal)
            self.saveButton.setTitle("User saved", for: .normal)
        case false:
            self.saveButton.backgroundColor = UIColor.saveButton()
            self.remuveButton.isHidden = true
            self.saveButton.isEnabled = true
            self.saveButton.setTitleColor(UIColor.white, for: .normal)
            self.saveButton.setTitle("Save user", for: .normal)
        }
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        person!.isFavourite = true
        buttonStyle()
        self.savedUser?.getUser(id: person!.id, isFavourite: person!.isFavourite)
    }
    
    @IBAction func remuveButtonAction(_ sender: Any) {
        person!.isFavourite = false
        buttonStyle()
        self.savedUser?.getUser(id: person!.id, isFavourite: person!.isFavourite)
    }
    
}
