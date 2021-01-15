//
//  UsersTableViewCell.swift
//  UsersListTask
//
//  Created by Yerem Sargsyan on 29.12.20.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderAndPhoneLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func style(person: Person)  {
        self.userImage.showImage(url: person.picture)
        self.userImage.layer.cornerRadius = 10
        self.nameLabel.text = person.name
        self.genderAndPhoneLabel.text = person.genderAndPhone
        self.countryLabel.text = person.country
        self.addressLabel.text = person.address
    }
    
}
