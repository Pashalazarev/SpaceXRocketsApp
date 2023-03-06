//
//  MainScreenCollectionViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 15.02.2023.
//

import UIKit

final class MainScreenCollectionViewController: UICollectionViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Section.CellType>?
    private let snapshot = NSDiffableDataSourceSnapshot<Section, Section.CellType>()
    private var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
        collectionView.register(HeaderCollectionViewCell.nib(), forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        collectionView.register(VerticalCollectionViewCell.nib(), forCellWithReuseIdentifier: VerticalCollectionViewCell.identifier)
        collectionView.register(HorizontalCollectionViewCell.nib(), forCellWithReuseIdentifier: HorizontalCollectionViewCell.identifier)
        collectionView.register(ButtonCollectionViewCell.nib(), forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
        
        NetworkService.shared.fetchRockets { result in
            switch result {
            case .success(let rockets):
                for rocket in rockets {
                    let sections = MainScreenCollectionViewController.getSections(rocket: rocket)
                    self.sections = sections
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - UICollectionViewDiffableDataSource
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Section.CellType>(collectionView: collectionView) {collectionView,indexPath,cell in // это dataSource
            switch cell {
            case .rocketImage(url: let url, rocketName: let rocketName):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell
                guard let imageData = try? Data(contentsOf: url) else { return nil }
                cell?.rocketImageView.image = UIImage(data: imageData)
                cell?.rocketNameLabel.text = rocketName
                return cell
            case .verticalInfo(value: let value, text: let text):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCollectionViewCell.identifier, for: indexPath) as? VerticalCollectionViewCell
                cell?.valueLabel.text = value
                cell?.textLabel.text = text
                return cell
            case .horizontalInfo(title: let title, value: let value):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalCollectionViewCell.identifier, for: indexPath) as? HorizontalCollectionViewCell
                cell?.titleLabel.text = title
                cell?.valueLabel.text = value
                return cell
            case .button:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as? ButtonCollectionViewCell
                cell?.showLaunchesButton.titleLabel?.text = "Посмотреть запуски"
                return cell
            }
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, Section.CellType>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.cell, toSection: section)
        }
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
    
// MARK: - UICompositionalLayout
extension MainScreenCollectionViewController {
   
    private func createLayout() -> UICollectionViewLayout {
 
        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.8)
        ) //высота элемента как высота группы
        let headerItem = NSCollectionLayoutItem(layoutSize: headerItemSize)
        let headerGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
             heightDimension: .fractionalHeight(0.4)
        )
        let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: headerGroupSize, subitems: [headerItem])
        let headerItemSection = NSCollectionLayoutSection(group: headerGroup)
        let headerSection = NSCollectionLayoutSection(group: headerGroup)
        headerSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: -20, trailing: 0)

        let verticalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)
        let verticalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(0.3)
        )
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [verticalItem])
        let verticalItemSection = NSCollectionLayoutSection(group: verticalGroup)
        let verticalSection = NSCollectionLayoutSection(group: verticalGroup)
        verticalSection.orthogonalScrollingBehavior = .continuous
        verticalSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: -20, trailing: 0)
  
        let horizontalItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let horizontalItem = NSCollectionLayoutItem(layoutSize: horizontalItemSize)
        let horizontalGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.4)
        )
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [horizontalItem])
        let horizontalItemSection = NSCollectionLayoutSection(group: horizontalGroup)
        let horizontalSection = NSCollectionLayoutSection(group: horizontalGroup)
        horizontalSection.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0)
        
        let buttonItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.2)
        )
        let buttonItem = NSCollectionLayoutItem(layoutSize: buttonItemSize)
        let buttonGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .fractionalHeight(0.3)
        )
        let buttonGroup = NSCollectionLayoutGroup.horizontal(layoutSize: buttonGroupSize, subitems: [buttonItem])
        let buttonItemSection = NSCollectionLayoutSection(group: buttonGroup)
        let buttonSection = NSCollectionLayoutSection(group: buttonGroup)
        buttonSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 10, trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout{(sectionsIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionType = self.sections[sectionsIndex].section
            switch sectionType {
            case .imageHeader:
                return headerItemSection
            case .verticalInfo:
                return verticalItemSection
            case .horizontalInfo:
                return horizontalItemSection
            case .button:
                return buttonItemSection
            }
        }
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
    }
}

extension MainScreenCollectionViewController {
     static func getSections(rocket: Rocket) -> [Section] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let heightValue: String
        let height: String
        if Settings.SettingsType.height == .height {
            heightValue = rocket.height.meters.formatted()
            height = Settings.Units.meters.rawValue
        } else {
            heightValue = rocket.height.feet.formatted()
            height = Settings.Units.feets.rawValue
        }
        
        let diametrValue: String
        let diametr: String
        if Settings.SettingsType.diameter == .diameter {
            diametrValue = rocket.diameter.meters.formatted()
            diametr = Settings.Units.meters.rawValue
        } else {
            diametrValue = rocket.diameter.feet.formatted()
            diametr = Settings.Units.feets.rawValue
        }
        
        let weightValue: String
        let weight: String
        if Settings.SettingsType.weight == .weight {
            weightValue = rocket.mass.kg.formatted()
            weight = Settings.Units.kilograms.rawValue
        } else {
            weightValue = rocket.mass.lb.formatted()
            weight = Settings.Units.pounds.rawValue
        }
        
        let payloadValue: String
        let payload: String
        if Settings.SettingsType.payload == .payload{
            payloadValue = rocket.payloadWeights[0].kg.formatted()
            payload = Settings.Units.kilograms.rawValue
        } else {
            payloadValue = rocket.payloadWeights[1].lb.formatted()
            payload = Settings.Units.pounds.rawValue
        }
        return [
            Section(
                title: nil,
                section: .imageHeader,
                cell: [
                    .rocketImage(url: rocket.flickrImages[0], rocketName: rocket.name)
                ]
            ),
            Section(
                title: nil,
                section: .horizontalInfo,
                cell: [
                    .verticalInfo(value: heightValue, text: height),
                    .verticalInfo(value: diametrValue, text: diametr),
                    .verticalInfo(value: weightValue, text: weight),
                    .verticalInfo(value: payloadValue, text: payload)
                ]
            ),
            Section(title: nil,
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Первый запуск", value: dateFormatter.string(from: rocket.firstFlight)),
                        .horizontalInfo(title: "Страна", value: rocket.country),
                        .horizontalInfo(title: "Стоимость запуска", value: rocket.costPerLaunch.formatted())
                    ]
                   ),
            Section(title: "Первая ступень",
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Количество двигателей", value: rocket.firstStage.engines.formatted()),
                        .horizontalInfo(title: "Количество топлива", value: rocket.firstStage.fuelAmountTons.formatted()),
                        .horizontalInfo(title: "Время сгорания", value: rocket.firstStage.burnTimeSec?.formatted() ?? "")
                    ]
                   ),
            Section(title: "Вторая ступень",
                    section: .horizontalInfo,
                    cell: [
                        .horizontalInfo(title: "Количество двигателей", value: rocket.secondStage.engines.formatted()),
                        .horizontalInfo(title: "Количество топлива", value: rocket.secondStage.fuelAmountTons.formatted()),
                        .horizontalInfo(title: "Время сгорания", value: rocket.secondStage.burnTimeSec?.formatted() ?? "")
                    ]
                   ),
            Section(title: nil,
                    section: .horizontalInfo,
                    cell: [.button]
                   )
        ]
    }
}
