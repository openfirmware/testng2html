<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
    <head>
      <title>TestNG Results</title>
      <style>
        table.timings {
          font-size: 0.8em;
        }

        .signature {
          font-size: 0.8em;
          color: #555;
        }
      </style>
    </head>
  <body>
    <div id="master">
      <h1>TestNG Results</h1>
      <table>
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
            <td><xsl:value-of select="testng-results/@skipped" /></td>
            <td><xsl:value-of select="testng-results/@failed" /></td>
            <td><xsl:value-of select="testng-results/@passed" /></td>
            <td><xsl:value-of select="testng-results/@total" /></td>
          </tr>
        </tbody>
      </table>
    </div>

    <div id="suite">
      <h3>Suite: <xsl:value-of select="testng-results/suite/@name" /></h3>

      <h4>Table: Suite Details</h4>
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

          <h4>Table: Test Details</h4>
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
              <p>No test classes applied in this run.</p>
            </xsl:when>

            <xsl:otherwise>
              <xsl:for-each select="class">
                <div class="test-class">
                  <h4><xsl:value-of select="@name" /></h4>

                  <xsl:choose>
                    <xsl:when test="count(test-method) = 0">
                      <p>No test methods applied in this run.</p>
                    </xsl:when>

                    <xsl:otherwise>
                      <xsl:for-each select="test-method">
                        <div class="test-method">
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
                              <p>No parameters for test method.</p>
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
                            <h4>EXCEPTION</h4>
                            <p><xsl:value-of select="exception/@class" /></p>
                            <p><xsl:value-of select="exception/message" /></p>
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
