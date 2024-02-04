//
//  storageManager.swift
//  MyNotes
//
//  Created by Nikolay Slavov on 4.02.24.
//

import Foundation

class StorageManager {
    
    private let userDef = UserDefaults.standard
    private let userKeyNote = "userNote"
    
    var userNote: String = ""
    
    var isThereIsSaveNote: Bool {
        (userDef.object(forKey: userKeyNote) as? String == nil) ? true : false
    }
    
    func addNote(note: String) {
        userNote = note;
        userDef.set(userNote, forKey: userKeyNote)
    }
    
    func getNote(completion: @escaping () -> Void) {
        userNote = userDef.object(forKey: userKeyNote) as? String ?? ""
        completion()
    }
    
    func removeNote() {
        userDef.removeObject(forKey: userKeyNote)
    }
    
    private func n (){
        
    }
}
