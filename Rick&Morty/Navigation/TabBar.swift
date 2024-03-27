//
//  TabBar.swift
//  Rick&Morty
//
//  Created by Nikita on 27.03.2024.
//

import UIKit

class TabBar: UITabBar {
    
    //MARK: - Properties
    
    private var shapeLayer: CAShapeLayer?

    //MARK: - Draw methods
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.backBlue.cgColor
        shapeLayer.shadowColor = UIColor.white.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowOpacity = 0.3
        shapeLayer.shadowRadius = 10

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let radius: CGFloat = 20
        let yOffset: CGFloat = 24
        let xOffset: CGFloat = 8

        let rectBounds = CGRect(x: xOffset,
                                y: yOffset,
                                width: self.bounds.width - xOffset * 2,
                                height: self.bounds.height - yOffset * 2)

        let roundedRectPath = UIBezierPath(roundedRect: rectBounds, cornerRadius: radius)

        return roundedRectPath.cgPath
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height += UIView.safeAreaInset.bottom
        return sizeThatFits
    }
}
