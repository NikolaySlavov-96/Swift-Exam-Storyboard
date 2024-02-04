//
//  ViewController.swift
//  MyNotes
//
//  Created by Nikolay Slavov on 4.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var saveNoteTapButton: UIButton!
    @IBOutlet weak var showNoteTapButton: UIButton!
    
    private var storageManager: StorageManager = StorageManager()
    private var motionManager: MotionManager = MotionManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userInputTextView.delegate = self
        motionManager.delegate = self
        
        addStyle()
        
        
        saveNoteTapButton.setTitle("Save Note", for: .normal)
        showNoteTapButton.setTitle("Show saved note", for: .normal)
        
        saveNoteTapButton.isEnabled = false;
        showNoteTapButton.isHidden = storageManager.isThereIsSaveNote
        
        setTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.startAccelemeterUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopAccelemeterUpdate()
    }

    @IBAction func tappedArround(_ sender: UITapGestureRecognizer){
        userInputTextView.resignFirstResponder()
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedArround))
        view.addGestureRecognizer(tapGesture)
    }
    

    @IBAction func saveNotesBtn () {
        if let textNote = userInputTextView.text, !textNote.isEmpty {
            storageManager.addNote(note: textNote)
//            userInputTextView.text = nil
            showNoteTapButton.isHidden = false;
            saveNoteTapButton.isEnabled = false;
        } else { return }
    }
    
    @IBAction func showNoteBtn(){
        storageManager.getNote{
            self.userInputTextView.text = self.storageManager.userNote
        }
    }
    
    private func addStyle() {
        //        Styles
                view.backgroundColor = .systemYellow
        //        Style for Text View
                userInputTextView.backgroundColor = UIColor(white: 0, alpha: 0.2)
                userInputTextView.textColor = .lightGray
                userInputTextView.layer.cornerRadius = 10.0
                userInputTextView.layer.borderColor = UIColor.black.cgColor
                userInputTextView.textColor = .black
                userInputTextView.clipsToBounds = true
                
                
                
        //        Style of Buttons
                saveNoteTapButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
                saveNoteTapButton.setTitleColor(.black, for: .normal)
                saveNoteTapButton.setTitleColor(.gray, for: .disabled)
                saveNoteTapButton.layer.cornerRadius = 6.0
                showNoteTapButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
                showNoteTapButton.setTitleColor(.black, for: .normal)
                showNoteTapButton.setTitleColor(.gray, for: .disabled)
                showNoteTapButton.layer.cornerRadius = 6.0
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ userInputTextView: UITextView) {
    
        if userInputTextView.text != "" {
            saveNoteTapButton.isEnabled = true
        } else {
            saveNoteTapButton.isEnabled = false
        }
    }
}

extension ViewController: MotionManagerDelegate {
    func didDetectMotion() {
        userInputTextView.text = nil
    }
}
