//
//  ViewModelDetail.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 13/12/2021.
//

import Foundation

class viewModelDetail: ViewModelProtocolDetail {
    
    internal var indexTedTalkDisplay: Int = 0
    internal var observerTedTalkDetailDisplay: ((ViewModelProtocolDetail) -> ())
    internal var observerNextTedTalk: ((ViewModelProtocolDetail) -> ())
    internal var observerPreviousTedTalk: ((ViewModelProtocolDetail) -> ())
    var tedTalkManager: DisplayManagerTedTalk
    internal var observerIntermediateTedTalk: ((ViewModelProtocolDetail) -> ())
    
    init(tedTalkManager: DisplayManagerTedTalk, observerTedTalk: @escaping (ViewModelProtocolDetail) -> (), observerNextTedTalkButton: @escaping (ViewModelProtocolDetail) -> (), observerPreviousTedTalkButton: @escaping (ViewModelProtocolDetail) -> (),observerTedTalkButtons: @escaping (ViewModelProtocolDetail) -> ()) {
        self.tedTalkManager = tedTalkManager
        self.observerTedTalkDetailDisplay = observerTedTalk
        self.observerNextTedTalk = observerNextTedTalkButton
        self.observerPreviousTedTalk = observerPreviousTedTalkButton
        self.observerIntermediateTedTalk = observerTedTalkButtons
    }
    
    func getPreviousTedTalkDetail() {
        
        if indexTedTalkDisplay > 0 {
            indexTedTalkDisplay-=1
        }
        observerTedTalkDetailDisplay(self)
    }
    
    func getNextTedTalkDetail() {
        
        if indexTedTalkDisplay < tedTalkManager.getTedTalkDisplayCount() - 1 {
            indexTedTalkDisplay+=1
        }
        observerTedTalkDetailDisplay(self)    }
    
    func getTedTalkDetailsDisplay() -> TedTalkDisplay {
        if indexTedTalkDisplay == tedTalkManager.getTedTalkDisplayCount(){
            observerNextTedTalk(self)
        }
        if indexTedTalkDisplay == 0{
            observerPreviousTedTalk(self)
        }
        else {
            observerIntermediateTedTalk(self)
        }
        return tedTalkManager.getTedTalkDisplayDetail(tedTalkDisplayDetailIndex: indexTedTalkDisplay)
    }
}

