//
//  MultipleCheckbox.swift
//  CareConnect NDIS
//
//  Created by Md Roman Islam on 15/5/2025.
//

import SwiftUI

struct MultipleCheckbox: View {
    var title: String
    var isSelected: Bool
    var toggle: () -> Void

    var body: some View {
        Button(action: toggle) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .accentColor : .gray)
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.vertical, 6)
        }
    }
}
