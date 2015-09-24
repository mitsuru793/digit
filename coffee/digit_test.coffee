describe 'mainTest', ->
  describe '#isInteger', ->
    it 'returns true when number is integer', ->
      for num in [+100, 15.0, 1, 0, 0.0, -0.0, -0, -1, -5.0, -132]
        actual = Digit.isInteger(num)
        expect(actual).toBe(true, num)

    it 'returns false when number is not integer', ->
      for num in [+15.3, 1.7, 0.01, -0.1, -2.3]
        actual = Digit.isInteger(num)
        expect(actual).toBe(false, num)

  describe '#isDecimal', ->
    it 'reutns true when number is not float', ->
      for num in [+100, 15.0, 1, 0, 0.0, -0.0, -0, -1, -5.0, -132]
        actual = Digit.isDecimal(num)
        expect(actual).toBe(false, num)

    it 'reutns false when number is float', ->
      for num in [+15.3, 1.7, 0.01, -0.1, -2.3]
        actual = Digit.isDecimal(num)
        expect(actual).toBe(true, num)

  describe '#removeSymbol', ->
    it 'removes symbols of plus and minus and dot', ->
      # [input, expected]
      patterns = [
        ['100', '100']
        ['+34.0', '340']
        ['0', '0']
        ['0.0', '00']
        ['-0', '0']
        ['-0.5', '05']
        ['-100.4', '1004']
      ]
      for pattern in patterns
        actual = Digit.removeSymbol(pattern[0])
        expect(actual).toBe(pattern[1], pattern)

  describe '#get', ->
    it 'get a digit of number', ->
      # [input, expected]
      patterns = [
        [100, 3]
        [+34.0, 2]
        [0, 1]
        [0.0, 1]
        [-0, 1]
        [-0.5, 2]
        [-100.4, 4]
      ]
      for pattern in patterns
        actual = Digit.get(pattern[0])
        expect(actual).toBe(pattern[1], pattern)

  describe '#getIntegerPart', ->
    it 'get a digit of integer part of number', ->
      # [input, expected]
      patterns = [
        [100, 3]
        [+34.0, 2]
        [0, 1]
        [0.0, 1]
        [-0, 1]
        [-0.5, 1]
        [-100.4, 3]
      ]
      for pattern in patterns
        actual = Digit.getIntegerPart(pattern[0])
        expect(actual).toBe(pattern[1], pattern)

      # [input, expected]
      patterns = [
        [100.01, 3]
        [+34.03, 2]
        [+0.123, 1]
        [0.03, 1]
        [-0.2, 1]
        [-0.5, 1]
        [-100.4, 3]
      ]
      for pattern  in patterns
        actual = Digit.getIntegerPart(pattern[0])
        expect(actual).toBe(pattern[1], pattern)

  describe '#getDecimalPart', ->
    it 'get a digit of decimal part of number', ->
      patterns = [
        [100.12, 2]
        [+34.1, 1]
        [0.457, 3]
        [-0.8, 1]
        [-1.85, 2]
        [-100.12345, 5]
      ]
      for pattern in patterns
        actual = Digit.getDecimalPart(pattern[0])
        expect(actual).toBe(pattern[1], pattern)
      for num in [100, +34, 1, +0, 0, -0, -5, -85]
        actual = Digit.getDecimalPart(num)
        expect(actual).toBe(0, num)

  describe '#padHead', ->
    it 'returns number string padding head with minus symbol in mind', ->
      padding = '0'
      addDigit = 2
      patterns = [
        [100.12, '00100.12']
        [+34.1, '0034.1']
        [33, '0033']
        [0, '000']
        [0.4577, '000.4577']
        [-0.8, '-000.8']
        [-100.1234, '-00100.1234']
      ]
      for pattern in patterns
        actual = Digit.padHead(pattern[0], addDigit, padding)
        expect(actual).toBe(pattern[1], pattern)
        expect(actual).toEqual(jasmine.any(String), pattern)

  describe '#padTail', ->
    it 'returns number string padding tail with deciaml in mind', ->
      padding = '0'
      addDigit = 2
      patterns = [
        [100.12, '100.1200']
        [+34.1, '34.100']
        [33, '33.00']
        [0, '0.00']
        [0.4577, '0.457700']
        [-0.8, '-0.800']
        [-100.1234, '-100.123400']
      ]
      for pattern in patterns
        actual = Digit.padTail(pattern[0], addDigit, padding)
        expect(actual).toBe(pattern[1], pattern)
        expect(actual).toEqual(jasmine.any(String), pattern)

  describe '#alignIntegerPart', ->
    it 'returns number string aligned in integer part by padding', ->
      padding = '0'
      maxIntDigit = 5
      patterns = [
        [100.12, '00100.12']
        [+34.1, '00034.1']
        [33, '00033']
        [0, '00000']
        [0.4577, '00000.4577']
        [-0.8, '-00000.8']
        [-100.1234, '-00100.1234']
      ]
      for pattern in patterns
        actual = Digit.alignIntegerPart(pattern[0], maxIntDigit, padding)
        expect(actual).toBe(pattern[1], pattern)
        expect(actual).toEqual(jasmine.any(String), pattern)
    describe 'when number is over maxIntegerDigit', ->
      it 'returns error object', ->
        padding = '0'
        maxIntDigit = 2
        patterns = [
          100.12
          +12334.1
          -12040.8
        ]
        for pattern in patterns
          expect(-> Digit.alignIntegerPart(pattern, maxIntDigit, padding))
            .toThrow(new Error('Number is over maxIntegerDigit'))

  describe '#alignDecimalPart', ->
    describe '#context', ->
    it 'returns number string aligned in decimal part by padding and rounding', ->
      padding = '0'
      maxDecimalDigit = 3
      patterns = [
        [100.12, '100.120']
        [+34.1124, '34.112']
        [33, '33.000']
        [0, '0.000']
        [-1.787, '-1.787']
        [-1.7999, '-1.800']
        [-1.9999, '-2.000']
      ]
      for pattern in patterns
        actual = Digit.alignDecimalPart(pattern[0], maxDecimalDigit, padding)
        expect(actual).toBe(pattern[1], pattern)
        expect(actual).toEqual(jasmine.any(String), pattern)

  describe '#align', ->
    it 'alings digit by padding for display', ->
      padding = '0'
      maxIntDigit = 5
      maxFloatDigit = 4
      patterns = [
        [100.12, '00100.1200']
        [+34.1, '00034.1000']
        [33, '00033.0000']
        [0, '00000.0000']
        [0.4577, '00000.4577']
        [-0.8, '-00000.8000']
        [-100.1234, '-00100.1234']
      ]
      for pattern in patterns
        actual = Digit.align(pattern[0], maxIntDigit, padding, maxFloatDigit)
        expect(actual).toBe(pattern[1], pattern)
        expect(actual).toEqual(jasmine.any(String), pattern)
    describe 'when option decimal digit is over', ->
      it 'rounds over decimal', ->
        padding = '0'
        maxIntDigit = 3
        maxFloatDigit = 2
        patterns = [
          [100.123, '100.12']
          [+34.138, '00034.14']
          [33, '033.00']
        ]
        for pattern in patterns
          expect(-> Digit.align(pattern[0], padding, maxIntDigit, maxFloatDigit))
            .toThrow(new Error('Number is over maxIntegerDigit'))
