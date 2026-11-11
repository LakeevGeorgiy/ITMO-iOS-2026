/// Простая очередь с приоритетом на массиве.
/// Чем больше `priority`, тем раньше извлекается элемент.
struct PriorityQueue<Element> {
    private struct QueueElement {
        let value: Element
        let priority: Int
    }

    private var elements: [QueueElement] = []

    var isEmpty: Bool { elements.isEmpty }
    var count: Int { elements.count }

    /// Добавляет элемент. Сложность: O(1).
    mutating func enqueue(_ value: Element, priority: Int) {
        elements.append(QueueElement(value: value, priority: priority))
    }

    /// Извлекает элемент с наибольшим приоритетом. Сложность: O(n).
    mutating func pop() -> Element? {
        guard let maxPriority = elements.map(\.priority).max(),
              let index = elements.firstIndex(where: { $0.priority == maxPriority })
        else {
            return nil
        }

        return elements.remove(at: index).value
    }
}

// var queue = PriorityQueue<String>()
// queue.enqueue("Обычная задача", priority: 1)
// queue.enqueue("Срочная задача", priority: 10)
// queue.pop() // "Срочная задача"
