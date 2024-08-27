//
//  AddQuestionView.swift
//  FlashCardForKids
//
//  Created by Prabesh Shrestha on 27/08/2024.
//

import SwiftUI

struct AddQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddQuestionViewModel()
    var body: some View {
        VStack(alignment: .leading){
            if let questionError = viewModel.questionError{
                Text(questionError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            Text("Enter question")
                .font(.headline)
                .padding(.horizontal)
            
            TextField("Enter question", text: $viewModel.question)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if let answerError = viewModel.answerError{
                Text(answerError)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            Text("Enter answer")
                .font(.headline)
                .padding(.horizontal)
            
            TextField("Enter answer", text: $viewModel.answer)
                .padding()
                .background(Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            

        }
        .padding()
        VStack(alignment: .center) {
            Button {
                viewModel.addQuestion()
                dismiss()
            } label: {
                Text("Add")
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
        .navigationTitle("Add Card")
    }
}

#Preview {
    NavigationStack {
        AddQuestionView()
    }
}
