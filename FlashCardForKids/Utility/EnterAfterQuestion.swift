//
//  EnterAfterQuestion.swift
//  FlashCardForKids
//
//  Created by Prabesh Shrestha on 27/08/2024.
//

import Foundation
extension String{
    func nextLineAfterQuestionMark() -> String{
        return self.replacingOccurrences(of: "?", with: "?\n")
    }
}
