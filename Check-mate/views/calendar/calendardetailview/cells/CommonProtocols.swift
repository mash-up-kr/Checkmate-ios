protocol OpenButtonProtocol: class {
    func showButton()
    func hideButton()
}

protocol SeparatorViewProtocol: class {
    func showSeparator()
    func hideSeparator()
}

protocol PictureCellDelegate: class {
    func buttonPressed(_ pictureCell: PictureCell)
}

protocol TodayTimeCellDelegate: class {
    func openPressed(_ cell: TodayTimeCell)
}

protocol DetailTimeCellDelegate: class {
    func closedPressed(_ cell: DetailTimeCell)
}

protocol DetailMoneyCellDelegate: class {
    func closedPressed(_ cell: DetailMoneyCell)
}

protocol TodayMoneyCellDelegate: class {
    func openPressed(_ cell: TodayMoneyCell)
}
