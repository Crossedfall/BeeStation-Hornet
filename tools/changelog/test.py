import sys
import re
import yaml
import json
from pathlib import Path

CL_BODY = re.compile(r":cl:(.+)?\r\n((.|\n|\r)+?)\r\n\/:cl:", re.MULTILINE)
CL_SPLIT = re.compile(r"(^\w+):\s+(\w.+)", re.MULTILINE)

if len(sys.argv) < 3:
    print("Missing arguments")
    exit(1)

pr_number = bytes(sys.argv[2], "utf-8").decode("unicode_escape")
pr_body = bytes(sys.argv[1], "utf-8").decode("unicode_escape")

write_cl = {}
try:
    cl = CL_BODY.search(pr_body)
    cl_list = CL_SPLIT.findall(cl.group(2))
except AttributeError:
    print("No CL!")
    exit(1)


if cl.group(1) is not None:
    write_cl['author'] = cl.group(1).lstrip()

with open(Path.cwd().joinpath("tools/changelog/tags.yml")) as file:
    tags = yaml.full_load(file)

write_cl['changes'] = {}

for k, v in cl_list:
    if k in tags['tags'].keys():
        v = v.rstrip()
        if v not in list(tags['defaults'].values()):
            write_cl['changes'][tags['tags'][k]] = v

if write_cl['changes']:
    with open(Path.cwd().joinpath(f"html/changelogs/AutoChangeLog-pr-{pr_number}.yml"), 'w') as file:
        yaml.dump(write_cl, file)

    print(f"Done!")
else:
    print("No changes!")
    exit(1)
