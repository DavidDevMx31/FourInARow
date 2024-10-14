//
//  GameBoardViewController.swift
//  FourInARow
//
//  Created by David Ali on 14/10/24.
//

import UIKit

class GameBoardViewController: UIViewController {

    private var containerStackView: UIStackView!
    private var columnButtons: [UIButton]!
    
    private var gameStatsStackView: UIStackView!
    private var restartRoundButton: UIButton!
    private var resetCounterButton: UIButton!
    private var playerOneScoreLabel: UILabel!
    private var playerTwoScoreLabel: UILabel!
    
    private var placedChips = [[UIImageView]]()
    
    override func loadView() {
        super.loadView()
        createContainerView()
        createResetCounterButton()
        createRestartRoundButton()
        createGameStatsView()
        setViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
    }
    
    //MARK: Create views
    private func createContainerView() {
        columnButtons = createColumnButtons()
        containerStackView = UIStackView(arrangedSubviews: columnButtons)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.distribution = .fillEqually
        containerStackView.spacing = 2
        
        self.view.addSubview(containerStackView)
    }
    
    private func createColumnButtons() -> [UIButton] {
        var buttons: [UIButton] = []
        for index in 0..<7 {
            let columnButton = UIButton(type: .system)
            columnButton.translatesAutoresizingMaskIntoConstraints = false
            columnButton.backgroundColor = .white
            columnButton.setTitle("", for: .normal)
            columnButton.tag = index
            columnButton.addTarget(self,
                                   action: #selector(makeMove),
                                   for: .touchUpInside)
            buttons.append(columnButton)
        }
        return buttons
    }
    
    private func createRestartRoundButton() {
        restartRoundButton = UIButton(type: .system)
        restartRoundButton.translatesAutoresizingMaskIntoConstraints = false
        restartRoundButton.setTitle("Reiniciar ronda", for: .normal)
        restartRoundButton.addTarget(self, action: #selector(restartRoundTapped), for: .touchUpInside)
    }
    
    private func createResetCounterButton() {
        resetCounterButton = UIButton(type: .system)
        resetCounterButton.translatesAutoresizingMaskIntoConstraints = false
        resetCounterButton.setTitle("Resetear contador", for: .normal)
        resetCounterButton.addTarget(self, action: #selector(resetCounterTapped), for: .touchUpInside)
    }
    
    private func createGameStatsView() {
        setupScoreLabels()
        gameStatsStackView = UIStackView(frame: .zero)
        gameStatsStackView.translatesAutoresizingMaskIntoConstraints = false
        gameStatsStackView.distribution = .equalSpacing
        gameStatsStackView.alignment = .center
        gameStatsStackView.axis = .horizontal
        gameStatsStackView.spacing = 8
        
        gameStatsStackView.addArrangedSubview(restartRoundButton)
        gameStatsStackView.addArrangedSubview(resetCounterButton)
        
        let scoreStackView = UIStackView(arrangedSubviews: [playerOneScoreLabel, playerTwoScoreLabel])
        scoreStackView.distribution = .equalSpacing
        scoreStackView.alignment = .leading
        scoreStackView.axis = .vertical
        scoreStackView.spacing = 4
        
        gameStatsStackView.addArrangedSubview(scoreStackView)
        
        view.addSubview(gameStatsStackView)
    }
    
    private func setupScoreLabels() {
        playerOneScoreLabel = UILabel(frame: .zero)
        playerOneScoreLabel.text = "Red: 0"
        playerOneScoreLabel.numberOfLines = 1
        playerOneScoreLabel.textColor = .white
        
        playerTwoScoreLabel = UILabel(frame: .zero)
        playerTwoScoreLabel.text = "Yellow: 0"
        playerTwoScoreLabel.numberOfLines = 1
        playerTwoScoreLabel.textColor = .white
    }
    
    //MARK: Set constraints
    private func setViewConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: gameStatsStackView.topAnchor, constant: -8),
            
            gameStatsStackView.heightAnchor.constraint(equalToConstant: 80),
            gameStatsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            gameStatsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gameStatsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    //MARK: Actions
    @objc func makeMove(sender: UIButton) {
        debugPrint("\(sender.tag)")
    }
    
    @objc func restartRoundTapped() {
        
    }
    
    @objc func resetCounterTapped() {
        
    }
    
    
}
