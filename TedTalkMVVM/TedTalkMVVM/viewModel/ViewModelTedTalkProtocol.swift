//
//  ViewModelTedTalkProtocol.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 09/12/2021.
//

import Foundation

protocol ViewModelTedTalkProtocol {
    
    var tedTalks: [TedTalkDisplay]? {get set}
    var tedTalksDisplay: [TedTalkDisplay] {get set}
    var reloadData: (([TedTalkDisplay]) -> ()) { get set }
    
    func getFilteredTalkCount() -> Int
    func getFilteredTalk(for tedTalk: Int) -> TedTalkDisplay
    func filterTalk(filter: String, text: String)
    func getPickerRowsCount() -> Int
    func getPickerRow(index: Int) -> String
}

