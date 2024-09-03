//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andruw Sorensen on 1/27/24.
//

import SwiftUI

struct ContentView: View {
    // Variables
    @State private var winningMoves = ["🪨", "📜", "✂️"]
    @State private var moves = ["✂️", "🪨", "📜"]
    @State private var compChoice = Int.random(in: 0...2)
    @State private var playerChoice: Int = 0
    @State private var currentRound = 1
    @State private var totalRounds = 10
    @State private var shouldWin = Bool.random()
    @State private var currentScore = 0
    @State private var showingScore = false
    @State private var roundComplete = false
    @State private var scoreTitle = ""
    @State private var winState = ""
    
    var body: some View {
        // Color and title
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Text("Click rock paper or scissors to make your choice")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // A title to tell the user to win or lose
                VStack {
                    if shouldWin {
                        Text("Try to win this round")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    } else {
                        Text("Try to lose this round")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    // HStack to display the choices as buttons
                    HStack {
                        ForEach(0..<3) { number in
                            Spacer()
                            Button {
                                emojiTapped(number)
                                playerChoice = number
                            } label: {
                                Text(winningMoves[number])
                                    .font(.system(size: 75))
                            }
                            Spacer()
                        }
                    }
                    .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Round \(currentRound) of \(totalRounds)")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert("You \(winState)!", isPresented: $showingScore) {
            Button("Continue", action: emojiSelected)
        } message: {
            let win = shouldWin ? "win" : "lose"
            Text("You selected \(winningMoves[playerChoice]) and the computer chose \(moves[compChoice]) you \(winState). You were trying to \(win)")
        }
        .alert("Round Complete", isPresented: $roundComplete) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score was \(currentScore)")
        }
    }
    
    func emojiTapped(_ number: Int) {
        if number == compChoice && shouldWin {
            currentScore += 1
            winState = "won"
        } else if moves[compChoice] == winningMoves[number] {
            winState = "tied"
        } else if number == compChoice {
            currentScore -= 1
            winState = "won"
        } else if shouldWin {
            currentScore -= 1
            winState = "lost"
        } else {
            currentScore += 1
            winState = "lost"
        }
        
        showingScore = true
        if currentRound >= totalRounds {
            roundComplete = true
        } else {
            currentRound += 1
        }
    }
    
    func emojiSelected() {
        shouldWin.toggle()
        compChoice = Int.random(in: 0...2)
    }
    
    func reset() {
        currentRound = 1
        currentScore = 0
    }
}

#Preview {
    ContentView()
}
