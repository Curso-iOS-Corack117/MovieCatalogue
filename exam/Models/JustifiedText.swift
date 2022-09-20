//
//  JustifiedText.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 20/09/22.
//

import SwiftUI
import UIKit

struct JustifiedText: UIViewRepresentable {
    private let text: String
    private let font: UIFont
    
    init(_ text: String, font: UIFont = .systemFont(ofSize: 18)) {
        self.text = text
        self.font = font
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.textColor = UIColor(Color("movieForegroundColor"))
        textView.backgroundColor = .clear
        textView.textAlignment = .justified
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
