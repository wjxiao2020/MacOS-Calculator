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

    let buttons: [[CalculatorButton]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text(display)
                .font(.system(size: 60))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .background(Color.black.opacity(0.75))
                .foregroundColor(.white)
                .lineLimit(1)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button.title)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                .background(button.backgroundColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color.black)
        .frame(width: 320, height: 460) // Setting a predefined size for the macOS app window
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        return button == .zero ? 140 : 60 // Double width for "0" button, normal width for others
    }
    
    private func buttonHeight() -> CGFloat {
        return 60
    }
    
    func buttonTapped(_ button: CalculatorButton) {
        switch button {
        case .clear:
            display = "0"
            previousOperand = nil
            currentOperation = nil
        case .equals:
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
        case .add, .subtract, .multiply, .divide:
            currentOperation = button.title
            previousOperand = Double(display)
            display = "0"
        case .decimal:
            if !display.contains(".") {
                display += "."
            }
        case .plusMinus:
            if let number = Double(display) {
                display = "\(number * -1)"
            }
        case .percent:
            if let number = Double(display) {
                display = "\(number * 0.01)"
            }
        default:
            if display == "0" || currentOperation != nil && previousOperand == nil {
                display = button.title
            } else {
                display += button.title
            }
        }
    }
}

enum CalculatorButton: String, CaseIterable {
    // Add button identifiers and display labels
    case clear = "AC"
    case plusMinus = "+/-"
    case percent = "%"
    case divide = "÷"
    case multiply = "×"
    case subtract = "-"
    case add = "+"
    case equals = "="
    case decimal = "."
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    var title: String {
        return self.rawValue
    }
    
    var backgroundColor: Color {
        switch self {
        case .clear, .plusMinus, .percent:
            return Color(.lightGray)
        case .divide, .multiply, .subtract, .add, .equals:
            return Color.orange
        default:
            return Color(.darkGray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 350, height: 500)
    }
}
