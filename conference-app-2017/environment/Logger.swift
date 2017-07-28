import Foundation
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.default
    log.setup(
        level: .debug,
        showThreadName: true,
        showLevel: true,
        showFileNames: true,
        showLineNumbers: true,
        writeToFile: nil
    )

    // date
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy hh:mma"
    dateFormatter.locale = NSLocale.current
    log.dateFormatter = dateFormatter

    // emoji to highlight log levels
    // https://github.com/DaveWoodCom/XCGLogger/blob/master/DemoApps/iOSDemo/iOSDemo/AppDelegate.swift#L64-L71
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", to: .error)
    emojiLogFormatter.apply(prefix: "💣💣💣 ", to: .severe)
    log.formatters = [emojiLogFormatter]

    return log
}()
