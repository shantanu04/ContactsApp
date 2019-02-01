//
//  ContactTableViewController.swift
//  ContactsApp
//
//  Created by epita on 29/01/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class ContactTableViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var tableViewController: UITableView!
    var contactsArr = [contactsModel]()
    var selectedContact : contactsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        // Do any additional setup after loading the view.
    }
    
    func fetchUserData() {
        
        
        NsurlSessionHelper().getResponseForURL(parameters: nil, url: LOGINURL + SEED + RESULT, httpMethod: HTTPMETHODGET, success: { (JSON) in
            
            print(JSON)
            if(JSON.value(forKey: "results") as? NSArray != nil)
            {
                for contact in JSON.value(forKey: "results") as! NSArray
                {
                    let contactDict = contact as! NSDictionary
                    let nameDict = contactDict.value(forKey: "name") as! NSDictionary
                    let loctionDict = contactDict.value(forKey: "location") as! NSDictionary
                    let pictureDict = contactDict.value(forKey: "picture") as!NSDictionary
                    
                    self.contactsArr.append(contactsModel(Title: nameDict.value(forKey: "title") as? String ?? "" , First: nameDict.value(forKey: "first") as? String ?? "", Last: nameDict.value(forKey: "last") as? String ?? "", Street: loctionDict.value(forKey: "street") as? String ?? "", City: loctionDict.value(forKey: "city") as? String ?? "", Email: contactDict.value(forKey: "email") as? String ?? "", Phone: contactDict.value(forKey: "phone") as? String ?? "", Cell: contactDict.value(forKey: "cell") as? String ?? "", largePicture: pictureDict.value(forKey: "large") as? String ?? ""))
                }
                
                DispatchQueue.main.async {
                    self.tableViewController.reloadData()
                }
                
                
                
            }
        }) { (Error) in
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        
        cell.nameLabel.text = contactsArr[indexPath.row].First.capitalized + " " + contactsArr[indexPath.row].Last.capitalized
        cell.emailIDLabel.text = contactsArr[indexPath.row].Email
        
        let url = URL(string: contactsArr[indexPath.row].largePicture)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        cell.contactImageView.image = UIImage(data: data!)
        
        // set alternate colors for rows
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 166/255, green: 177/255, blue: 225/255, alpha: 0.4);
        } else {
            cell.backgroundColor = UIColor(red: 166/255, green: 177/255, blue: 225/255, alpha: 0.1);
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selectedContact = contactsArr[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetailed", sender: self)
        
    }

    // preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetailed" {
            if let destinationVC = segue.destination as? DetailedViewController {
                destinationVC.contact = selectedContact
            }
        }
        
    }

}
