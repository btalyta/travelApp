//
//  CustomTextField.swift
//  TravelApp
//
//  Created by Barbara Souza on 22/01/21.
//

import UIKit

class CustomTextField: UIView {
    var didBeginEditing: (() -> Void)?
    var didChangeInput: ((_ input: String) -> Void)?

    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }

    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }

    private let fieldLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()

    private let textField = UITextField()

    private let contentView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()

    init(frame: CGRect = .zero, title: String) {
        super.init(frame: frame)

        fieldLabel.text = title
        setupView()
        addConstraints()
        addActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(fieldLabel)
        addSubview(textField)

        layer.borderWidth = 1.0
    }
    
    private func addConstraints() {
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        let fieldLabelConstraints = [
            fieldLabel.topAnchor.constraint(equalTo: topAnchor),
            fieldLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            fieldLabel.rightAnchor.constraint(equalTo:  textField.leftAnchor),
            fieldLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            fieldLabel.heightAnchor.constraint(equalToConstant: 50),
            fieldLabel.widthAnchor.constraint(equalToConstant: 90)
        ]

        NSLayoutConstraint.activate(fieldLabelConstraints)

        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(textFieldConstraints)
    }

    private func addActions() {
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc func textFieldDidChange() {
        didChangeInput?(text ?? "")
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didBeginEditing?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
