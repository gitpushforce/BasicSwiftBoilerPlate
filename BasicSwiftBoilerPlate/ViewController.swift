//
//  ViewController.swift
//  BasicSwiftBoilerPlate
//
//  Created by masaki on 2021/10/28.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UIDocumentPickerDelegate {
    
    var editArea: UITextView = {
       var editArea = UITextView()
        editArea.translatesAutoresizingMaskIntoConstraints = false
        editArea.backgroundColor = .green
        return editArea
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(editArea)
        editArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        editArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        editArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        editArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        self.addToolBar(textField: editArea, toolbar: self.getMarkdownToolbar())
    }

    // Editor toolbar over the keyboard
    private func getMarkdownToolbar() -> UIToolbar {
        var items = [UIBarButtonItem]()

        let todoImage = UIImage(named: "toolbarTodo")?.resize(maxWidthHeight: 27)
        let todoButton = UIBarButtonItem(image: todoImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.todoPressed))
        items.append(todoButton)


        let tagImage = UIImage(named: "toolbarTag")?.resize(maxWidthHeight: 25)
        let tagButton = UIBarButtonItem(image: tagImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.tagPressed))
        items.append(tagButton)
        

        let boldImage = UIImage(named: "toolbarBold")?.resize(maxWidthHeight: 21)
        let boldButton = UIBarButtonItem(image: boldImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.boldPressed))
        items.append(boldButton)

        let italicImage = UIImage(named: "toolbarItalic")?.resize(maxWidthHeight: 18)
        let italicButton = UIBarButtonItem(image: italicImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.italicPressed))
        italicButton.tag = 0x03
        items.append(italicButton)

        let headerImage = UIImage(named: "toolbarHeader")?.resize(maxWidthHeight: 22)
        let headerButton = UIBarButtonItem(image: headerImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.headerPressed))
        items.append(headerButton)

        let wikiImage = UIImage(named: "toolbarWiki")?.resize(maxWidthHeight: 25)
        let wikiButton = UIBarButtonItem(image: wikiImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.wikilink))
        items.append(wikiButton)

        let toolbarImage = UIImage(named: "toolbarImage")?.resize(maxWidthHeight: 26)
        let imageButton = UIBarButtonItem(image: toolbarImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.insertImage))
        items.append(imageButton)

        let codeBlockImage = UIImage(named: "codeBlockAsset")?.resize(maxWidthHeight: 24)
        let codeblockButton = UIBarButtonItem(image: codeBlockImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.codeBlockButton))
        items.append(codeblockButton)

//        let quoteImage = UIImage(named: "quote")?.resize(maxWidthHeight: 21)
//        let quoteButton = UIBarButtonItem(image: quoteImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.quotePressed))
//        items.append(quoteButton)

//        let orderedListImage = UIImage(named: "ordered_list")?.resize(maxWidthHeight: 25)
//        let orderedListButton = UIBarButtonItem(image: orderedListImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.orderedListPressed))
//        items.append(orderedListButton)
//
//        let numberedListImage = UIImage(named: "numbered_list")?.resize(maxWidthHeight: 25)
//        let numberedListButton = UIBarButtonItem(image: numberedListImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.numberedListPressed))
//        items.append(numberedListButton)

//        let indentRightImage = UIImage(named: "toolbarIndentRight")?.resize(maxWidthHeight: 25)
//        let indentButton = UIBarButtonItem(image: indentRightImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.indentPressed))
//        items.append(indentButton)
//
//        let indentLeftImage = UIImage(named: "toolbarIndentLeft")?.resize(maxWidthHeight: 25)
//        let unindentButton = UIBarButtonItem(image: indentLeftImage, landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.unIndentPressed))
//        items.append(unindentButton)

//        let undoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "toolbarImage"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.undoPressed))
//        items.append(undoButton)

//        let redoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "redo.png"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.redoPressed))
//        items.append(redoButton)

        var width = CGFloat(0)
        for item in items {
            if item.tag == 0x03 {
                item.width = 30
                width += 30
            } else {
                item.width = 50
                width += 50
            }
        }

        let toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: width, height: 40))
        toolBar.backgroundColor = .darkGray
        toolBar.isTranslucent = false
        toolBar.setItems(items, animated: false)
        toolBar.isUserInteractionEnabled = true

        return toolBar
    }
    
    private func getRTFToolbar() -> UIToolbar {
        let width = self.editArea.superview!.frame.width
        let toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: width, height: 44))

        let boldButton = UIBarButtonItem(image: #imageLiteral(resourceName: "bold.png"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.boldPressed))
        let italicButton = UIBarButtonItem(image: #imageLiteral(resourceName: "italic.png"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.italicPressed))
        let strikeButton = UIBarButtonItem(image: UIImage(named: "strike.png"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.strikePressed))
        let underlineButton = UIBarButtonItem(image: UIImage(named: "underline.png"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(ViewController.underlinePressed))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([boldButton, italicButton, strikeButton, underlineButton, spaceButton], animated: false)

        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        return toolBar
    }
    
    
    @objc func boldPressed() {}

    @objc func tagPressed() {
        editArea.insertText("#")
    }
    
    @objc func italicPressed() {}

    @objc func strikePressed() {}

    @objc func underlinePressed() {}

    @objc func indentPressed() {}
    
    @objc func unIndentPressed() {}
    
    @objc func headerPressed() {}

    @objc func wikilink() {}

    @objc func codeBlockButton() {}

    @objc func quotePressed() {}
    
    @objc func todoPressed() {}

    @objc func orderedListPressed() {}

    @objc func numberedListPressed() {}
    
    @objc func undoPressed() {}
    
    @objc func insertImage() {}
    
    func addToolBar(textField: UITextView, toolbar: UIToolbar) {
        let scrollFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: toolbar.frame.height)
        let scroll = UIScrollView(frame: scrollFrame)
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = CGSize(width: toolbar.frame.width, height: toolbar.frame.height)
        scroll.addSubview(toolbar)

        let topBorder = CALayer()
        topBorder.frame = CGRect(x: -1000, y: 0, width: 9999, height: 1)
        scroll.layer.addSublayer(topBorder)

        let isFirst = textField.isFirstResponder
        if isFirst {
            textField.endEditing(true)
        }

        let inputAccView = UIInputView(frame: scrollFrame, inputViewStyle: .keyboard)
        inputAccView.addSubview(scroll)
        textField.inputAccessoryView = scroll

        if isFirst {
            textField.becomeFirstResponder()
        }
    }
}

