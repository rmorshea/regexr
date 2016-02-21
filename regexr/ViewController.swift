//
//  ViewController.swift
//  regexr
//
//  Created by Ryan Morshead on 2/19/16.
//  Copyright © 2016 RyanMorshead. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var cancelSignOutButton: UIButton!
    
    @IBAction func profilePicPressed(sender: AnyObject) {
        self.signOutButton.enabled = true
        self.signOutButton.hidden = false
        self.cancelSignOutButton.enabled = true
        self.cancelSignOutButton.hidden = false
    }
    
    @IBAction func signOutPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        self.signOutButton.enabled = false
        self.signOutButton.hidden = true
        self.cancelSignOutButton.enabled = false
        self.cancelSignOutButton.hidden = true
        refreshInfterface()
    }
    
    @IBAction func cancelSignOutPressed(sender: AnyObject) {
        self.signOutButton.enabled = false
        self.signOutButton.hidden = true
        self.cancelSignOutButton.enabled = false
        self.cancelSignOutButton.hidden = true
    }
    
    func refreshInfterface() {
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            
            signInButton.hidden = true
            signInLabel.hidden = true
            
            let profilePicURL = currentUser.profile.imageURLWithDimension(40)
            profilePic.image = UIImage(data: NSData(contentsOfURL: profilePicURL)!)
            self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2
            self.profilePic.clipsToBounds = true
            self.profilePicButton.enabled = true
            profilePic.hidden = false
            
        } else {
            
            signInButton.hidden = false
            signInLabel.hidden = false
            
            self.profilePicButton.enabled = false
            profilePic.image = nil
            profilePic.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshInfterface()
        (UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refreshInfterface
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

