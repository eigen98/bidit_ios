//
//  PolicyVC.swift
//  Bidit
//
//  Created by JeongMin Ko on 2022/07/10.
//

import Foundation
import UIKit
//서비스 이용약관
class PolicyVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    /*
      네비게이션 바
     */
    private func setNavigationBar(){
        //self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = . gray
        self.navigationController?.navigationBar.isHidden = false
        self.title = "서비스 이용약관"

        self.tabBarController?.tabBar.isHidden = true
    }
    

}