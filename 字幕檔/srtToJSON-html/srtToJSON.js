/**********************************************************
 * @author Gabriel
 * @version 0.0.2
 * @license DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 **********************************************************
 * @param {string} content The .srt file content
 * @returns {string} The SRT file content converted to JSON
 *********************************************************/
(function() {
  window.srtToJSON = parseSRT;
  function parseSRT(content) {
    var quotesArray = [];
    var lines = content.split('\r\n');
    var currentQuoteNumber = 0;
    var lineTypes = {
      INDEX : 0,
      TIMECODE: 1,
      TEXT: 2
    };
    var nextLineType = lineTypes.INDEX;


    for(var n in lines) {
      var line = lines[n].toString();
      var quoteNumber = parseInt(line, 10);

      if (line == '') nextLineType = lineTypes.INDEX;
      else if (nextLineType == lineTypes.INDEX && quoteNumber !== NaN) {
          currentQuoteNumber = quoteNumber;
          var quote = {
            startTime  : '',
            endTime    : '',
            text        : ''
          };
          quotesArray[currentQuoteNumber] = quote;
          nextLineType = lineTypes.TIMECODE;
      } else if (nextLineType == lineTypes.TIMECODE) {
        var timeCode = line.split(' --> ');
        quotesArray[currentQuoteNumber].startTime  = timeCode[0];
        quotesArray[currentQuoteNumber].endTime    = timeCode[1];
        nextLineType = lineTypes.TEXT;
      } else if (nextLineType == lineTypes.TEXT) {
        if (quotesArray[currentQuoteNumber].text != '') {
          quotesArray[currentQuoteNumber].text += '\n';
        }
        quotesArray[currentQuoteNumber].text += line;
      }
    }
    return JSON.stringify(quotesArray.filter(function(q){return (q != null);}));
  }
})();
