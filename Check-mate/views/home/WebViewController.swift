//
//  WebViewController.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 9. 22..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url : URL = URL(string: "http://www.moel.go.kr/")!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touchUpBackButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
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
