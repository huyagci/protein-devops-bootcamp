FROM python:3.7-alpine
WORKDIR /app

COPY app/requirements.txt .
RUN pip3 install -r requirements.txt --no-cache-dir
COPY app .

EXPOSE 8080
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]