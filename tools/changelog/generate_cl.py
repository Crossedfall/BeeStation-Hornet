"""
DO NOT MANUALLY RUN THIS SCRIPT.
"""
import os
import re
from pathlib import Path
from ruamel import yaml
from github import Github

CL_BODY = re.compile(r":cl:(.+)?\r\n((.|\n|\r)+?)\r\n\/:cl:", re.MULTILINE)
CL_SPLIT = re.compile(r"(^\w+):\s+(\w.+)", re.MULTILINE)

git_email = os.getenv("GIT_EMAIL")
git_name = os.getenv("GIT_NAME")

# Blessed is the GoOnStAtIoN birb ZeWaKa for thinking of this first
repo = os.getenv("GITHUB_REPOSITORY")
token = os.getenv("GITHUB_TOKEN")
sha = os.getenv("GITHUB_SHA")

git = Github(token)
repo = git.get_repo(repo)
commit = repo.get_commit(sha)
pr_list = commit.get_pulls()

if not pr_list.totalCount:
    print("Direct commit detected")
    exit(1)

pr = pr_list[0]

pr_body = pr.body
pr_number = pr.number
pr_author = pr.user.login

os.environ["PR_NUMBER"] = f"{pr_number}"

write_cl = {}
try:
    cl = CL_BODY.search(pr_body)
    cl_list = CL_SPLIT.findall(cl.group(2))
except AttributeError:
    print("No CL found!")
    exit(1)


if cl.group(1) is not None:
    write_cl['author'] = cl.group(1).lstrip()
else:
    write_cl['author'] = pr_author

write_cl['delete-after'] = True

with open(Path.cwd().joinpath("tools/changelog/tags.yml")) as file:
    tags = yaml.safe_load(file)

write_cl['changes'] = []

for k, v in cl_list:
    if k in tags['tags'].keys():
        v = v.rstrip()
        if v not in list(tags['defaults'].values()):
            write_cl['changes'].append({tags['tags'][k]: v})

if write_cl['changes']:
    with open(Path.cwd().joinpath(f"html/changelogs/AutoChangeLog-pr-{pr_number}.yml"), 'w') as file:
        yaml = yaml.YAML()
        yaml.indent(sequence=4, offset=2)
        yaml.dump(write_cl, file)

    repo.create_file(Path.cwd().joinpath(f"html/changelogs/AutoChangeLog-pr-{pr_number}.yml"), f"Automatic changelog generation for PR #{pr_number} [ci skip]", branch='master', committer={git_name: git_email})
    print("Done!")
else:
    print("No CL changes detected!")
    exit(0)
