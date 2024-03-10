import BigInt
import Numerics

public extension BigDecimal {
    @inlinable
    init<T>(_ source: T) where T: BinaryInteger {
        self.init(integerValue: BigInt(source), scale: 0)
    }

    @inlinable
    init?<T>(_ source: T) where T: BinaryFloatingPoint, T: CustomStringConvertible {
        self.init(source.description)
    }
}

public extension BinaryInteger {
    @inlinable
    init(_ source: BigDecimal) {
        self.init(source.withScale(0).integerValue)
    }

    @inlinable
    init?(exactly source: BigDecimal) {
        guard let doubleValue = Double(exactly: source) else {
            return nil
        }

        self.init(exactly: doubleValue)
    }
}

public extension Float {
    @inlinable
    init?(exactly source: BigDecimal) {
        guard let value = Self(exactly: source.integerValue).map({ $0 * .pow(10, -source.scale) }) else {
            return nil
        }

        self = value
    }
}

public extension Double {
    @inlinable
    init?(exactly source: BigDecimal) {
        guard let value = Self(exactly: source.integerValue).map({ $0 * .pow(10, -source.scale) }) else {
            return nil
        }

        self = value
    }
}

#if (arch(i386) || arch(x86_64)) && !os(Windows) && !os(Android)
    public extension Float80 {
        @inlinable
        init?(exactly source: BigDecimal) {
            guard let value = Self(exactly: source.integerValue).map({ $0 * .pow(10, -source.scale) }) else {
                return nil
            }

            self = value
        }
    }
#endif
