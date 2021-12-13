//
//  ViewModelTedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//
import Foundation

class ViewModelTedTalk: ViewModelTedTalkProtocol{
    
    var displayManager = DisplayManagerTedTalk()
    internal var pickerRows: [String] = ["Event", "Main Speaker", "Title", "Name", "Description", "Any"]
    var tedTalks: [TedTalkDisplay]? = []
    var tedTalksDisplay: [TedTalkDisplay] = [] {
        didSet{
            reloadData(tedTalksDisplay)
        }
    }
    
    internal var reloadData: (([TedTalkDisplay]) -> ())
    
    init(displayManager: DisplayManagerTedTalk,observerData: @escaping ([TedTalkDisplay]) -> () ) {
        self.displayManager = displayManager
        reloadData = observerData
        getTalks()
    }
    
    func getTalks(file: String = "tedTalks") {
        displayManager.getTalks(filename: file){
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
  
    
    func getPickerRowsCount() -> Int {
        return self.pickerRows.count
    }
    
    func getPickerRow(index: Int) -> String {
        return self.pickerRows[index]
    }
    
    func getFilteredTalkCount() -> Int {
        return self.tedTalksDisplay.count
    }
    
    func getFilteredTalk(for tedTalk: Int) -> TedTalkDisplay {
        return self.tedTalksDisplay[tedTalk]
    }
    
    func filterTalk(filter: String, text: String) {
        tedTalksDisplay = displayManager.filterTalk(filter: filter, text: text)
    }
}

