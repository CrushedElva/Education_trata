import UIKit

protocol ReaderDelegate: class {
    func didReadData(data: Data)
}

class Reader{
    var file: String!
    var output: ReaderDelegate?
    var readCompleteBlock: (() -> Void)?
    
    func read() {
        /*
         Здесь не нужно использовать FU
         */
        let fileUrl = URL(fileURLWithPath: file!)
        let data = try? Data(contentsOf: fileUrl)
        self.output?.didReadData(data: data!)
        self.readCompleteBlock?();
    }
}
/*
 Имя класса принято писать с большой буквы
 */
class OrderReader: ReaderDelegate {
    public var reader: Reader
    /*
     Инициализацию reader лучше делать в классе Reader.
     Это связано с тем, что если в дальнейшем будет необходимо менять логику инициализации,
     то нужно будет это поменять только в одном месте, а не везде, где используется класс Reader.
     */
    init(_ file: URL) {
        /*
         В данной ситуации нет необходимости использовать self
         */
        self.reader = Reader()
        self.reader.file = file.absoluteString.replacingOccurrences(of: "file://", with: "")
        self.reader.output = self
        self.reader.readCompleteBlock = {
            self.didComplete()
        }
    }
    
    /*
     Имя функции принято писать с маленькой буквы
     */
    func Read() {
        /*
         В данной ситуации нет необходимости использовать self
         */
        self.reader.read()
    }
    
    func didComplete() {
        print("end of file")
    }
    
    func didReadData(data: Data) {
        print("\(data)")
    }
}

/*
 Название файла лучше вынести в константу
 */
let filePath = Bundle.main.path(forResource: "myOrders.csv", ofType: nil)
/*
 Название переменной и класса не должны совпадать
 */
let orderReader = orderReader(URL(fileURLWithPath: filePath!))
/*
 Здесь нельзя использовать выражения
 */
orderReader.Read()
