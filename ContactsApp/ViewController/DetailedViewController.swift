//
//  DetailedViewController.swift
//  ContactsApp
//
//  Created by epita on 29/01/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    var contact : contactsModel!
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDataToLabel()
        // Do any additional setup after loading the view.
    }
    
    func setDataToLabel() {
        
        TitleLabel.text = "Title: " + contact.Title.capitalized
        firstNameLabel.text = "Firstname: " + contact.First.capitalized
        lastNameLabel.text = "Lastname: " + contact.Last.capitalized
        streetLabel.text = "Street: " + contact.Street.capitalized
        cityLabel.text = "City: " + contact.City.capitalized
        emailLabel.text = "Email: " + contact.Email
        phoneLabel.text = "Phone: " + contact.Phone
        cellLabel.text = "Cell: " + contact.Cell
        
        
        let url = URL(string: contact.largePicture)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch	
        userProfileImageView.image = UIImage(data: data!)
    }

}
