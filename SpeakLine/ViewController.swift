//
//  ViewController.swift
//  SpeakLine
//
//  Created by Tara Singh M C on 08/07/18.
//  Copyright © 2018 Tara Singh M C. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    // MARK: - Speech Synthesizer
    let speechSynth = NSSpeechSynthesizer()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateButtons()
        
        
        //Setting the delegate property
       speechSynth.delegate = self

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    // MARK: - Action methods
    
    @IBAction func speakIt(_ sender: Any) {
        
        // Get typed-in text as a string
        let string = textField.stringValue
        if string.isEmpty {
            print("string from \(textField) is empty")
        } else {
            speechSynth.startSpeaking(string)
            isStarted = true
        }
        
    }
    
    @IBAction func stopIt(_ sender: Any) {
        speechSynth.stopSpeaking()
    }
    
    // MARK: - Helper methods
    func updateButtons() {
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            stopButton.isEnabled = false
            speakButton.isEnabled = true
        }
    }

}

// MARK: - NSSpeechSynthesizerDelegate
extension ViewController: NSSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        updateButtons()
        print("finishedSpeaking=\(finishedSpeaking)")
    }
    
}

// MARK: - NSWindowDelegate
extension ViewController: NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        return !isStarted
    }
}

