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

        table.test-results {
          width: 100%;
        }

        table.test-results td {
          text-align: right;
        }

        table.test-results col.passed {
          background-color: GreenYellow;
        }

        table.test-results col.failed {
          background-color: LightCoral;
        }

        table.test-results col.skipped {
          background-color: LightYellow;
        }

        table.test-results col.total {
          background-color: LightSteelBlue;
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

        div#result-graph {
          width: 100%;
          height: 3em;
          display: flex;
          margin-bottom: 1em;
          border: 1px solid #AAA;
        }

        div#result-graph * {
          height: 100%;
          margin: 0;
          padding: 0;
        }

        div#result-graph .passed {
          background-color: #EAFDEA;
          width: <xsl:value-of select="100 * testng-results/@passed div testng-results/@total" />%;
        }

        div#result-graph .failed {
          background-color: #FDEAEA;
          width: <xsl:value-of select="100 * testng-results/@failed div testng-results/@total" />%;
        }

        div#result-graph .skipped {
          background-color: #FDFDEA;
          width: <xsl:value-of select="100 * testng-results/@skipped div testng-results/@total" />%;
        }
      </style>
    </head>
  <body>
    <div id="master">
      <h1>TestNG Results</h1>

      <div id="result-graph">
        <div class="passed"></div>
        <div class="failed"></div>
        <div class="skipped"></div>
      </div>

      <table class="test-results">
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
      </xsl:for-each>
    </div>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
