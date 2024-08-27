//
//  FlashCardView.swift
//  FlashCardForKids
//
//  Created by Prabesh Shrestha on 27/08/2024.
//

import SwiftUI

struct FlashCardView: View {
    @StateObject private var viewModel = FlashCardViewModel()
    var body: some View {
        VStack{
            Text(viewModel.isShowingAnswer ? viewModel.currentAnswer : viewModel.currentQuestion.nextLineAfterQuestionMark())
                .font(.largeTitle)
                .frame(width: 350, height: 350)
                .background(Color.blue.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    viewModel.flipCard()
                    viewModel.readAnswer()
                }
                .padding()
            HStack{
                Button {
                    viewModel.showPreviousCard()
                } label: {
                    Text("Previous Question")
                        .font(.headline)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
                Button {
                    viewModel.showNextCard()
                } label: {
                    Text("Next Question")
                        .font(.headline)
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
                
               

            }
            
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    viewModel.showSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    viewModel.deleteCard(question: viewModel.currentQuestion)
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }

            }
        }
        .sheet(isPresented: $viewModel.showSheet, content: {
            AddQuestionView()
        })
        .onChange(of: viewModel.showSheet) {
            viewModel.loadCards()
        }
        .navigationTitle("Flash Card")
    }
}

#Preview {
    NavigationStack {
        FlashCardView()
    }
}
