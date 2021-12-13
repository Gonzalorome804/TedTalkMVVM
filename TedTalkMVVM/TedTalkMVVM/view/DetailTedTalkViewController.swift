//
//  DetailTedTalkViewController.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import UIKit
import WebKit

class DetailTedTalkViewController: UIViewController{
    
    @IBOutlet weak var titleDetailLabel:UILabel!
    @IBOutlet weak var ofViewDetailLabel:UILabel!
    @IBOutlet weak var nameDetailLabel:UILabel!
    @IBOutlet weak var descriptionDetailLabel: UILabel!
    @IBOutlet weak var tagDetailLabel: UILabel!
    @IBOutlet weak var webTedTalk: WKWebView!
    
    var tedTalk: TedTalkDisplay? = nil
    
    func setTedTalk(talk: TedTalkDisplay){
        self.tedTalk = talk
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let displayTedTalk = tedTalk{
            
            titleDetailLabel.text = displayTedTalk.title
            webTedTalk.load(URLRequest(url: URL(string: displayTedTalk.url)!))
            tagDetailLabel.text = "Tags: \(displayTedTalk.tags.joined(separator: ", "))"
            let viewString = displayTedTalk.views as NSNumber
            ofViewDetailLabel.text = "#of views: \(viewString.stringValue)"
            nameDetailLabel.text = displayTedTalk.name
            descriptionDetailLabel.text = displayTedTalk.description
        }
    }
}

