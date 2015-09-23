exports = @
class exports.Digit
  @isInteger = (number) ->
    number = Number(number)
    # numberを小数点以下切り捨てても、変わりがない場合は整数である。
    Math.floor(number) is number

  @isFloat = (number) ->
    not @isInteger(number)

  @removeSymbol = (numberString) ->
    numberString.replace(/[-\+\.]/g, '')

  # 小数点、符号は含まない
  @get = (number) ->
    numberString = number.toString(10)
    numberString = @removeSymbol(numberString)
    digit = numberString.length

  # 整数部分の桁数を求める
  @getIntegerPart = (number) ->
    numberString = Math.floor(number).toString()
    numberString = @removeSymbol(numberString)
    numberString.length

  # 小数点以降の桁数を求める
  @getDecimalPart = (number) ->
    if @isInteger(number)
      return 0
    numberString = number.toString()
    numberString = numberString.match(/(?=.)\d+$/)[0]
    numberString.length

  @alignIntegerPart = (number, padding, maxDigit) ->
    intDigit = @getIntegerPart(number)
    diffIntDigit = maxDigit - intDigit
    if diffIntDigit < 0
      throw new Error("Number is over maxDigit")
    numberString = number.toString()
    # マイナス符号は一旦外してパディングを埋める
    if number < 0
      numberString = numberString.replace('-', '')
    for i in [0...diffIntDigit]
      numberString = padding + numberString
    if number < 0
      numberString = '-' + numberString
    numberString

# TODO paddingのテスト
# TODO numberが0に対応
  # 文字列を返す
  @align = (number, intPadding, maxIntDigit, maxDecimalDigit=0, decimalPadding=0) ->
    numberString = number.toString()

    intDigit = @getIntegerPart(number)
    diffIntDigit = maxIntDigit - intDigit
    # マイナス符号は一旦外してパディングを埋める
    if number < 0
      numberString = numberString.replace('-', '')
    for i in [0...diffIntDigit]
      numberString = intPadding + numberString
    if number < 0
      numberString = '-' + numberString
    return numberString if @isInteger(number) && maxDecimalDigit is 0
    numberString += '.' if @getDecimalPart(number) is 0

    floatDigit = @getDecimalPart(number)
    diffFloatDigit = maxDecimalDigit - floatDigit
    if diffFloatDigit <= -1
      base = 10 ^ Math.abs(diffFloatDigit)
      numberString *= base
      Math.round(numberString)
      numberString /= base
    else if diffFloatDigit >= 1
      for i in [0...diffFloatDigit]
        numberString += decimalPadding
      numberString
    else
      numberString
