//
//  SecondViewController.swift
//  map-start
//
//  Created by karlis.berzins on 03/03/2021.
//

import UIKit

protocol SecondVCDelegate {
    func updateText(text: String)
}

class SecondViewController: UIViewController {

    var delegate: SecondVCDelegate?

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        if let text = textField.text, let delegate = delegate {
            delegate.updateText(text: text)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
