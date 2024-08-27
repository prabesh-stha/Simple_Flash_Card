//
//  AddQuestionViewModel.swift
//  FlashCardForKids
//
//  Created by Prabesh Shrestha on 27/08/2024.
//

import Foundation
class AddQuestionViewModel: ObservableObject{
    @Published var question: String = ""
    @Published var answer: String = ""
    
    var flashCardViewModel = FlashCardViewModel()
    
    @Published var questionError: String? = nil
    @Published var answerError: String? = nil
    
    func validate() -> Bool{
        var isValid: Bool = true
        if question == ""{
            questionError = "Please enter question!"
            isValid = false
        }else{
            questionError = nil
        }
        if answer == ""{
            answerError = "Please enter answer!"
            isValid = false
        }else{
            answerError = nil
        }
        return isValid
    }
    
    func addQuestion(){
        guard validate() else { return }
        
        flashCardViewModel.addCard(question: question, answer: answer)
    }
}
