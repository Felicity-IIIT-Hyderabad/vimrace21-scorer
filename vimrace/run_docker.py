import time
from typing import Tuple

import docker

VIM_DOCKER_IMAGE = "yoogottamk/vim"


def docker_init():
    while True:
        try:
            return docker.DockerClient(base_url="tcp://docker:2375")
        except Exception as e:
            print(e)
            print("Error while connecting to docker client")
            time.sleep(5)
            print("Retrying...")


def get_scores(d: docker.DockerClient, path: str) -> Tuple[Tuple[int, int], str]:
    d.images.pull(VIM_DOCKER_IMAGE)

    run_logs = d.containers.run(
        image=VIM_DOCKER_IMAGE,
        name=path.replace("/", ""),
        remove=True,
        command="/scorer/eval.sh",
        volumes={path: {"bind": "/scorer/files", "mode": "rw"}},
    )

    lines = run_logs.decode("utf-8").strip().split("\n")
    scores = lines[-1].split(" ")

    # (corr, wrong), logs
    return (int(scores[0][1:]), int(scores[1][1:])), "\n".join(lines)


(corr, wrong), logs = get_scores(docker_init(), "/tmp")
print(f"You got {corr}/{corr+wrong} correct!")
print("Here are your run logs:\n", logs, sep="\n")
