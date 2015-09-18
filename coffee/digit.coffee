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
  @getDigit = (number) ->
    numberString = number.toString(10)
    numberString = @removeSymbol(numberString)
    digit = numberString.length

  # 整数部分の桁数を求める
  @getFromIntger = (number) ->
    numberString = Math.floor(number).toString()
    numberString = @removeSymbol(numberString)
    numberString.length

  # 小数点以降の桁数を求める
  @getFromFloat = (number) ->
    if @isInteger(number)
      return 0
    numberString = number.toString()
    numberString = numberString.match(/(?=.)\d+$/)[0]
    numberString.length

# TODO paddingのテスト
# TODO numberが0に対応
  # 文字列を返す
  @align = (number, intPadding, maxIntDigit, maxFloatDigit=0, floatPadding=0) ->
    numberString = number.toString()

    intDigit = @getFromIntger(number)
    diffIntDigit = maxIntDigit - intDigit
    # マイナス符号は一旦外してパディングを埋める
    if number < 0
      numberString = numberString.replace('-', '')
    for i in [0...diffIntDigit]
      numberString = intPadding + numberString
    if number < 0
      numberString = '-' + numberString
    return numberString if @isInteger(number) && maxFloatDigit is 0
    numberString += '.' if @getFromFloat(number) is 0

    floatDigit = @getFromFloat(number)
    diffFloatDigit = maxFloatDigit - floatDigit
    return numberString if diffFloatDigit < 1
    for i in [0...diffFloatDigit]
      numberString += floatPadding
    numberString
