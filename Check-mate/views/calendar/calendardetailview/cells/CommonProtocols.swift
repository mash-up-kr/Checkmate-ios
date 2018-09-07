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
    func buttonPressed(_ cell: TodayTimeCell)
}
