# TestNG to HTML

Converts TestNG XML reports into HTML documents so they are human readable.

## Usage

The conversion is done using an XSLT file. Different XSLT files will produce different output. Choose the output type that works for you.

### Simple HTML Output

This outputs a single HTML 5 file with embedded CSS information. There is no JavaScript functionality.

Here is how to use it with `xsltproc`.

```sh
$ xsltproc testng2html.xsl input.xml < output.html
```

## License

MIT License
