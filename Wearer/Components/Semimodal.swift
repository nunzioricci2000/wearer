//
//  Semimodal.swift
//  Wearer
//
//  Created by Nunzio Ricci on 17/01/23.
//

import SwiftUI

struct Semimodal<Modal: View>: ViewModifier {
    var modal: () -> Modal
    @State var yGestureOffset: CGFloat = 0
    @State var gestureStatus: Bool = true
    @State var minHeight: CGFloat = 0
    @State var maxHeight: CGFloat = 0
    var actualOffset: CGFloat {
        (gestureStatus ? maxHeight : minHeight) + yGestureOffset
    }
    var actualHeight: CGFloat {
        guard actualOffset > 0 else {
            return 0
        }
        if actualOffset > maxHeight {
            return maxHeight + (actualOffset - maxHeight) / 2
        }
        return actualOffset
    }
    var selectedGestureStatus: Bool {
        return actualHeight > (maxHeight + minHeight) / 2
    }
    init(minHeight: CGFloat, maxHeight: CGFloat, @ViewBuilder modal: @escaping () -> Modal) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.modal = modal
    }
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            VStack {
                Color.clear
                    .frame(width: 0, height: actualHeight)
                modal()
            }
        }.gesture( DragGesture()
            .onChanged { gesture in
                withAnimation(.interactiveSpring()) {
                    yGestureOffset = gesture.translation.height
                }
            }.onEnded { _ in
                withAnimation(.interactiveSpring()) {
                    gestureStatus = selectedGestureStatus
                    yGestureOffset = 0
                }
            }
        )
    }
}

extension View {
    func semisheet<Sheet: View>(minHeight: CGFloat,
                                maxHeight: CGFloat,
                                @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        modifier(Semimodal(minHeight: minHeight, maxHeight: maxHeight, modal: sheet))
    }
}

struct Semimodal_Previews: PreviewProvider {
    static var previews: some View {
        Color.white.semisheet(minHeight: 100, maxHeight: 500) {
            Color.red.ignoresSafeArea()
        }
    }
}
