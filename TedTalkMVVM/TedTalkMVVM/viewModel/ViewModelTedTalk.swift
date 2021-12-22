//
//  ViewModelTedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//
import Foundation

class ViewModelTedTalk: ViewModelTedTalkProtocol{
  
    var displayManager: DisplayManagerTedTalk
    internal var pickerRows: [String] = ["Event", "Main Speaker", "Title", "Name", "Description", "Any"]
    var tedTalks: [TedTalkDisplay]? = []
    var tedTalksDisplay: [TedTalkDisplay] = [] {
        didSet{
            reloadData(tedTalksDisplay)
        }
    }
    
    internal var getPickerRows: (([String]) -> ())
    internal var reloadData: (([TedTalkDisplay]) -> ())
    
    init(displayManager: DisplayManagerTedTalk,observerData: @escaping ([TedTalkDisplay]) -> (), observerPicker: @escaping ([String]) -> () ) {
        self.displayManager = displayManager
        reloadData = observerData
        getPickerRows = observerPicker
        getPickerRows(pickerRows)
        getTalks()
        
    }
    
    func getTalks() {
        displayManager.getTalks(){
            result in
            switch result {
            case .success(let talks):
                self.tedTalks = talks
                self.tedTalksDisplay = talks
            case .failure(_):
                self.tedTalks = []
                print("there was an error")
            }
        }
    }

    func filterTalk(filter: String, text: String) {
        tedTalksDisplay = displayManager.filterTalk(filter: filter, text: text)
    }
}

