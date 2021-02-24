FROM python:3.8-slim

WORKDIR /opt
COPY requirements.txt /opt
RUN pip install -r requirements.txt
COPY . /opt

CMD ["python", "-u", "/opt/run_docker.py"]
