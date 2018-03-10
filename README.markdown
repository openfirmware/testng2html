# TestNG to HTML

Converts TestNG XML reports into HTML documents so they are human readable.

## Usage

The conversion is done using an XSLT file. Different XSLT files will produce different output. Choose the output type that works for you.

### Simple HTML Output

This outputs a single HTML 5 file with embedded CSS information. There is no JavaScript functionality. An example output is in the `examples/simple.html` file.

Here is how to use it with `xsltproc`.

```sh
$ xsltproc simple.xsl input.xml > simple.html
```

### Filtering HTML Output

This outputs a single HTML 5 file with embedded CSS and JavaScript. It links to an internet copy of JQuery to keep the filtering code simplified. An example output is in the `examples/filter.html` file.

Here is how to use it with `xsltproc`.

```sh
$ xsltproc filter.xsl input.xml > filter.html
```

## License

MIT License
