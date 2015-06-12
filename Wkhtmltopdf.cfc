/**
* @output false
*/
component {

  // http://fedir.github.io/web/blog/2013/09/25/install-wkhtmltopdf-on-ubuntu/
  // Inspiration: https://github.com/devongovett/node-wkhtmltopdf/blob/master/index.js

  this.commandPath = 'wkhtmltopdf';

  public function init() {
    return this;
  }

  public function fromString(
    required string str,
    struct options = {},
    string charset = 'UTF-8'
  ) {
    var tmpFile = _tmpFile();
    var args = ['--quiet'];
    args.addAll(_optionsToArray(options));
    args.addAll([
      '-',
      tmpFile
    ]);
    var p = _exec(this.commandPath, args);

    var output = p.getOutputStream();
    output.write(str.getBytes(charset));
    output.close();

    p.waitFor();

    if (p.exitValue() == 0) {
      return FileReadBinary(tmpFile);
    } else {
      return _handleProcessError(p, this.commandPath, args);
    }
  }

  public function fromURL(required string urlStr, struct options = {}) {
    var tmpFile = _tmpFile();
    var args = ['--quiet'];
    args.addAll(_optionsToArray(options));
    args.addAll([
      urlStr,
      tmpFile
    ]);
    var p = _exec(this.commandPath, args);

    p.waitFor();

    if (p.exitValue() == 0) {
      return FileReadBinary(tmpFile);
    } else {
      return _handleProcessError(p, this.commandPath, args);
    }
  }

  // --- privates

  private function _flattenArray() {
    var res = [];
    var keys = structKeyArray(arguments);

    for (var i = 1; i <= arrayLen(keys); i++) {
      var key = keys[i];
      var val = arguments[key];

      res = res.addAll(val);
    }

    return;


  }

  private function _optionsToArray(required struct options) {
    var res = [];
    var keys = structKeyArray(options);

    for (var i = 1; i <= arrayLen(keys); i++) {
      var key = keys[i];
      var val = options[key];

      if (len(key) == 1) {
        key = '-' & key;
      } else {
        key = '--' & _dasherize(key);
      }

      if (isBoolean(val) && val != false) {
        res.add(key);
      } else {
        res.add(key & ' ' & _quote(val));
      }
    }

    return res;
  }

  private function _quote(required string val) {
    // escape and quote the value if it is a string and this isn't windows
    if (server.os.name != 'UNIX') {
      val = reReplace(val, '(["\\$`])', '\\\1', 'all');
    }
    return val;
  }

  private function _dasherize(required string input) {
    return lCase(
      reReplace(
        reReplace(input, '\W+', '-', 'all'),
        '([a-z\d])([A-Z])',
        '\1-\2',
        'all'
      )
    );
  }

  private function _tmpFile() {
    return getTempFile(getTempDirectory(), 'wkhtmltopdf');
  }

  private function _handleProcessError(required any process, required string command, required array args) {
    var IOUtils = createObject('java', 'org.apache.commons.io.IOUtils');
    var error = process.getErrorStream();
    var fullCommand = _fullCommand(command, args);

    var message = [
      'wkhtmltopdf has fail.',
      'Command: `#fullCommand#`',
      'Exit code: `#process.exitValue()#`',
      'Message: `#IOUtils.toString(error)#`'
    ];


    throw(arrayToList(message, ' - '));
  }

  private function _exec(required string name, required array args) {
    var command = _fullCommand(name, args);
    var runtime = createObject('java', 'java.lang.Runtime').getRuntime();
    var p = runtime.exec(command);

    return p;
  }

  private function _fullCommand(required string name, array args = []) {
    return name & ' ' & arrayToList(args, ' ');
  }

}
