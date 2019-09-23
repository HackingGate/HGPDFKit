//
//  PDFView+RTL.swift
//  HGPDFKit
//
//  Created by ERU on 2018/10/28.
//  Copyright © 2018 HackingGate. All rights reserved.
//

import PDFKit

extension PDFView {
    // if allowsDocumentAssembly is false, then the value should always be false
    public var isViewTransformedForRTL: Bool {
        get {
            if self.document?.page(at: 0)?.rotation == 180 {
                if self.scrollView?.transform == CGAffineTransform(rotationAngle: .pi) {
                    return true
                }
                print("HGPDFKit: First page is rotated but ScrollView of PDFView is not transformed. If you are trying to use RTL. Call PDFView.transformScrollViewIfNeededForRTL before calling PDFView.isViewTransformedForRTL or manage RTL transform on your own.")
                return true
            } else {
                return false
            }
        }
    }
    
    /// Call this method when document was transformed previously and the ScrollView transform was reset.
    /// Call it before calling `PDFView.isViewTransformedForRTL`.
    public func transformScrollViewIfNeededForRTL() {
        if self.scrollView?.transform != CGAffineTransform(rotationAngle: .pi), self.document?.page(at: 0)?.rotation == 180 {
            self.scrollView?.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }
    
    public func transformViewForRTL(_ transformForRTL: Bool, _ pdfThumbnailView: PDFThumbnailView?) {
        if self.document?.allowsDocumentAssembly == false {
            return
        }
        
        if transformForRTL != isViewTransformedForRTL, let scrollView = self.scrollView, let document = self.document {
            
            scrollView.transform = CGAffineTransform(rotationAngle: transformForRTL ? .pi : 0)
            
            if let pdfThumbnailView = pdfThumbnailView {
                pdfThumbnailView.transform = CGAffineTransform(rotationAngle: transformForRTL ? .pi : 0)
            }
            
            let pageCount = document.pageCount
            
            for i in 0..<pageCount {
                document.page(at: i)?.rotation = transformForRTL ? 180 : 0
            }
            
            // if transform view for RTL, the thumbnail does not update
            self.document = nil
            self.document = document
            
        }
    }
}
