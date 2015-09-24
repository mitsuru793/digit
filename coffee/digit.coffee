exports = @
class exports.Digit
  @isInteger = (number) ->
    number = Number(number)
    # numberを小数点以下切り捨てても、変わりがない場合は整数である。
    Math.floor(number) is number

  @isDecimal = (number) ->
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

  @padHead = (number, addDigit, padding) ->
    numberString = number.toString()
    # マイナス符号は一旦外してパディングを埋める
    if number < 0
      numberString = numberString.replace('-', '')
    for i in [0...addDigit]
      numberString = padding + numberString
    if number < 0
      numberString = '-' + numberString
    numberString

  @padTail = (number, addDigit, padding) ->
    numberString = number.toString()
    if not numberString.match(/\./)
      numberString += '.'
    for i in [0...addDigit]
      numberString += padding
    numberString

  @alignIntegerPart = (number, maxIntegerDigit, padding) ->
    diffIntDigit = maxIntegerDigit - @getIntegerPart(number)
    if diffIntDigit < 0
      throw new Error("Number is over maxIntegerDigit")
    # マイナス符号は一旦外してパディングを埋める
    @padHead(number, diffIntDigit, padding)

  @alignDecimalPart = (number, maxDecimalDigit, padding) ->
    diffDecimalDigit = maxDecimalDigit - @getDecimalPart(number)
    if diffDecimalDigit <= -1
      base = Math.pow(10, maxDecimalDigit)
      number *= base
      number = Math.round(number)
      number /= base
      diffDecimalDigit = maxDecimalDigit - @getDecimalPart(number)
      # 四捨五入で0になった桁は失われているため補充
      if diffDecimalDigit > 0
        numberString = @padTail(number, diffDecimalDigit, padding)
      else
        numberString = number.toString()
      numberString
    else if diffDecimalDigit >= 1
      numberString = @padTail(number, diffDecimalDigit, padding)
    else
      numberString = number.toString()
    numberString

# TODO paddingのテスト
# TODO numberが0に対応
  # 文字列を返す
  @align = (number, maxIntDigit, intPadding, maxDecimalDigit=0, decimalPadding=0) ->
    integerString = @alignIntegerPart(number, maxIntDigit, intPadding)
    if integerString.match(/\./)
      integerString = integerString.replace(/\..*/, '')
    decimalString = @alignDecimalPart(number, maxDecimalDigit, decimalPadding)
    decimalString = decimalString.replace(/^.*?\./,'.')
    integerString + decimalString
