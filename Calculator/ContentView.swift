//
//  ContentView.swift
//  Calculator
//
//  Created by Weijia on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var currentOperation: String?
    @State private var previousOperand: Double?


        let buttons = [
            ["AC", "+/-", "%", "/"],
            ["7", "8", "9", "*"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["0", ".", "="],
        ]

        var body: some View {
            VStack(spacing: 10) {
                Text(display)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()

                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.buttonTapped(button)
                            }) {
                                Text(button)
                                    .font(.largeTitle)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding()
        }

    func buttonTapped(_ button: String) {
           if button == "AC" {
               display = "0"
               previousOperand = nil
               currentOperation = nil
           } else if button == "=" {
               guard let op = currentOperation, let previous = previousOperand, let current = Double(display) else {
                   return
               }

               switch op {
               case "+":
                   display = "\(previous + current)"
               case "-":
                   display = "\(previous - current)"
               case "*":
                   display = "\(previous * current)"
               case "/":
                   display = "\(previous / current)"
               default:
                   break
               }

               currentOperation = nil
               previousOperand = nil
           } else if ["+", "-", "*", "/"].contains(button) {
               currentOperation = button
               previousOperand = Double(display)
               display = "0"
           } else {
               if display == "0" || currentOperation != nil && previousOperand == nil {
                   display = button
               } else {
                   display += button
               }
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 300, height: 400)
    }
}
