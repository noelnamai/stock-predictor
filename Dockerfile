# specifying the base image
FROM python:3.8

# name and email of the person who maintains the file
LABEL maintainer="Noel Namai"

# updating ubuntu and installing other necessary software
RUN apt-get -y update --fix-missing \
    && apt-get install -y \
        python3-dev \
        apt-utils \
        python-dev \
        build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

# install necessary python libraries
RUN pip install --no-cache-dir -U pip
RUN pip install --no-cache-dir -U cython
RUN pip install --no-cache-dir -U numpy
RUN pip install --no-cache-dir -U pystan==2.19.1.1

# copy the src and requirements.txt file
COPY src/ requirements.txt ./

# install libraries from requirements file
RUN pip install --no-cache-dir -U -r requirements.txt

# expose port 8000
EXPOSE 8000

# set the command to run the uvicorn server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
