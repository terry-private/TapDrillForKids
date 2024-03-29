//
//  DrillResultView.swift
//  
//
//  Created by 若江照仁 on 2023/02/28.
//

import SwiftUI
import Core
import Components
import ConfettiSwiftUI

public struct DrillResultView: View {
    @State var count: Int = 0
    private let result: DrillResult
    private let star1: String
    private let star2: String
    private let star3: String
    private let dismiss: () -> Void
    
    public init(result: DrillResult, star1: String, star2: String, star3: String, dismiss: @escaping () -> Void) {
        self.result = result
        self.star1 = star1
        self.star2 = star2
        self.star3 = star3
        self.dismiss = dismiss
    }
    public var body: some View {
        VStack {
            Spacer()
            switch result {
            case .success(let grades):
                Grid(verticalSpacing: 23) {
                    Text(L10n.Result.congratulations)
                        .font(.title)
                        .italic()
                        .foregroundLinearGradient(colors: result.hasFirst ? [.purple, .pink, .blue, .mint] : [], startPoint: .leading, endPoint: .trailing)
                        .padding(.bottom, 5)
                    
                    GridRow {
                        Text(star1)
                        starView(unlocked: grades.star1.unlocked, isFirst: grades.star1.isFirst)
                    }
                    
                    GridRow {
                        Text(star2)
                        starView(unlocked: grades.star2.unlocked, isFirst: grades.star2.isFirst)
                    }
                    
                    GridRow {
                        Text(star3)
                        starView(unlocked: grades.star3.unlocked, isFirst: grades.star3.isFirst)
                    }
                    
                    Divider()
                    
                    GridRow {
                        Text(L10n.Result.time)
                        
                        Text(String(format: "%.2f", grades.time))
                            .font(.headline)
                            .italic()
                            .addTextAnimationBadge(grades.isNewTimeRecord)
                    }
                }
                .fixedSize()
            case .gameOver:
                Text(L10n.Result.gameOver)
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding(40)
            case .timeOver:
                Text(L10n.Result.timeOver)
                    .font(.largeTitle)
                    .foregroundColor(.red)
                    .padding(40)
            }
            Spacer()
            
            BottomButton {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 26))
                Spacer()
                Text(L10n.Result.close)
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .padding(.vertical, 30)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            if result.hasFirst {
                count += 1
            }
        }
        .overlay {
            ConfettiCannon(counter: $count)
                .padding(.bottom, 50)
        }
        .onAppear {
            if result.hasFirst {
                Task {
                    for _ in (0...5) {
                        try await Task.sleep(seconds: 0.1)
                        count += 1
                    }
                }
            }
        }
    }
    func starView(unlocked: Bool, isFirst: Bool) -> some View {
        Image(systemName: "star.fill")
            .font(.system(size: 30))
            .foregroundColor(unlocked ? .yellow : .gray)
            .addTextAnimationBadge(isFirst)
    }
}

#if DEBUG
struct DrillResultView_Previews: PreviewProvider {
    static var previews: some View {
        DrillResultView(
            result: .success(
                .init(
                    star1: .unlocked(isFirst: true),
                    star2: .locked,
                    star3: .locked,
                    time: 43,
                    isNewTimeRecord: true)
            ),
            star1: L10n.Result.Preview.star1Description,
            star2: L10n.Result.Preview.star2Description,
            star3: L10n.Result.Preview.star3Description) {
                
            }
    }
}
#endif
