function md2Toc() {
  var htmlOut = document.getElementById("html_output");
  var textOut = document.getElementById("text_output");
  var input = document.getElementById("input").value;
  var input_array = input.split("\n");
  var counter = [0,0,0,0,0,0];
  var options = document.getElementById("options");
  textOut.value = "";
  htmlOut.innerHTML = "";
  // var input = "# A heading\n## A subheading\n## Another subheading\n### A subsubheading\n# Another heading\n# Yet another heading\n\nSome text";

  if (options.zero.checked) {
    counter = [-1,0,0,0,0,0];
  }

  for(var i=0;i < input_array.length;i++) {
    var hashcheck = /^#/;
    var line = input_array[i];
    var title = "";
    if (hashcheck.test(line)) {
      title = line.replace(/^#+\s+/, "");
      var x = (line.match(/#/g) || []).length;

      depth = options.maxdepth.value;

      if ( x > depth || x < 1) { continue }
      counter[x-1]++;
      for(var a=x;a < counter.length;a++) {
        counter[a] = 0;
      }
      var printCounter = counter.slice();

      s = printCounter.length;
      while (s-- && s>0) {
        if (printCounter[s] == 0) {
          printCounter.splice(s, 1);
        }
      }

      var indent = Array(x).join(" ");

      if (options.noindent.checked) {
        indent = Array(x).join("");
      } else if (options.markdown.checked) {
        indent = Array(x).join("  ");
      }

      var href = title.replace(/ /g, "-").replace(/(?! |-)[\W]/g, "").toLowerCase();

      if (options.nolinks.checked) {
        linkBullets = "* " + title + "\n";
        linkNobullets = "* " + printCounter.join(".") + " " + title + "\n";
      } else {
        linkBullets = "* [" + title + "](#" + href + ")\n";
        linkNobullets = "* [" + printCounter.join(".") + " " + title + "](#" + href + ")\n";
      }

      if (options.markdown.checked) {
        if (options.bullets.checked) {
          textOut.value = textOut.value + indent + linkBullets;
        } else {
          textOut.value = textOut.value + indent + linkNobullets;
        }
      } else if (options.bullets.checked) {
        textOut.value = textOut.value + indent + "* " + title + "\n"
      } else {
        htmlOut.innerHTML = htmlOut.innerHTML + indent + printCounter.join(".") + " " + title + "<br>";
        textOut.value = textOut.value + indent + printCounter.join(".") + " " + title + "\n";
      }
    }
  }
}

function sampleText() {
  var txt = "# Top-level topic\n\nLorem ipsum dolor sit amet...\n\n## First sub-topic\n\nLorem ipsum dolor sit amet...\n\n## Second sub-topic\n\nLorem ipsum dolor sit amet...\n\n### First sub-sub-topic\n\nLorem ipsum dolor sit amet...\n\n## Third sub-topic\n\nLorem ipsum dolor sit amet...\n\n### A sub-sub-topic\n\nLorem ipsum dolor sit amet...\n\n#### And a sub-sub-sub-topic\n\nLorem ipsum dolor sit amet...\n\n# Second top-level topic\n\nLorem ipsum dolor sit amet...\n";
  var inputBox = document.getElementById("input");
  inputBox.value = txt;
}

function toBase64() {
  textOut = document.getElementById("text_output");
  text = textOut.value.replace(/\n/g,"\\n").replace(/"/g,'\\"');
  json = '{"source":"' + text + '","defaults":{"html":false,"xhtmlOut":false,"breaks":false,"langPrefix":"language-","linkify":true,"typographer":true,"_highlight":true,"_strict":false,"_view":"html"}}';

// unicode text breaks remarkable's permalink api at the moment, and so does uriencoded ascii
  if (text.match(/[^ -ÿ]/)) {
      b64 = window.btoa(encodeURI(json));
  } else {
      b64 = window.btoa(json);
  }
  url = "https://jonschlinkert.github.io/remarkable/demo/#md64=" + b64;
  window.location = url;
}
