FROM heartexlabs/label-studio:latest

WORKDIR /label-studio

# Copy and install requirements.txt first for caching
COPY requirements.txt /label-studio
RUN pip install -r requirements.txt

ENV PORT="9090"
ENV PROJECT_NAME=my_project

EXPOSE ${PORT}

COPY ./models/ner.py /label-studio
COPY ./models/utils.py /label-studio

RUN label-studio-ml init my-ml-backend --script /label-studio/ner.py

COPY ./models/utils.py /label-studio/my-ml-backend/utils.py

CMD label-studio-ml start my-ml-backend