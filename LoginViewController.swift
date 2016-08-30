//
//  LoginViewController.swift
//  Carousel
//
//  Created by Goodman, Dustin on 8/29/16.
//  Copyright © 2016 Dustin Goodman. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var loginLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginBackButton: UIButton!
    
    
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
    
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -140

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func signInButton(sender: AnyObject) {
        if (self.emailTextField.text!.isEmpty) {
            let alertController = UIAlertController(title: "Email Required", message: "Please enter your email address", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in print("empty email")}
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if (self.passwordTextField.text!.isEmpty) {
            let alertController = UIAlertController(title: "Password Required", message: "Please enter your password", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in print("empty pw")}
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.loginLoadingIndicator.startAnimating()
            delay(2) {
                if (self.emailTextField.text! == "d" && self.passwordTextField.text! == "d") {
                    self.loginLoadingIndicator.stopAnimating()
                    self.performSegueWithIdentifier("loginCompletedSegue", sender: nil)
                } else {
                    self.loginLoadingIndicator.stopAnimating()
                    let alertController = UIAlertController(title: "Invalid Email or Password", message: "Please enter a valid Email and Password", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in print("wrong pw")}
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }

    }
    
    
   
    
    @IBAction func loginBackButton(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }

    
    override func viewWillAppear(animated: Bool) {
        let transform = CGAffineTransformMakeScale(0.2, 0.2)
        fieldParentView.transform = transform
        fieldParentView.alpha = 0
        buttonParentView.transform = transform
        buttonParentView.alpha = 0
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.fieldParentView.transform = CGAffineTransformIdentity
            self.fieldParentView.alpha = 1
            self.buttonParentView.transform = CGAffineTransformIdentity
            self.buttonParentView.alpha = 1
        }
    }

    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = CGFloat(scrollView.contentOffset.y)
        print(offset)
        if scrollView.contentOffset.y < -50 {
            view.endEditing(true)
        }
    }
    
    func keyboardWillShow(notification: NSNotification){
        print("keyboardWillShow")
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
        
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
