import sys
import re
import yaml

CL_BODY = re.compile(r":cl:(.+)?\r\n((.|\n|\r)+?)\r\n\/:cl:", re.MULTILINE)
CL_SPLIT = re.compile(r"(^\w+):\s+(\w.+)", re.MULTILINE)

pr_body = sys.argv[1]
write_cl = {}
try:
    cl = CL_BODY.search(pr_body)
    cl_list = CL_SPLIT.findall(cl.group(2))
except AttributeError:
    print("No CL!")
    quit()


if cl.group(1) is not None:
    write_cl['author'] = cl.group(1).lstrip()

with open(r"tags.yml") as file:
    tags = yaml.full_load(file)

write_cl['changes'] = {}

for k, v in cl_list:
    if k in tags['tags'].keys():
        v = v.rstrip()
        if v not in list(tags['defaults'].values()):
            write_cl['changes'][tags['tags'][k]] = v

if write_cl['changes']:
    with open(r'changes.yml', 'w') as file:
        end = yaml.dump(write_cl, file)

    print(f"Done!\n{end}")
else:
    print("No changes!")
