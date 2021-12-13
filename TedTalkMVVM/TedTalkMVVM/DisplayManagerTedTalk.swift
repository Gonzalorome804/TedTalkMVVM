//
//  DisplayManagerTedTalk.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 10/12/2021.
//

import Foundation
enum Errors: Error, Equatable {
    case error
}
class DisplayManagerTedTalk {
    
    static let shareTedTalkManager: DisplayManagerTedTalk = DisplayManagerTedTalk()
    var tedTalks: [TedTalk] = []
    
    func getTalks(filename: String, onCompletion: @escaping (Result<[TedTalkDisplay], Errors>) -> Void) {
        TedTalkManager().parseFromJson(fileName: filename) {
            result in
            switch result {
            case .success(let talks):
                self.tedTalks = talks
                onCompletion(.success(self.tedTalks.map({ (tedtalk) -> TedTalkDisplay
                    in tedtalk.ParseDisplay()
                })))
                
            case .failure(_):
                self.tedTalks = []
                print("there was an error")
            }
        }
    }
    
    func filterTalk(filter: String, text: String) -> [TedTalkDisplay] {
        var filteredTalk: [TedTalkDisplay] = []
        tedTalks.forEach({
            (talk) in
            if talk.isFiltered(filter, input: text){
                filteredTalk.append(talk.ParseDisplay())
            }
        })
        return filteredTalk
    }
}