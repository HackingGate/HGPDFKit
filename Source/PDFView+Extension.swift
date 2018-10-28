//
//  PDFView+Extension.swift
//  HGPDFKit
//
//  Created by ERU on 2018/10/28.
//  Copyright © 2018 HackingGate. All rights reserved.
//

import PDFKit

// scaleFactor
struct HGPDFScaleFactor {
    // store factor for single mode
    var portrait: CGFloat
    var landscape: CGFloat
    // devide by 2 for two up mode
}

extension PDFView {
    var scrollView: UIScrollView? {
        for view in self.subviews {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }
    
    struct Holder {
        // different form pdfView.scaleFactorForSizeToFit, the scaleFactorForSizeToFit use superArea not safeArea
        static var hgScaleFactorForSizeToFit: HGPDFScaleFactor?
        static var hgScaleFactorVertical: HGPDFScaleFactor = HGPDFScaleFactor(portrait: 0.25, landscape: 0.25)
        static var hgScaleFactorHorizontal: HGPDFScaleFactor = HGPDFScaleFactor(portrait: 0.25, landscape: 0.25)
        static var isZoomedIn: Bool = false
    }
}
