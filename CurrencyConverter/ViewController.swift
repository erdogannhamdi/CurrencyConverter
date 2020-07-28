//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Apple on 27.07.2020.
//  Copyright © 2020 erdogan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCAD: UILabel!
    @IBOutlet weak var lblCHF: UILabel!
    @IBOutlet weak var lblJPY: UILabel!
    @IBOutlet weak var lblUSD: UILabel!
    @IBOutlet weak var lblTRY: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //http bağlantılar için info.plist içine
    //App Transport Security Settings => Allow Arbitrary Loads => YES
    
    @IBAction func getRates(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=5a3a0d17617a215db6355f318442be69&format=1")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let btnOk = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(btnOk)
                self.present(alert, animated: true, completion: nil)
            } else{
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any]{
                                if let cad = rates["CAD"] as? Double{
                                    self.lblCAD.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.lblCHF.text = "CHF: \(chf)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.lblJPY.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.lblUSD.text = "USD: \(usd)"
                                }
                                if let tryRate = rates["TRY"] as? Double{
                                    self.lblTRY.text = "TRY: \(tryRate)"
                                }
                            }
                        }
                    } catch{
                        print("Error!")
                    }
                    
                }
            }
        }
        task.resume()
        
    }
    
}

