<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" indent="yes" />
<xsl:template match="/">
  <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
  <html>
    <head>
      <title>TestNG Results</title>
      <style>
        body {
          background-color: #999;
        }

        h1, h2, h3, h4, h5, h6 {
          font-family: sans-serif;
        }

        body > div {
          margin: 0 auto;
          max-width: 960px;
          background-color: #FFF;
          padding: 1em;
        }

        table {
          border-spacing: 0;
          border: 0;
        }

        table th, table td {
          padding: 0.2em 0.5em;
        }

        table.suite-results {
          width: 100%;
        }

        table.suite-results td {
          text-align: right;
        }

        table.suite-results th, table.suite-results td {
          cursor: pointer;
        }

        table.suite-results col.passed {
          background-color: GreenYellow;
        }

        table.suite-results col.failed {
          background-color: LightCoral;
        }

        table.suite-results col.skipped {
          background-color: LightYellow;
        }

        table.suite-results col.total {
          background-color: LightSteelBlue;
        }

        table.suite-results col.mute {
          background-color: LightGray;
        }

        table.timings {
          font-size: 0.8em;
          width: 50%;
        }

        table.timings td {
          text-align: right;
        }

        div.test {
          padding: 1em;
          background-color: #EEE;
          border-bottom: 1px solid #000;
        }

        div.test-class {
          padding: 1em;
          margin-bottom: 1em;
          background-color: #FAFAFA;
          border-bottom: 1px solid #000;
        }

        div.test-method {
          padding: 1em;
          margin-bottom: 1em;
          background-color: #FDFDFD;
          border-bottom: 1px solid #000;
        }

        div.test-method.PASS {
          background-color: #EAFDEA;
        }

        div.test-method.FAIL {
          background-color: #FDEAEA;
        }

        div.test-method.SKIP {
          background-color: #FDFDEA;
        }

        .signature {
          font-size: 0.8em;
          font-family: monospace;
          color: #555;
        }

        table.parameters td {
          font-family: monospace;
        }

        div.exception {
          margin: 1em 0;
          padding: 1em;
          border: 3px solid red;
        }

        .exception-class {
          font-family: monospace;
        }

        div.hidden-results > * {
          display: none;
        }

        div.hidden-results::after {
          content: "Results Hidden";
          font-style: italic;
        }
      </style>
    </head>
  <body>
    <div id="master">
      <h1>TestNG Results</h1>
      <p><em>Select a category to filter those tests.</em></p>
      <table class="suite-results">
        <colgroup>
          <col class="passed" />
          <col class="failed" />
          <col class="skipped" />
          <col class="total" />
        </colgroup>
        <thead>
          <tr>
            <th>Passed</th>
            <th>Failed</th>
            <th>Skipped</th>
            <th>Total</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><xsl:value-of select="testng-results/@passed" /></td>
            <td><xsl:value-of select="testng-results/@failed" /></td>
            <td><xsl:value-of select="testng-results/@skipped" /></td>
            <td><xsl:value-of select="testng-results/@total" /></td>
          </tr>
        </tbody>
      </table>
    </div>

    <div id="suite">
      <h2>Suite: <xsl:value-of select="testng-results/suite/@name" /></h2>

      <table class="timings">
        <thead>
          <tr>
            <th>Duration</th>
            <th>Start Time</th>
            <th>Finish Time</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><xsl:value-of select="testng-results/suite/@duration-ms" /> ms</td>
            <td><xsl:value-of select="testng-results/suite/@started-at" /></td>
            <td><xsl:value-of select="testng-results/suite/@finished-at" /></td>
          </tr>
        </tbody>
      </table>
    </div>

    <div id="tests">
      <xsl:for-each select="testng-results/suite/test">
        <div class="test">
          <h3>Test: <xsl:value-of select="@name" /></h3>

          <xsl:variable name="resultcount"><xsl:value-of select="count(class)" /></xsl:variable>
          <div class="test-results results{$resultcount}">
            <table class="timings">
              <thead>
                <tr>
                  <th>Duration</th>
                  <th>Start Time</th>
                  <th>Finish Time</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><xsl:value-of select="@duration-ms" /> ms</td>
                  <td><xsl:value-of select="@started-at" /></td>
                  <td><xsl:value-of select="@finished-at" /></td>
                </tr>
              </tbody>
            </table>

            <h4>Test Classes</h4>

            <xsl:choose>
              <xsl:when test="count(class) = 0">
                <p><em>No test classes applied in this run.</em></p>
              </xsl:when>

              <xsl:otherwise>
                <xsl:for-each select="class">
                  <div class="test-class">
                    <h4><xsl:value-of select="@name" /></h4>

                    <xsl:choose>
                      <xsl:when test="count(test-method) = 0">
                        <p><em>No test methods applied in this run.</em></p>
                      </xsl:when>

                      <xsl:otherwise>
                        <xsl:for-each select="test-method">
                          <xsl:variable name="status"><xsl:value-of select="@status" /></xsl:variable>

                          <div class="test-method {$status}">
                            <h5><xsl:value-of select="@name" />: <xsl:value-of select="@status" /></h5>
                            <p class="signature">Signature: <xsl:value-of select="@signature" /></p>

                            <!-- Timings -->
                            <table class="timings">
                              <thead>
                                <tr>
                                  <th>Duration</th>
                                  <th>Start Time</th>
                                  <th>Finish Time</th>
                                </tr>
                              </thead>
                              <tbody>
                                <tr>
                                  <td><xsl:value-of select="@duration-ms" /> ms</td>
                                  <td><xsl:value-of select="@started-at" /></td>
                                  <td><xsl:value-of select="@finished-at" /></td>
                                </tr>
                              </tbody>
                            </table>

                            <!-- Parameters -->
                            <xsl:choose>
                              <xsl:when test="count(params/param) = 0">
                                <p><em>No parameters for test method.</em></p>
                              </xsl:when>

                              <xsl:otherwise>
                                <table class="parameters">
                                  <thead>
                                    <tr>
                                      <th>Parameters</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                    <xsl:for-each select="params/param">
                                      <tr>
                                        <td><xsl:value-of select="value" /></td>
                                      </tr>
                                    </xsl:for-each>
                                  </tbody>
                                </table>
                              </xsl:otherwise>
                            </xsl:choose>

                            <!-- Exceptions -->
                            <xsl:if test="count(exception) > 0">
                              <div class="exception">
                                <h4>EXCEPTION</h4>
                                <p class="exception-class"><xsl:value-of select="exception/@class" /></p>
                                <pre><xsl:value-of select="exception/message" /></pre>
                              </div>
                            </xsl:if>
                          </div>
                        </xsl:for-each>
                      </xsl:otherwise>
                    </xsl:choose>
                  </div>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </xsl:for-each>
    </div>
  </body>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E=" crossorigin="anonymous"></script>
  <script>
    var table = $("table.suite-results");
    var headers = table.find('th');
    var cells = table.find('td');

    function filterByType(type) {
      switch(type) {
        case 'PASS':
          $('.PASS').removeClass('hidden-results');
          $('.results0, .FAIL, .SKIP').addClass('hidden-results');
          table.find('.passed').removeClass('mute');
          table.find('.failed, .skipped, .total').addClass('mute');
        break;
        case 'FAIL':
          $('.FAIL').removeClass('hidden-results');
          $('.results0, .PASS, .SKIP').addClass('hidden-results');
          table.find('.failed').removeClass('mute');
          table.find('.passed, .skipped, .total').addClass('mute');
        break;
        case 'SKIP':
          $('.SKIP').removeClass('hidden-results');
          $('.results0, .FAIL, .PASS').addClass('hidden-results');
          table.find('.skipped').removeClass('mute');
          table.find('.failed, .passed, .total').addClass('mute');
        break;
        case 'ALL':
        default:
          $('.results0, .PASS, .FAIL, .SKIP').removeClass('hidden-results');
          table.find('.passed, .failed, .passed, .total').removeClass('mute');
      }
    }

    headers[0].addEventListener('click', function() { filterByType('PASS'); });
    cells[0].addEventListener('click', function() { filterByType('PASS'); });

    headers[1].addEventListener('click', function() { filterByType('FAIL'); });
    cells[1].addEventListener('click', function() { filterByType('FAIL'); });

    headers[2].addEventListener('click', function() { filterByType('SKIP'); });
    cells[2].addEventListener('click', function() { filterByType('SKIP'); });

    headers[3].addEventListener('click', function() { filterByType('ALL'); });
    cells[3].addEventListener('click', function() { filterByType('ALL'); });
  </script>
  </html>
</xsl:template>
</xsl:stylesheet>
