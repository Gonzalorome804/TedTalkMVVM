//
//  TedTalkBaseDataManager.swift
//  TedTalkMVVM
//
//  Created by Gonzalo Romero on 22/12/2021.
//

import Foundation

import Foundation
import RealmSwift

class TedTalkBaseDataManager {
    
    public static let sharedInstance = TedTalkBaseDataManager()
    private let realm: Realm?
    private init(){
        realm = try! Realm()
    }
    
    func createTedTalks(_ tedTalk: [TedTalk]) {
        try! realm?.write {
            realm?.add(tedTalk)
        }
    }
    
    func readTedTalks(_ completion: @escaping ([TedTalk]) -> ()) {
        if let result = realm?.objects(TedTalk.self) {
            completion(Array(result))
        }
    }
}
