FROM python:2.7-alpine
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code
CMD python app.py
EXPOSE 5000
