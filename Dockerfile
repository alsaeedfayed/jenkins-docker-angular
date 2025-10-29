# 1️⃣ مرحلة البناء: بناء Angular
FROM node:20.19 AS build

WORKDIR /app

# انسخ ملفات package.json و package-lock.json وثبت الباكجات
COPY package*.json ./
RUN npm install

# انسخ باقي ملفات المشروع وشغل build
COPY . .
RUN npm run build --prod

# 2️⃣ مرحلة التشغيل: Apache
FROM httpd:2.4

# احذف أي ملفات افتراضية قديمة
RUN rm -rf /usr/local/apache2/htdocs/*

# انسخ ملفات Angular من مرحلة البناء
COPY --from=build /app/dist/jenkins-docker-angular/browser/ /usr/local/apache2/htdocs/

# افتح البورت 80
EXPOSE 80
