//
//  BookViewController.swift
//  HGPDFKit
//
//  Created by ERU on 2018/10/28.
//  Copyright © 2018 HackingGate. All rights reserved.
//

import UIKit
import PDFKit

class BookViewController: UIViewController {
    
    @IBOutlet private weak var pdfView: PDFView!
    @IBOutlet private var doubleTapGesture: UITapGestureRecognizer!
    
    var pdfDocument: PDFDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(false, animated: true)
        pdfView.transformScrollViewIfNeededForRTL() // Example for implement the fix
        updateReadingDirectionItemTitle()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let documentAttributes = pdfDocument?.documentAttributes {
            if let title = documentAttributes["Title"] as? String {
                self.title = title
            }
        }
        
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayDirection = .horizontal
        pdfView.displayMode = .singlePageContinuous

        pdfView.addGestureRecognizer(doubleTapGesture)
        
        setPDFThumbnailView()
        
        // HGPDFKit
        pdfView.scrollView?.contentInsetAdjustmentBehavior = .scrollableAxes
        pdfView.getScaleFactorForSizeToFit()
        pdfView.setMinScaleFactorForSizeToFit()
        pdfView.setScaleFactorForUser()
    }
    
    private func setPDFThumbnailView() {
        if let margins = navigationController?.toolbar.safeAreaLayoutGuide {
            let pdfThumbnailView = PDFThumbnailView()
            pdfThumbnailView.tag = 1
            pdfThumbnailView.pdfView = pdfView
            pdfThumbnailView.layoutMode = .horizontal
            pdfThumbnailView.translatesAutoresizingMaskIntoConstraints = false
            navigationController?.toolbar.addSubview(pdfThumbnailView)
            pdfThumbnailView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            pdfThumbnailView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            pdfThumbnailView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            pdfThumbnailView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
    }
    
    // MARK: - Auto zoom
    
    @IBAction private func doubleTapAction(_ sender: UITapGestureRecognizer) {
        pdfView.autoZoomInOrOut(location: sender.location(in: pdfView), animated: true)
    }
    
    // MARK: - RTL
    
    @IBOutlet private weak var readingDirectionItem: UIBarButtonItem!
    
    private func updateReadingDirectionItemTitle() {
        readingDirectionItem.title = pdfView.isViewTransformedForRTL ? "RTL" : "LTR"
    }
    
    @IBAction private func changeReadingDirection() {
        let pdfThumbnailView = navigationController?.toolbar.viewWithTag(1) as? PDFThumbnailView

        pdfView.transformViewForRTL(!pdfView.isViewTransformedForRTL, pdfThumbnailView)
        updateReadingDirectionItemTitle()
    }
}
