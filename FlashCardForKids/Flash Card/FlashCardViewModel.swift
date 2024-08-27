//
//  FlashCardViewModel.swift
//  FlashCardForKids
//
//  Created by Prabesh Shrestha on 27/08/2024.
//

import Foundation
import AVFoundation
import SwiftUI
class FlashCardViewModel: ObservableObject{
    @Published var flashCards = [String: String](){
        didSet {
            saveFlashCards()
        }
    }
    
    init(){
        loadFlashCards()
    }
    @Published var showSheet: Bool = false
//    @Published var flashCards : [String: String] = [
//        "What is this? 7" : "7"
//    ]
    @Published var currentCardIndex: Int = 0
    @Published var isShowingAnswer: Bool = false
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    private var key: [String] {
        Array(flashCards.keys)
    }
    
    var currentQuestion: String {
        guard !key.isEmpty else { return "No Question Available"}
        return key[currentCardIndex]
    }
    
    var currentAnswer: String {
        guard !key.isEmpty else { return "No Answer Available"}
        return flashCards[currentQuestion, default: "Unknown"]
    }
    
    
    func addCard(question: String, answer: String){
        flashCards[question] = answer
        currentCardIndex = min(currentCardIndex, flashCards.count - 1)
    }
    
    func deleteCard(question: String){
        flashCards.removeValue(forKey: question)
        if currentCardIndex >= flashCards.count{
            currentCardIndex = max(0, flashCards.count - 1)
        }

        saveFlashCards()
        loadFlashCards()
    }
    
    func showNextCard(){
        if currentCardIndex < flashCards.count - 1{
            currentCardIndex += 1
            isShowingAnswer = false
        }
    }
    
    func showPreviousCard(){
        if currentCardIndex != 0{
            currentCardIndex -= 1
            isShowingAnswer = false
        }
    }
    
    func flipCard(){
        isShowingAnswer.toggle()
    }
    
    func readAnswer(){
        if isShowingAnswer == true{
            let utterance = AVSpeechUtterance(string: currentAnswer)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            speechSynthesizer.speak(utterance)
        }
    }
    
    private func saveFlashCards(){
        UserDefaults.standard.setValue(flashCards, forKey: "flashCards")
    }
    
    private func loadFlashCards(){
        if let savedFlashCards = UserDefaults.standard.dictionary(forKey: "flashCards") as? [String: String]{
            flashCards = savedFlashCards
        }
    }
    
    func loadCards(){
        if let savedFlashCards = UserDefaults.standard.dictionary(forKey: "flashCards") as? [String: String]{
            flashCards = savedFlashCards
        }
    }
}
