FROM python:3.6

WORKDIR /usr/src

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir data log
COPY ./app ./app

CMD [ "python", "./app/main_banZhuan.py" ]
