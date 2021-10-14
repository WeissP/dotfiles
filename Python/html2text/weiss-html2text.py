import html2text
import sys

h = html2text.HTML2Text()
h.ignore_links = True

print(h.handle(str(sys.argv[1])))

