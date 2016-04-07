# Digit-js
数字を桁揃えできるライブラリです。数値に整数部分、小数部分にそれぞれに、任意の文字でパディングをすることができます。bowerで公開しています。下記はテストコードです。

```coffee
describe '#align', ->
  it 'alings digit by padding for display', ->
    padding = '0'
    maxIntDigit = 5
    maxDecimalDigit = 4
    # 加工する数値、返り値の数字
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
      actual = Digit.align(pattern[0], maxIntDigit, padding, maxDecimalDigit)
      expect(actual).toBe(pattern[1], pattern)
      expect(actual).toEqual(jasmine.any(String), pattern)
```
