<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:saft="urn:OECD:StandardAuditFile-Tax:PT_1.01_01"
	xmlns="urn:OECD:StandardAuditFile-Tax:PT_1.03_01"
	>

<xsl:output method="xml" version="1.0" encoding="Windows-1252" indent="yes" omit-xml-declaration="no"/>

<!-- identity template -->
<xsl:template match="@*|node()">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>


<xsl:template match="*">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:element>
	
	<!--AuditFile xmlns="urn:OECD:StandardAuditFile-Tax:PT_1.03_01">
		<xsl:apply-templates select="@*|node()"/>
	</AuditFile-->
</xsl:template>

<xsl:template match="saft:AuditFileVersion">
	<xsl:element name="{local-name()}">1.03_01</xsl:element>
</xsl:template>

<xsl:template match="saft:Invoice">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="saft:InvoiceNo"/>
		<DocumentStatus>
			<InvoiceStatus><xsl:value-of select="saft:InvoiceStatus/text()"/></InvoiceStatus>
			<InvoiceStatusDate><xsl:value-of select="saft:SystemEntryDate/text()"/></InvoiceStatusDate>
			<SourceID>1</SourceID>
			<SourceBilling>P</SourceBilling>
		</DocumentStatus>
		<Hash><xsl:value-of select="saft:Hash/text()"/></Hash>
		<HashControl><xsl:value-of select="saft:HashControl/text()"/></HashControl>
		<xsl:if test="saft:Period">
			<Period><xsl:value-of select="saft:Period/text()"/></Period>
		</xsl:if>
		<InvoiceDate><xsl:value-of select="saft:InvoiceDate/text()"/></InvoiceDate>
		<InvoiceType><xsl:value-of select="saft:InvoiceType/text()"/></InvoiceType>
		<SpecialRegimes>
			<SelfBillingIndicator>0</SelfBillingIndicator>
			<CashVATSchemeIndicator>0</CashVATSchemeIndicator>
			<ThirdPartiesBillingIndicator>0</ThirdPartiesBillingIndicator>
		</SpecialRegimes>
		<SourceID>1</SourceID>
		<SystemEntryDate><xsl:value-of select="saft:SystemEntryDate/text()"/></SystemEntryDate>
		<CustomerID><xsl:value-of select="saft:CustomerID/text()"/></CustomerID>
		<xsl:apply-templates select="saft:Line"/>
		<DocumentTotals>
			<xsl:apply-templates select="saft:DocumentTotals/saft:TaxPayable"/>
			<xsl:apply-templates select="saft:DocumentTotals/saft:NetTotal"/>
			<xsl:apply-templates select="saft:DocumentTotals/saft:GrossTotal"/>
			<xsl:apply-templates select="saft:DocumentTotals/saft:Currency"/>
			<xsl:apply-templates select="saft:DocumentTotals/saft:Settlement"/>
			<xsl:apply-templates select="saft:DocumentTotals/saft:Payment"/>
		</DocumentTotals>
	</xsl:element>
</xsl:template>

<xsl:template match="saft:Line">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="saft:LineNumber"/>
		<xsl:apply-templates select="saft:ProductCode"/>
		<xsl:apply-templates select="saft:ProductDescription"/>
		<xsl:apply-templates select="saft:Quantity"/>
		<xsl:apply-templates select="saft:UnitOfMeasure"/>
		<xsl:apply-templates select="saft:UnitPrice"/>
		<xsl:apply-templates select="saft:TaxPointDate"/>
		<xsl:apply-templates select="saft:References"/>
		<xsl:apply-templates select="saft:Description"/>
		<xsl:apply-templates select="saft:CreditAmount"/>
		<xsl:apply-templates select="saft:DebitAmount"/>
		<xsl:apply-templates select="saft:Tax"/>
		<xsl:apply-templates select="saft:TaxExemptionReason"/>
		<xsl:apply-templates select="saft:SettlementAmount"/>
	</xsl:element>
</xsl:template>


<xsl:template match="saft:References">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="saft:CreditNote/saft:Reference"/>
		<xsl:apply-templates select="saft:CreditNote/saft:Reason"/>
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
