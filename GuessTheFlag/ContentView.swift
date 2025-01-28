//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Владислав Дробитько on 27/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var showAlertEndGame = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 30) {
                    HStack(spacing: 10) {
                        Text("Tap the flag of:")
                            .font(.title2)
                            .foregroundStyle(.black)
                            .opacity(0.8)
                        Text(countries[correctAnswer])
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 5))
                                .shadow(radius: 3)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.white.opacity(0.07))
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Text("Your score is: \(userScore)")
                    .font(.title2)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("You are a winner!", isPresented: $showAlertEndGame) {
            Button("Start a new game", action: resetScore)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
        endGame()
    }
    func resetScore() {
        userScore = 0
    }
    
    func endGame() {
        if userScore == 8 {
            showAlertEndGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
