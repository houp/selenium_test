FROM continuumio/miniconda3

RUN apt-get -y update && apt-get install -yqq unzip gnupg curl

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ ; rm -rf /tmp/chromedriver.zip

WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "salary-data",  "/bin/bash", "-c"]

# The code to run when container is started:
COPY test.py .
COPY run.py .

ENTRYPOINT ["conda", "run" ,"--no-capture-output", "-n", "salary-data", "flask", "run", "--host=0.0.0.0"]



