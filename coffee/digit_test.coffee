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

  describe '#isFloat', ->
    it 'reutns true when number is not float', ->
      for num in [+100, 15.0, 1, 0, 0.0, -0.0, -0, -1, -5.0, -132]
        actual = Digit.isFloat(num)
        expect(actual).toBe(false, num)

    it 'reutns false when number is float', ->
      for num in [+15.3, 1.7, 0.01, -0.1, -2.3]
        actual = Digit.isFloat(num)
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

  describe '#getFromInteger', ->
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
        actual = Digit.getFromInteger(pattern[0])
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
        actual = Digit.getFromInteger(pattern[0])
        expect(actual).toBe(pattern[1], pattern)

  describe '#getFromFloat', ->
    it 'get a digit of decimal part of number', ->
      patterns = [
        [100.12, 2]
        [+34.1, 1]
        [0.457, 3]
        [-0.8, 1]
        [-100.12345, 5]
      ]
      for pattern in patterns
        actual = Digit.getFromFloat(pattern[0])
        expect(actual).toBe(pattern[1], pattern)
      for num in [100, +34, 1, +0, 0, -0, -5, -85]
        actual = Digit.getFromFloat(num)
        expect(actual).toBe(0, num)

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
        [-100.12345, '-00100.12345']
      ]
      for pattern in patterns
        actual = Digit.align(pattern[0], padding, maxIntDigit, maxFloatDigit)
        expect(actual).toBe(pattern[1], pattern)
