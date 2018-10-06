//
//  LoginViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 9. 7..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIView!
    var session: KOSession!
    var loadingDialog: LoadingDialog!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginBtnClicked)))
        self.loadingDialog = LoadingDialog(frame: self.view.bounds)
        
        session = KOSession.shared()
        session.presentingViewController = self
        
        checkAutoLogined()
    }
    
    func checkAutoLogined() {
        if(session.isOpen()) {
            KOSessionTask.userMeTask(completion: { (error, me) in
                guard let user = me,
                      let userId = user.id,
                      let nickName = user.nickname else {
                    print("KOSessionTask.userMeTask failed \(String(describing: error))")
                    return
                }
                
                self.login(userId: userId, nickName: nickName)
            })
        }
    }
    
    @objc func loginBtnClicked() {
        if session.isOpen() {
            session.close()
        }
        
        login(userId: "jobata", nickName: "123456789")
    }
    
    func login(userId: String, nickName: String) {
        ServerClient.login(id: userId, nickName: nickName, email: "") { success in
            DispatchQueue.main.async {
                if (success) {
                    let vc = UIStoryboard.instantiate(TabBarController.self, storyboardName: "TabBarController")
                    self.present(vc, animated: false)
//                    let vc = UIStoryboard.instantiate(MapViewController.self, storyboardName: "MapViewController")
                } else {
                    print("ServerClient.login failed")
                }
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
