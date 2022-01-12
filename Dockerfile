FROM continuumio/miniconda3

WORKDIR /app

# Create the environment:
COPY environment.yml .
RUN conda env create -f environment.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "salary-data",  "/bin/bash", "-c"]

# The code to run when container is started:
COPY . .
ENTRYPOINT ["conda", "run" ,"--no-capture-output", "-n", "salary-data", "flask", "run", "--host=0.0.0.0"]