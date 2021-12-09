//
//  PageControl.swift
//  SwiftUITutorial
//
//  Created by Jinyung Yoon on 2021/12/09.
//

import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    @Binding var currentPage: Int
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(control: self)
//    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
//        control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
//    class Coordinator: NSObject {
//        var control: PageControl
//
//        init(control: PageControl) {
//            self.control = control
//        }
//
//        @objc
//        func updateCurrentPage(sender: UIPageControl) {
//            control.currentPage = sender.currentPage
//        }
//    }
}
