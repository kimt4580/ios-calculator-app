import XCTest

class CalculatorTests: XCTestCase {
    func test_빈_큐에_1을_put하면_1이_남는다() {
        let queue = CalculatorItemQueue<Int>(head: nil)
        queue.insertToQueue(1)
        XCTAssertEqual(queue.head?.nodeValue, Optional(1))
        XCTAssertNil(queue.head?.pointer)
    }
        
    func test_1이_있는_큐에_2를_put하면_1과_2가_남는다() {
        let queue = CalculatorItemQueue<Int>(head: Node(1))
        queue.insertToQueue(2)
        XCTAssertEqual(queue.head?.nodeValue, Optional(1))
        XCTAssertEqual(queue.head?.pointer?.nodeValue, Optional(2))
        XCTAssertNil(queue.head?.pointer?.pointer)
    }

    func test_1만_있는_큐에_get을_하면_빈_큐가_된다() {
        let queue = CalculatorItemQueue<Int>(head: Node(1))
        queue.deleteFromQueue()
        XCTAssertNil(queue.head?.nodeValue)
    }

    func test_1과_2가_있는_큐에_get을_하면_2가_남는다() {
        let queue = CalculatorItemQueue<Int>(head: Node(1, pointer: Node(2)))
        queue.deleteFromQueue()
        XCTAssertEqual(queue.head?.nodeValue, Optional(2))
        XCTAssertNil(queue.head?.pointer)
    }

    func deleteFromQueue() {
        let queue = CalculatorItemQueue<Int>(head: nil)
        queue.deleteFromQueue()
        XCTAssertNil(queue.head?.nodeValue)
    }

}
