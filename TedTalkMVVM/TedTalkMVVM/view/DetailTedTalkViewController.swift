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
                                    }, observerTedTalkButtons: { [unowned self] previousButtonIsActive, nextButtonIsActive  in
                                        self.buttonsEnables(valueButtonPrevious: previousButtonIsActive, valueButtonNext: nextButtonIsActive)})
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
        descriptionDetailLabel.text = talk.descrip
    }
    
    func buttonsEnables(valueButtonPrevious: Bool, valueButtonNext: Bool){
        nextTedTalkButton.isEnabled = valueButtonNext
        previousTedTalkButton.isEnabled = valueButtonPrevious
    }
}


