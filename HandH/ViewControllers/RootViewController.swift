//
//  RootViewController.swift
//  HandH
//
//  Created by Alpaca Dev on 22.05.2018.
//  Copyright © 2018 Denis Dultsev. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    // MARK: - View Controller Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium),
            .foregroundColor: UIColor.handh.black(),
            .kern: -0.4
        ]
        
    }
    

}
