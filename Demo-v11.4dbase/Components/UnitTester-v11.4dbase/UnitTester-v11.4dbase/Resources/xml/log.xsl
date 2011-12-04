<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:variable name="pass">ok</xsl:variable>
    <xsl:template match="/">
        <html>
            <style>
                body {font-family: arial;}
                h2 {color: white; text-align: center}
                h3 {background: #41454f; color: white; text-align: center; margin-bottom: 0;}
                ul {list-style-type: none;}
                ul.test_case {padding-left: 0;}
                .pass {color: green; font-weight: bold;}
                .fail {color: red; font-weight: bold;}
                .test_case {font-size: 14px;}
                .fail_bkg {background-color: MistyRose;}
                .test_case_method {font-family: courier; font-weight: bold; font-style: italic;} 
                li.test_case {padding: 2px 0; margin: 0; border-top: thin grey solid;}
                .custom {font-family: courier;}
                .test {color: navy; font-size: 12px;}
                .assertion {color: black; font-size: 12px;}
                table {font-family: courier; font-size: 12px; border: grey solid thin; border-collapse: collapse;}
                table caption {font-family: arial; font-weight: bold;}
                td, th {border: grey solid thin; padding: 3px;}
                th {background: Gainsboro ;}
            </style>
            <script type="text/javascript"><![CDATA[
                function detailToggle(obj) {
                    var children = obj.parentNode.childNodes;
                    var hide = (obj.innerText == "hide details");
                    for(var i in children) {
                        child = children[i];
                        if(child.tagName == "UL"){
                            child.style.display = hide ? "none" : "block";
                        } 
                    }
                    obj.innerText = hide ? "show details" : "hide details";
                    return false;
                }]]>
            </script>
            <body>
                <xsl:apply-templates select="test_run"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="test_run">
        <xsl:choose>
            <xsl:when test="@pass='true'">
                <h2 style="background-color: green;">UnitTester Test Run - PASSED</h2>
            </xsl:when>
            <xsl:otherwise>
                <h2 style="background-color: red;">UnitTester Test Run - FAILED</h2>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="summaries">
        <table>
            <caption>Test Run Duration</caption>
            <tr><td>Started</td><td><xsl:value-of select="@start" /></td></tr>
            <tr><td>Finished</td><td><xsl:value-of select="@finish" /></td></tr>
            <tr><td>Elapsed</td><td><xsl:value-of select="@elapsed" /></td></tr>
        </table>
        <p></p>
        <table>
            <caption>Test Results Summary</caption>
            <tr>
                <th>Test Level</th>
                <th>Count</th>
                <th class="pass">Passed</th>
                <th class="fail">Failed</th>
                <th>% Passed</th>
            </tr>
            
            <xsl:apply-templates select="summary"/>
        </table>
        
    </xsl:template>
    
    <xsl:template match="summary">
        <tr>
            <td><xsl:value-of select="@name" /></td>
            <td><xsl:value-of select="@count" /></td>
            <td class="pass"><xsl:value-of select="@passed" /></td>
            <td class="fail"><xsl:value-of select="@failed" /></td>
            <xsl:choose>
                <xsl:when test="@percent_passed=100.0">
                    <td class="pass"><xsl:value-of select="@percent_passed" /></td>
                </xsl:when>
                <xsl:otherwise>
                    <td class="fail"><xsl:value-of select="@percent_passed" /></td>
                </xsl:otherwise>
            </xsl:choose>
            
        </tr>
    </xsl:template>
    
    <xsl:template match="test_cases">
        <h3>Test Results Detail</h3>
        <ul class="test_case">
            <xsl:apply-templates select="test_case"/>
        </ul>
    </xsl:template>
    
    <xsl:template match="test_case">
        <xsl:choose>
            <xsl:when test="@pass='false'">
                <li class="test_case fail_bkg"><span class="fail">X</span> : <span class="test_case_method"><xsl:value-of select="@name"/></span> - <a href="#" onclick="return detailToggle(this);">hide details</a>
                    <ul>
                        <xsl:apply-templates select="user_data"/>
                        <xsl:apply-templates select="tests"/>
                    </ul>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li class="test_case"><span class="pass"><xsl:value-of select="$pass"/></span> : <span class="test_case_method"><xsl:value-of select="@name"/></span> - <a href="#" onclick="return detailToggle(this);">show details</a>
                    <ul style="display: none;">
                        <xsl:apply-templates select="user_data"/>
                        <xsl:apply-templates select="tests"/>
                    </ul>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="user_data">
        <li class="custom"><xsl:value-of select="."/></li>
    </xsl:template>
    
    <xsl:template match="tests">
        <xsl:apply-templates select="test" />
    </xsl:template>
    
    <xsl:template match="test">
        <xsl:choose>
            <xsl:when test="@pass='false'">
                <li><span class="fail">X</span> - <span class="test"><xsl:value-of select="@name"/></span>
                    <xsl:apply-templates select="assertions" />
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li><span class="pass"><xsl:value-of select="$pass"/></span> - <span class="test"><xsl:value-of select="@name"/></span></li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="assertions">
        <ul>
            <xsl:apply-templates select="assertion" />
        </ul>
    </xsl:template>
    
    <xsl:template match="assertion">
        <li><span class="assertion"><xsl:value-of select="."/></span></li>
    </xsl:template>
    
</xsl:stylesheet>