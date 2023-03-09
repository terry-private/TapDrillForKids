//
//  TimeSecondsView.swift
//  
//
//  Created by 若江照仁 on 2023/02/21.
//

import SwiftUI

public struct TimeSecondsView: View {
    private let time: Double
    private let secondsSize: CGFloat
    private let decimalSize: CGFloat
    private let secondsFont: UIFont
    private let decimalFont: UIFont
    public init(_ time: Double = 0, secondsSize: CGFloat = 18, decimalSize: CGFloat = 11) {
        self.time = time
        self.secondsSize = secondsSize
        self.decimalSize = decimalSize
        secondsFont = UIFont.systemFont(ofSize: secondsSize, weight: .bold)
        decimalFont = UIFont.systemFont(ofSize: decimalSize)
    }
    public var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            Spacer()
                .overlay(alignment: .bottomTrailing) {
                    Text("\(Int(time))")
                        .font(.init(secondsFont))
                        .monospacedDigit()
                        .offset(y: -secondsFont.descender)
                        .fixedSize()
                }
            Spacer()
                .overlay(alignment: .bottomLeading) {
                    Text(".\(String(format: "%02d", Int(time * 100) - Int(time) * 100))")
                        .font(.init(decimalFont))
                        .monospacedDigit()
                        .offset(y: -decimalFont.descender)
                        .fixedSize()
                }
        }
        .offset(x: (secondsSize*2 - decimalSize*3)/3, y: max(secondsFont.capHeight, decimalFont.capHeight)/2)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @State static var showGridLine: Bool = true
    static var previews: some View {
        VStack {
            HStack {
                circle(width: 40, color: .purple, time: 22.22, secondsSize: 11)
                circle(width: 40, color: .purple, time: 0, secondsSize: 11)
            }
            HStack {
                circle(width: 50, color: .indigo, time: 22.22, secondsSize: 18)
                circle(width: 50, color: .indigo, time: 0, secondsSize: 18)
            }
            HStack {
                circle(width: 60, color: .indigo, time: 22.22, secondsSize: 30)
                circle(width: 60, color: .indigo, time: 0, secondsSize: 30)
            }
            HStack {
                circle(width: 100, color: .mint, time: 22.22, secondsSize: 50, decimalSize: 20)
                circle(width: 100, color: .mint, time: 0, secondsSize: 50, decimalSize: 20)
            }
        }
    }
    static func circle(width: CGFloat, color: Color, time: Double, secondsSize: CGFloat, decimalSize: CGFloat = 11) -> some View {
        Circle()
            .frame(width: width)
            .foregroundColor(color.opacity(0.6))
            .background {
                Color.red.frame(height: 1).opacity(showGridLine ? 1 : 0)
                Color.red.frame(width: 1).opacity(showGridLine ? 1 : 0)
            }
            .overlay { TimeSecondsView(time, secondsSize: secondsSize, decimalSize: decimalSize) }
    }
}
