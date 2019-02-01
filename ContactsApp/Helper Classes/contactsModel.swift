//
//  contactsModel.swift
//  ContactsApp
//
//  Created by epita on 29/01/2019.
//  Copyright © 2019 epita. All rights reserved.
//

import UIKit

class contactsModel: NSObject {
    
    var Title : String
    var First : String
    var Last  : String
    var Street : String
    var City : String
    var Email : String
    var Phone : String
    var Cell : String
    var largePicture : String
    
    init(Title : String, First : String, Last : String, Street : String, City : String, Email : String, Phone : String, Cell : String, largePicture : String)
    {
        self.Title = Title
        self.First = First
        self.Last = Last
        self.Street = Street
        self.City = City
        self.Email = Email
        self.Phone = Phone
        self.Cell = Cell
        self.largePicture = largePicture
    }

}
