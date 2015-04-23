//
//  ViewController.swift
//  SocialMediaIntegration
//
//  Created by STEFAN JOSTEN on 02/03/15.
//  Copyright (c) 2015 Stefan. All rights reserved.
//

import UIKit
import Social
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleAppStore(sender: AnyObject) {
        let alert = UIAlertController(title: "Rate", message:  "Rate my App", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Rate", style: UIAlertActionStyle.Default)  { _ in
            // Open App in AppStore
            let iLink = "https://itunes.apple.com/us/app/yet-another-spaceshooter/id949662362?mt=8"
            UIApplication.sharedApplication().openURL(NSURL(string: iLink)!)
        } )
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func handleFacebook(sender: AnyObject) {
        // Check if Facebook is available
        if (SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook))
        {
            // Create the post
            let post = SLComposeViewController(forServiceType: (SLServiceTypeFacebook))
            post.setInitialText("I want to share this App: ")
            post.addImage(UIImage(named: "shareImage"))
            self.presentViewController(post, animated: true, completion: nil)
        } else {
            // Facebook not available. Show a warning
            let alert = UIAlertController(title: "Facebook", message: "Facebook not available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleTwitter(sender: AnyObject) {
        // Check if Twitter is available
        if(SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)) {
            // Create the tweet
            let tweet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweet.setInitialText("I want to share this App: ")
            tweet.addImage(UIImage(named: "shareImage"))
            self.presentViewController(tweet, animated: true, completion: nil)
        } else {
            // Twitter not available. Show a warning
            let alert = UIAlertController(title: "Twitter", message: "Twitter not available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func handleMail(sender: AnyObject) {
        // Check if Mail is available
        if(MFMailComposeViewController.canSendMail()){
            // Create the mail message
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("New App")
            mail.setMessageBody("I want to share this App: ", isHTML: false)
            // Attach the image
            let imageData = UIImagePNGRepresentation(UIImage(named: "shareImage"))
            mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "Image")
            self.presentViewController(mail, animated: true, completion: nil)
        } else {
            // Mail not available. Show a warning
            let alert = UIAlertController(title: "Email", message: "Email not available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // Required by interface MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        // Close the mail dialog
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

