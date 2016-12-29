//
//  loginViewController.swift
//  I OS Test
//
//  Created by Sergey Matveev on 25/12/2016.
//  Copyright © 2016 Greenlite.cg. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        if (userEmail!.isEmpty || userPassword!.isEmpty )  {return;}
        
        
        //send user data to server side
        
        let myUrl = NSURL(string: "htpp://yandec.ur/user-register/userRegister.php")
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        let postString = "email=\(userEmail)&password=\(userPassword)";
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            
            var err: NSError?
            
            let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
            
            if let parseJSON = json {
            
            let resultValue = parseJSON ["status"] as? String
                print ("result: \(resultValue)")
                
                if(resultValue=="Success"){
                //
                
           
                // login is succesful
                
                UserDefaults.standard.set(true, forKey: "isUserLoggedin");
                UserDefaults.standard.synchronize();
                
                
                self.dismiss(animated: true,completion:nil);
                    
                
            }
            
        }
    }
    
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
