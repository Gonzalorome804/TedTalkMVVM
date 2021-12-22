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
    
    static let sharedTedTalkManager: DisplayManagerTedTalk = DisplayManagerTedTalk()
    
    private init(){}
    
    func getTalks(onCompletion: @escaping (Result<[TedTalkDisplay], Errors>) -> Void) {
        TedTalkManager().retrieveFromServer() {
            result in
            switch result {
            case .success(let talks):
                TedTalkBaseDataManager.sharedInstance.createTedTalks(talks)
                onCompletion(.success(talks.map({ (tedtalk) -> TedTalkDisplay
                    in tedtalk.ParseDisplay()
                })))
                
            case .failure(_):
                print("there was an error")
            }
        }
    }
    
    func getTedTalkDisplayDetail(tedTalkDisplayDetailIndex: Int) -> TedTalkDisplay {
        var tedTalkDisplay: TedTalkDisplay = TedTalkDisplay(main_speaker: "", name: "", descrip: "", tags: [""], title: "", url: "", views: 0)
        TedTalkBaseDataManager.sharedInstance.readTedTalks(){ talks in
            tedTalkDisplay = talks[tedTalkDisplayDetailIndex].ParseDisplay()
        }
        return tedTalkDisplay
    }
    
    func getTedTalkDisplayCount() -> Int {
        var talkCount: Int = 0
        TedTalkBaseDataManager.sharedInstance.readTedTalks(){ talks in
            talkCount = talks.count
        }
        return talkCount
    }
    
    func filterTalk(filter: String, text: String) -> [TedTalkDisplay] {
        var filteredTalk: [TedTalkDisplay] = []
        TedTalkBaseDataManager.sharedInstance.readTedTalks(){ talks in talks.forEach({
            (talk) in
            if talk.isFiltered(filter, input: text){
                filteredTalk.append(talk.ParseDisplay())
            }
        })
        }
        return filteredTalk
    }
}
