//
//  UIView.swift
//  QRCodeTarot
//
//  Created by Scott Lydon on 4/14/22.
//

import UIKit

public extension UIView {
    /// Inserts a subview and constrains it to fill this view (the superview) by default.
    ///  Using string formats supports older OS.  This has an early exit if the
    /// view is already injected.  This also clears the subViews before injecting.
    /// - Parameters:
    ///   - view: The view you are injecting
    func inject(view: UIView, insets: UIEdgeInsets = .zero) {
        guard !subviews.contains(view) else { return }
        view.frame = bounds
        addSubview(view)
        pinToEdges(view: view)
    }

    func pinToEdges(view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        [
            topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: -insets.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)
        ].forEach {
            $0.isActive = true
        }
    }

    var clear: UIView {
        backgroundColor = .clear
        return self
    }

    func asClear() -> Self {
        backgroundColor = .clear
        return self
    }

    func cellSizeWhen(
        for interface: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom,
        isPortrait: Bool
    ) -> CGSize {
        let width = isPortrait ? (frame.width - 10) / 3 : (frame.width - 20) / 5
        return .init(width: width, height: width)
    }

    func set(background: UIView) {
        insertSubview(background, at: 0)
        pinToEdges(view: background)
    }

    static var zero: Self {
        Self(frame: .zero)
    }

    // MARK - round view

    func makeCircularClipsMask() {
        layer.masksToBounds = true
        makeCircularClips()
    }

    func makeCircularClips() {
        //let width = bounds.size.width
        let height = bounds.size.height
       // URL.assert(width > 0, message: "width > 0").post()
        //URL.assert(height > 0, message: "width > 0").post()
        //URL.assert(width == height, message: "width == height").post()
        layer.cornerRadius = 0.5 * height
        assert(layer.cornerRadius > 0)
        clipsToBounds = true
    }

    func roundCorners(constant: CGFloat = 5) {
        roundOrSharpenCorners(constant: constant)
        assert(layer.cornerRadius > 0)
    }

    func roundOrSharpenCorners(constant: CGFloat = 5) {
        layer.cornerRadius = constant
        layer.masksToBounds = true
        clipsToBounds = true
    }

    func setUpCircleView(_ img: UIImage, inset: CGFloat) {
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        makeCircularClips()
        layer.applySketchShadow()
        let imgView = UIImageView(frame: frame)
        imgView.image = img.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = .white
        addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
              imgView.heightAnchor.constraint(equalTo: heightAnchor, constant: inset),
              imgView.widthAnchor.constraint(equalTo: widthAnchor, constant: inset),
              imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
              imgView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ]
        )
        imgView.backgroundColor = .clear
    }

    // MARK - style

    func glow(color: UIColor = .white) {
        layer.masksToBounds = false
        layer.shadowOffset = .zero
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    // MARK - create borders

    struct BorderModel {
        enum Edge {
            case left, right, top, bottom
        }

        var color: UIColor
        var width: CGFloat
        var edges: [Edge]
    }

//    func addBorder(model: BorderModel) {
//        for edge in model.edges {
//            let border = UIView()
//            addSubview(border)
//            border.backgroundColor = model.color
//            switch edge {
//            case .left:
//                border.constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    secondHorizontal: .width(model.width),
//                    vertical: .distanceToTop(topAnchor, 0),
//                    secondVertical: .distanceToBottom(bottomAnchor, 0)
//                )
//            case .right:
//                border.constraints(
//                    firstHorizontal: .distanceToTrailing(trailingAnchor, 0),
//                    secondHorizontal: .width(model.width),
//                    vertical: .distanceToTop(topAnchor, 0),
//                    secondVertical: .distanceToBottom(bottomAnchor, 0)
//                )
//            case .top:
//                border.constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    secondHorizontal: .distanceToTrailing(trailingAnchor, 0),
//                    vertical: .height(model.width),
//                    secondVertical: .distanceToTop(topAnchor, 0)
//                )
//            case .bottom:
//                border.constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    secondHorizontal: .distanceToTrailing(trailingAnchor, 0),
//                    vertical: .height(model.width),
//                    secondVertical: .distanceToBottom(bottomAnchor, 0)
//                )
//            }
//        }
//    }

    // MARK - subview constructions

//    func demoConstrain(view: UIView, height: CGFloat = 40, width: CGFloat = 100) {
//        addSubview(view)
//        view.constraints(
//            firstHorizontal: .centeredHorizontallyWith(self),
//            secondHorizontal: .width(width),
//            vertical: .centeredVerticallyTo(self),
//            secondVertical: .height(height)
//        )
//    }
//
//    func addSubViewsLikeStackView(_ views: [UIView])  {
//        var views = views
//        guard let first = views.pullFirst() else { return }
//        addConstrainedToTopAndBottom(first)
//        first.constraint(from: .distanceToLeading(leadingAnchor, 0))
//        var latest = first
//        for v in views {
//            addConstrainedToTopAndBottom(v)
//            v.constraint(from: .distanceToLeading(latest.trailingAnchor, 0))
//            v.constraint(from: .proportionalWidthTo(latest, 1))
//            latest = v
//        }
//        latest.constraint(from: .distanceToTrailing(trailingAnchor, 0))
//    }
//
//    @discardableResult
//    func addSubViewsLikeStackView(_ views: [UIView], spacerColor: UIColor, spacerWidth: CGFloat = 1.5) -> CentipedeModel? {
//        var views = views
//        guard let first = views.pullFirst() else { return nil }
//        addConstrainedToTopAndBottom(first)
//        first.constraint(from: .distanceToLeading(leadingAnchor, 0))
//        var latest = first
//        var centipedeModel = CentipedeModel(first: first, containers: [])
//        for v in views {
//            let spacer = UIView()
//            addConstrainedToTopAndBottom(spacer)
//            spacer.constraint(from: .width(spacerWidth))
//            spacer.backgroundColor = spacerColor
//            spacer.constraint(from: .distanceToLeading(latest.trailingAnchor, 0))
//            addConstrainedToTopAndBottom(v)
//            v.constraint(from: .distanceToLeading(spacer.trailingAnchor, 0))
//            v.constraint(from: .proportionalWidthTo(latest, 1))
//            latest = v
//            centipedeModel.containers.append(SpacerContainer(spacer: spacer, view: v))
//        }
//        latest.constraint(from: .distanceToTrailing(trailingAnchor, 0))
//        return centipedeModel
//    }

    func addConstrainedToTopAndBottom(_ view: UIView) {
        addSubview(view)
        view.constraint(from: .distanceToTop(topAnchor, 0))
        view.constraint(from: .distanceToBottom(bottomAnchor, 0))
    }
//
//    var flattenedSubViews: [UIView] {
//        var returnViews: [UIView] = []
//        var nextViews: [UIView] = [self]
//        while nextViews.hasElements {
//            var viewsToAdd: [UIView] = []
//            for _ in nextViews {
//                let last = nextViews.removeLast()
//                returnViews.append(last)
//                viewsToAdd.append(contentsOf: last.subviews)
//            }
//        }
//        return returnViews
//    }
//
//    var andFlattenedSubViews: [UIView] {
//        return [self] + flattenedSubViews
//    }

    // MARK - computed properties

    var halfHeight: CGFloat {
        return frame.height / 2
    }

    func the(view first: UIView?, isAbove second: UIView?) -> Bool {
        guard let cellArrowPoint = first?.frame.origin,
            let vcHolderPoint = second?.frame.origin,
            let cellArrowPointinView = first?.convert(cellArrowPoint, to: self),
            let vcHolderPointinView = second?.convert(vcHolderPoint, to: self) else { return false }
        var top: CGFloat = 0
        if #available(iOS 11.0, *),
            let safeAreaTopHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            top = safeAreaTopHeight
        }
        return cellArrowPointinView.y < vcHolderPointinView.y - top
    }

    var parent: UIViewController? {
        var parent: UIResponder? = self
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    // MARK - pin to edges

    func pinToEdges(_ subView: UIView, padding: Int) {
        self.pinToEdges(subView, padding: CGFloat(padding))
    }

    func pinToEdges(_ subView: UIView, padding: CGFloat) {
        self.pinToEdges(subView, padding: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    func pinToEdges(_ subView: UIView, padding: UIEdgeInsets = .zero) {
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding.top)-[view]-\(padding.bottom)-|", options: [], metrics: nil, views: ["view" : subView])
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding.left)-[view]-\(padding.right)-|", options: [], metrics: nil, views: ["view": subView])
        self.addConstraints(widthConstraints + heightConstraints)
    }


    // MARK - clear

    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }

    func clearSubViews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }

    // MARK - animate update.

    func updateWithBounceAnimation(with duration: TimeInterval = 0.6, delay: Double = 0.0, usingSpringWithDampening: CGFloat = 0.75, initialSPringVelocity: CGFloat = 1.0) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: usingSpringWithDampening, initialSpringVelocity: initialSPringVelocity, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }) {_ in
            //self.isScrollViewDisabled = false
        }
    }
}



struct ViewWithLeftMargin {
    var leftMargin: CGFloat
    var view: UIView
    var width: CGFloat
    var height: CGFloat? = nil
}

struct ViewWithRightMargin {
    var rightMargin: CGFloat
    var view: UIView
    var width: CGFloat
    var height: CGFloat? = nil
}



protocol ConstraintDescriptor {}

@objc public extension UIView {
    func roundedCorners(radius: Int) {
        let cardRadius = CGFloat(radius)
        layer.cornerRadius = cardRadius
    }

    func round(corners: UIRectCorner, cornerRadius: Double) {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }

}

public extension UIView {

    // MARK - enums

    enum Orientation {
        case horizontal, vertical
    }

    enum Centering {
        case centered, latchToTopMargin
    }

    enum LayoutDescriptor {
        case horizontal(HorizontalDescriptor)
        case vertical(VerticalDescriptor)
    }

    enum Flexibility {
        case flexible, notFlexible
    }

    enum HorizontalDescriptor: ConstraintDescriptor  {
        case centeredHorizontallyWith(UIView)
        case distanceToLeading(NSLayoutAnchor<NSLayoutXAxisAnchor>, CGFloat)
        case distanceToTrailing(NSLayoutAnchor<NSLayoutXAxisAnchor>, CGFloat)
        case proportionalWidthTo(UIView, CGFloat)
        case width(CGFloat)

        var description: String {
            switch self {
            case .distanceToLeading(let anchor, let distance):
                return ".distanceToLeft, anchor: \(anchor), distance: \(distance)"
            case .centeredHorizontallyWith(let view):
                return ".centeredWith, view: \(view)"
            case .width(let width):
                return ".width: \(width)"
            case .distanceToTrailing(let anchor, let distance):
                return ".distanceToRight, anchor: \(anchor), distance: \(distance)"
            case .proportionalWidthTo(let view, let multiplier):
                return "proportionalWidthTo: \(view), \(multiplier)"
            }
        }
    }

    enum VerticalDescriptor: ConstraintDescriptor {
        case centeredVerticallyTo(UIView)
        case distanceToBottom(NSLayoutAnchor<NSLayoutYAxisAnchor>, CGFloat)
        case distanceToTop(NSLayoutAnchor<NSLayoutYAxisAnchor>, CGFloat)
        case height(CGFloat)
        case proportionalHeightTo(UIView, CGFloat)


        var description: String {
            switch self {
            case .height(let height):
                return ".height: \(height)"
            case .distanceToTop(let anchor, let distance):
                return ".distanceToTop, anchor: \(anchor), distance: \(distance)"
            case .distanceToBottom(let anchor, let distance):
                return ".distanceToBottom, anchor: \(anchor), distance: \(distance)"
            case .centeredVerticallyTo(let view):
                return ".centeredTo, view: \(view)"
            case .proportionalHeightTo(let view, let multiplier):
                return "proportionalHeightTo(\(view), \(multiplier)"
            }
        }

    }

    // MARK - add subviews

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    // MARK - add subview with constrained order

//    func latch(_ view: UIView, to direction: Direction) {
//        addSubview(view)
//        switch direction {
//        case .vertical(let vertical):
//            switch vertical {
//            case .up:
//                constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    secondHorizontal: .distanceToTrailing(trailingAnchor, 0),
//                    vertical: .distanceToTop(topAnchor, 0)
//                )
//            case .down:
//                constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    secondHorizontal: .distanceToTrailing(trailingAnchor, 0),
//                    vertical: .distanceToBottom(topAnchor, 0)
//                )
//            }
//        case .horizontal(let horizontal):
//            switch horizontal {
//            case .left:
//                constraints(
//                    firstHorizontal: .distanceToLeading(leadingAnchor, 0),
//                    vertical: .distanceToTop(topAnchor, 0),
//                    secondVertical: .distanceToBottom(bottomAnchor, 0)
//                )
//            case .right:
//                constraints(
//                    firstHorizontal: .distanceToTrailing(leadingAnchor, 0),
//                    vertical: .distanceToTop(topAnchor, 0),
//                    secondVertical: .distanceToBottom(bottomAnchor, 0)
//                )
//            }
//        }
//    }

    // MARK - assertion

//    func assertSuppliedViewIsNotaSubView(view: UIView) {
//        if subviews.contains(view) {
//            URL.assert(
//                message: "Constraints work more reliably if you constrain up.  ie: it is better to do: 'subView.constraints(horizontal: .distanceToLeading(container.leading...' vs 'container.constraints(horizontal: .distanceToLeading(subView.leading...'\(#line) \(#file)"
//                ).ping()
//        }
//    }

    // MARK - generate constraints

//    @discardableResult
//    func pinToEdges(of view: UIView, margin: CGFloat = 0) -> Constraints {
//        let top = constraint(from: .distanceToTop(view.topAnchor, margin))
//        let bottom = constraint(from: .distanceToBottom(view.bottomAnchor, margin))
//        let left = constraint(from: .distanceToLeading(view.leadingAnchor, margin))
//        let right = constraint(from: .distanceToTrailing(view.trailingAnchor, margin))
//        return Constraints(top: top, bottom: bottom, left: left, right: right)
//    }


//    @discardableResult
//    func constraints(_ descriptors: LayoutDescriptor...) -> [NSLayoutConstraint] {
//        var constraints: [NSLayoutConstraint] = []
//        for descriptor in descriptors {
//            switch descriptor {
//            case .horizontal(let horizontal):
//                constraints.append(constraint(from: horizontal))
//            case .vertical(let vertical):
//                constraints.append(constraint(from: vertical))
//            }
//        }
//        return constraints
//    }


//    @discardableResult
//    func constraints(
//        firstHorizontal: HorizontalDescriptor? = nil,
//        secondHorizontal: HorizontalDescriptor? = nil,
//        vertical: VerticalDescriptor? = nil,
//        secondVertical: VerticalDescriptor? = nil,
//        activated shouldActivate: Bool = true
//        ) -> [NSLayoutConstraint] {
//        translatesAutoresizingMaskIntoConstraints = false
//        var constraints: [NSLayoutConstraint] = []
//        let horizontals: [HorizontalDescriptor] = [firstHorizontal, secondHorizontal].compactMap { $0 }
//        constraints +=  horizontals.compactMap {constraint(from: $0)}
//        let verticals: [VerticalDescriptor] = [vertical, secondVertical].compactMap  { $0 }
//        constraints += verticals.compactMap {constraint(from: $0)}
//        if shouldActivate {NSLayoutConstraint.activate(constraints)}
//        return constraints
//    }
//
//    @discardableResult
//    func constraints(
//        horizontals: HorizontalDescriptor...,
//        verticals: VerticalDescriptor,
//        activated shouldActivate: Bool = true
//        ) -> [NSLayoutConstraint] {
//        translatesAutoresizingMaskIntoConstraints = false
//        let constraints: [NSLayoutConstraint] = []
//       // constraints += [horizontal, secondHorizontal].compactMap {constraint(from: $0)}
//       // constraints += [vertical, secondVertical].compactMap {constraint(from: $0)}
//        if shouldActivate {NSLayoutConstraint.activate(constraints)}
//        return constraints
//    }
//
//    func constraints(from constraintsDescriptors: ConstraintDescriptor...) {
//        for descriptor in constraintsDescriptors {
//            if let horizontal = descriptor as? HorizontalDescriptor {
//                let newConstraint = constraint(from: horizontal)
//                NSLayoutConstraint.activate([newConstraint])
//            }
//            if let vertical = descriptor as? VerticalDescriptor {
//                let newConstraint = constraint(from: vertical)
//                NSLayoutConstraint.activate([newConstraint])
//            }
//        }
//    }
//
//    @discardableResult
//    func constraint(from: HorizontalDescriptor, isActive: Bool = true) -> NSLayoutConstraint {
//        translatesAutoresizingMaskIntoConstraints = false
//        var constraint: NSLayoutConstraint
//        switch from {
//        case .width(let width):
//            constraint =  widthAnchor.constraint(equalToConstant: width)
//        case let .distanceToLeading(anchor, distance):
//            constraint = leadingAnchor.constraint(
//                equalTo: anchor,
//                constant: distance
//            )
//        case let .distanceToTrailing(anchor, distance):
//            constraint = trailingAnchor.constraint(
//                equalTo: anchor,
//                constant: distance * -1
//            )
//        case .centeredHorizontallyWith(let view):
//            constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            assertSuppliedViewIsNotaSubView(view: view)
//        case .proportionalWidthTo(let view, let multiplier):
//            constraint = widthAnchor.constraint(
//                equalTo: view.widthAnchor,
//                multiplier: multiplier
//            )
//            assertSuppliedViewIsNotaSubView(view: view)
//        }
//        constraint.isActive = isActive
//        return constraint
//    }

    @discardableResult
    func constraint(from: VerticalDescriptor, isActive: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        var constraint: NSLayoutConstraint
        switch from {
        case .height(let height):
            constraint = heightAnchor.constraint(equalToConstant: height)
        case let .distanceToTop(anchor, distance):
            constraint = topAnchor.constraint(
                equalTo: anchor,
                constant: distance
            )
        case let .distanceToBottom(anchor, distance):
            constraint = bottomAnchor.constraint(
                equalTo: anchor,
                constant: distance * -1
            )
        case .centeredVerticallyTo(let view):
            constraint =  centerYAnchor.constraint(equalTo: view.centerYAnchor)
        case .proportionalHeightTo(let view, let multiplier):
            constraint = heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: multiplier
            )
        }
        constraint.isActive = isActive
        return constraint
    }
}
