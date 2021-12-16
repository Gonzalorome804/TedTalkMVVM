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
    @IBOutlet weak var previousTedTalkButton: UIButton!
    @IBOutlet weak var nextTedTalkButton: UIButton!
    
    
    @IBAction func previousDetailTedTalk(){
        viewModel.getPreviousTedTalkDetail()
    }
    
    @IBAction func nextDetailTedTalk(){
        viewModel.getNextTedTalkDetail()
    }
    
    var viewModel: ViewModelProtocolDetail!
    var index: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel = viewModelDetail(tedTalkManager: DisplayManagerTedTalk.sharedTedTalkManager,
                                    observerTedTalk: { [unowned self] viewModel in
                                        self.showTedTalkDetail(talk: viewModel.getTedTalkDetailsDisplay())
                                    },observerNextTedTalkButton: { [unowned self] viewModel in
                                        self.buttonNextDisable()}, observerPreviousTedTalkButton: { [unowned self] viewModel in
                                            self.buttonPreviousDisable()}, observerTedTalkButtons: { [unowned self] viewModel in
                                                self.buttonsEnables()})
        viewModel.indexTedTalkDisplay = index
        showTedTalkDetail(talk: viewModel.getTedTalkDetailsDisplay())
    }
    
    func showTedTalkDetail (talk: TedTalkDisplay)
    {
        titleDetailLabel.text = talk.title
        webTedTalk.load(URLRequest(url: URL(string: talk.url)!))
        tagDetailLabel.text = "Tags: \(talk.tags.joined(separator: ", "))"
        let viewString = talk.views as NSNumber
        ofViewDetailLabel.text = "#of views: \(viewString.stringValue)"
        nameDetailLabel.text = talk.name
        descriptionDetailLabel.text = talk.description
    }
    
    func buttonNextDisable(){
        nextTedTalkButton.isEnabled = false
    }
    func buttonPreviousDisable(){
        previousTedTalkButton.isEnabled = false
    }
    func buttonsEnables(){
        nextTedTalkButton.isEnabled = true
        previousTedTalkButton.isEnabled = true
    }
}


