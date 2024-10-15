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
    
    var board: GameBoard!
    var gameStatus = Game()
    
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
        placeChips()
        resetBoard()
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
        playerOneScoreLabel.text = "Red: \(gameStatus.redWins)"
        playerOneScoreLabel.numberOfLines = 1
        playerOneScoreLabel.textColor = .white
        
        playerTwoScoreLabel = UILabel(frame: .zero)
        playerTwoScoreLabel.text = "Yellow: \(gameStatus.yellowWins)"
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
        let column = sender.tag
                
        if let row = board.nextEmptySlot(in: column) {
            board.addChip(board.currentPlayer.chip, in: column)
            addChip(board.currentPlayer.chip, inColumn: column, row: row)
            checkRoundResult(column: column, row: row)
        }
    }
    
    @objc func restartRoundTapped() {
        let alert = UIAlertController(title: "Would you like to restart the current round?",
                                      message: "You will lose the current round progress.",
                                      preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Restart round", style: .default) {
            [unowned self] (action) in
            self.resetBoard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    @objc func resetCounterTapped() {
        
    }
    
    //MARK: Game
    private func placeChips() {
        for _ in 0 ..< GameBoard.width {
            placedChips.append([UIImageView]())
        }
    }
    
    private func resetBoard() {
        board = GameBoard()
        
        for i in 0 ..< placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    private func checkRoundResult(column: Int, row: Int) {
        var gameOverTitle: String? = nil
        
        if board.playerWins(column: column, row: row) {
            gameOverTitle = "\(board.currentPlayer.chip.name) wins"
        } else if board.isGameBoardFull() {
            gameOverTitle = "Draw!"
        }
        
        if gameOverTitle != nil {
            gameStatus.declareWinner(player: board.currentPlayer)
            let message = "Red wins: \(gameStatus.redWins)\nYellow wins: \(gameStatus.yellowWins)"
            let alert = UIAlertController(title: gameOverTitle, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Play again", style: .default) { [unowned self] (action) in
                self.resetBoard()
                self.updateScoreLabels()
            }
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
        
        board.currentPlayer = board.currentPlayer.opponent
        updateUI()
    }
    
    private func updateUI() {
        title = "\(board.currentPlayer.chip.name)'s turn"
    }
    
    private func updateScoreLabels() {
        playerOneScoreLabel.text = "Red: \(gameStatus.redWins)"
        playerTwoScoreLabel.text = "Yellow: \(gameStatus.yellowWins)"
    }
    
    //MARK: Draw board
    private func addChip(_ chip: Chip, inColumn column: Int, row: Int) {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        if (placedChips[column].count < row + 1) {
            let newChip = UIImageView(frame: rect)
            let chipImage = UIImage(named: chip.imageName)
            newChip.image = chipImage
            newChip.isUserInteractionEnabled = false
            newChip.center = positionForChip(inColumn: column, row: row)
            newChip.transform = CGAffineTransform(translationX: 0, y: -800)
            self.view.addSubview(newChip)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                newChip.transform = CGAffineTransform.identity
            }
            
            placedChips[column].append(newChip)
        }
    }
    
    private func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        
        let xOffset = button.frame.midX
        var yOffset = button.frame.maxY - size / 2
        yOffset -= size * CGFloat(row)
        return CGPoint(x: xOffset, y: yOffset)
    }
    
}
