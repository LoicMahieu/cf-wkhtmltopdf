
# cf-wkhtmltopdf

Coldfusion Wrapper for [`wkhtmltopdf`](http://wkhtmltopdf.org/).


## Usage

`.fromX` methods results the binary content of the PDF file. Options are documented by [wkhtmltopdf](http://wkhtmltopdf.org/usage/wkhtmltopdf.txt), there are all supported and must be provided in camelcase.

### .fromString(str[, options])

```cfm
<cfscript>
  wkhtmltopdf = new Wkhtmltopdf();
  pdf = wkhtmltopdf.fromString('<h1>Hello world</h1>');
</cfscript>
<cfcontent type="application/pdf" variable="#pdf#">
```

### .fromURL(urlStr[, options])

```cfm
<cfscript>
  wkhtmltopdf = new Wkhtmltopdf();
  pdf = wkhtmltopdf.fromURL('http://github.com');
</cfscript>
<cfcontent type="application/pdf" variable="#pdf#">
```

### .commandPath

Default: `wkhtmltopdf`
Allow you to specify wkhtmltopdf bin.
