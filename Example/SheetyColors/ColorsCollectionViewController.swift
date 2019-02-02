//
//  ViewController.swift
//  SheetyColors
//
//  Created by chrs1885 on 02/02/2019.
//  Copyright (c) 2019 chrs1885. All rights reserved.
//

import SheetyColors
import UIKit

class ColorsCollectionViewController: UICollectionViewController {
    let reuseIdentifier = "ColorCell"
    let colorsFilename = "SheetyColors"
    let minItemSize: CGFloat = 150.0
    let storage = Storage()
    var colorItems: [RGBAColor] = [
        RGBAColor(red: 38.0, green: 41.0, blue: 73.0, alpha: 100.0),
        RGBAColor(red: 11.0, green: 70.0, blue: 96.0, alpha: 100.0),
        RGBAColor(red: 12.0, green: 107.0, blue: 109.0, alpha: 100.0),
        RGBAColor(red: 46.0, green: 170.0, blue: 81.0, alpha: 100.0),
        RGBAColor(red: 147.0, green: 192.0, blue: 31.0, alpha: 100.0),
        RGBAColor(red: 221.0, green: 219.0, blue: 0.0, alpha: 100.0),
        RGBAColor(red: 251.0, green: 191.0, blue: 84.0, alpha: 100.0),
        RGBAColor(red: 238.0, green: 107.0, blue: 59.0, alpha: 100.0),
        RGBAColor(red: 236.0, green: 15.0, blue: 71.0, alpha: 100.0),
        RGBAColor(red: 160.0, green: 44.0, blue: 93.0, alpha: 100.0),
        RGBAColor(red: 112.0, green: 4.0, blue: 96.0, alpha: 100.0),
        RGBAColor(red: 2.0, green: 44.0, blue: 122.0, alpha: 100.0),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedItems = storage.load(from: colorsFilename, as: [RGBAColor].self) {
            colorItems = storedItems
        }
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
    }

    @IBAction func openSheetyColors(_: Any) {
        openColorsActionSheet(with: .createColor)
    }

    func openEditActionSheet(forItemAt item: Int) {
        openColorsActionSheet(with: .editColor(item: item))
    }

    func openColorsActionSheet(with type: SheetType) {
        var itemIndex: Int?
        if case let .editColor(item) = type {
            itemIndex = item
        }

        let color = (itemIndex != nil) ? colorItems[itemIndex!].uiColor : UIColor.white
        let config = SheetyColorsConfig(alphaEnabled: true, hapticFeedbackEnabled: true, initialColor: color, title: type.title, type: .rgb)
        let controller = SheetyColorsController(withConfig: config)

        addSelectAlertAction(for: controller, withType: type)
        addCancelAlertAction(for: controller)
        if let itemIndex = itemIndex {
            addDeleteAlertAction(for: controller, item: itemIndex)
        }

        present(controller, animated: true, completion: nil)
    }

    func addSelectAlertAction(for controller: SheetyColorsController, withType type: SheetType) {
        let selectAction = UIAlertAction(title: "Save Color", style: .default, handler: { _ in
            self.collectionView.performBatchUpdates({
                if case let .editColor(item) = type {
                    self.colorItems[item] = controller.color.rgbaColor
                    self.collectionView.reloadItems(at: [IndexPath(item: item, section: 0)])
                } else {
                    let colorItem = controller.color.rgbaColor
                    self.colorItems.insert(colorItem, at: 0)
                    self.collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
                }
            }, completion: { _ in
                self.saveItems()
            })
        })

        controller.addAction(selectAction)
    }

    func addDeleteAlertAction(for controller: SheetyColorsController, item: Int) {
        let deleteAction = UIAlertAction(title: "Delete Color", style: .destructive, handler: { _ in
            self.collectionView.performBatchUpdates({
                self.colorItems.remove(at: item)
                self.collectionView.deleteItems(at: [IndexPath(item: item, section: 0)])
            }, completion: { _ in
                self.saveItems()
            })
        })

        controller.addAction(deleteAction)
    }

    func addCancelAlertAction(for controller: SheetyColorsController) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
    }

    func saveItems() {
        storage.save(colorItems, to: colorsFilename)
    }
}

// MARK: - Collection View DataSource

extension ColorsCollectionViewController {
    override func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return colorItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let colorItem = colorItems[indexPath.item]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ColorCell
        cell.color = colorItem.uiColor

        return cell
    }
}

// MARK: - Collection View Delegate

extension ColorsCollectionViewController {
    override func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openEditActionSheet(forItemAt: indexPath.item)
    }
}

// MARK: - Collection View Drag

extension ColorsCollectionViewController: UICollectionViewDragDelegate {
    func collectionView(_: UICollectionView, itemsForBeginning _: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = colorItems[indexPath.row]
        let itemProvider = NSItemProvider(object: item)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item

        return [dragItem]
    }
}

// MARK: - Collection View Drop

extension ColorsCollectionViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath _: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil, collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }

        return UICollectionViewDropProposal(operation: .forbidden)
    }

    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        switch coordinator.proposal.operation {
        case .move:
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            storage.save(colorItems, to: colorsFilename)
        default:
            return
        }
    }

    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        var destination = destinationIndexPath
        let items = coordinator.items

        if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
            if destination.row >= collectionView.numberOfItems(inSection: 0) {
                destination.row = collectionView.numberOfItems(inSection: 0) - 1
            }
            collectionView.performBatchUpdates({
                if collectionView === self.collectionView {
                    colorItems.remove(at: sourceIndexPath.row)
                    colorItems.insert(item.dragItem.localObject as! RGBAColor, at: destination.row)
                }
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destination])
            })
            coordinator.drop(items.first!.dragItem, toItemAt: destination)
        }
    }
}

// MARK: - Collection View Layout

extension ColorsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let frameWidth = collectionView.frame.width
        let itemSize = frameWidth / round(frameWidth / minItemSize)

        return CGSize(width: itemSize, height: itemSize)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0.0
    }
}
