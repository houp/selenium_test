FROM continuumio/miniconda3

RUN apt-get update && apt-get install -y libdbus-1-3 libnss3

WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "salary-data",  "/bin/bash", "-c"]

# The code to run when container is started:
COPY . .

ENTRYPOINT ["conda", "run" ,"--no-capture-output", "-n", "salary-data", "flask", "run", "--host=0.0.0.0"]
RUN chmod +x ./chromedriver



