# Zaliczenie przedmiotu  Usługi i platformy deweloperskie
## Wstep 
Tworzenie maszyny za pomocą Terraforma wraz z aplikacją Webową 
## Komendy
1. uzywamy komendy by zalogować się do zasobów Azure
```bash
az login 
```
2. Incjumemy Terraforma
```bash
terraform init 
```
3. Generujemy plan nowych zasobów 
```bash
terraform plan 
```
4 Tworzymy zasoby
```bash
terraform apply 
```
5 Po utworzeniu maszyny logujemy się za pomocą ssh do ip wyswietlonego na ekranie
6 Po zalogowaniu odpalammy 1run.sh  skrypt zupdateuje maszyne oraz zainsluje dokera i odpali obraz serwera nGinx 
```bash
 ./1run.sh
```

## Doatkowe materialy 
- [Kurs postawy Terraform]https://www.youtube.com/watch?v=gyZdCzdkSY4
- [Kurs Azure]https://www.youtube.com/watch?v=tDuruX7XSac&t
