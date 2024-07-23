//
// CheckBoxView.swift
//
// Created by Speedyfriend67 on 23.07.24
//
 
import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square" : "square")
            Text(text)
        }
        .padding()
    }
}