describe 'mainTest', ->
  it 'isInteger', ->
    for num in [+100, 15.0, 1, 0, 0.0, -0.0, -0, -1, -5.0, -132]
      actual = Digit.isInteger(num)
      expect(actual).toBe(true, num)

    for num in [+15.3, 1.7, 0.01, -0.1, -2.3]
      actual = Digit.isInteger(num)
      expect(actual).toBe(false, num)

  it 'isFloat', ->
    for num in [+100, 15.0, 1, 0, 0.0, -0.0, -0, -1, -5.0, -132]
      actual = Digit.isFloat(num)
      expect(actual).toBe(false, num)

    for num in [+15.3, 1.7, 0.01, -0.1, -2.3]
      actual = Digit.isFloat(num)
      expect(actual).toBe(true, num)

  it 'removeSymbolTest', ->
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

  it 'getDigitTest', ->
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
      actual = Digit.getDigit(pattern[0])
      expect(actual).toBe(pattern[1], pattern)

  it 'getDigitIntTest', ->
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
      actual = Digit.getDigitInt(pattern[0])
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
      actual = Digit.getDigitInt(pattern[0])
      expect(actual).toBe(pattern[1], pattern)

  it 'getDigitFloat', ->
    patterns = [
      [100.12, 2]
      [+34.1, 1]
      [0.457, 3]
      [-0.8, 1]
      [-100.12345, 5]
    ]
    for pattern in patterns
      actual = Digit.getDigitFloat(pattern[0])
      expect(actual).toBe(pattern[1], pattern)
    for num in [100, +34, 1, +0, 0, -0, -5, -85]
      actual = Digit.getDigitFloat(num)
      expect(actual).toBe(0, num)

  it 'paddingDigit', ->
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
      actual = Digit.paddingDigit(pattern[0], padding, maxIntDigit, maxFloatDigit)
      expect(actual).toBe(pattern[1], pattern)
