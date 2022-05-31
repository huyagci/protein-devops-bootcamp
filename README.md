

### 2.Hafta 1.Odev
---

## Table of contents[![](./docs/img/pin.svg)](#table-of-contents)

1. [Aciklama](#aciklama)
2. [Not](#not)
3. [Usage](#usage)

---

#### Aciklama: [![](./docs/img/pin.svg)](#aciklama)

Developer projesinin sadece belirli bir branch'ini derlemek icin yardimci bir script istemektedir. Bu script'i asagidaki ozellikleri saglayacak sekilde bash script ile kodlayiniz. 

1. Kullanici build istedigi branch ismini vermeli ve o anda o branch uzerinde degilse o branch'e gecmeli ve o sekilde build islemi baslamalidir.
2. Kullanici main ve ya master branch'ini derlemek istediginde ekrana bu bir uyari (WARNING) cikmali, `su an master ve ya main branch'ini build ediyorsunuz !!!` diye.
3. Kullanici bu script yardimiyla yeni bir branch olusturabilmeli ayni zamanda.
3. Build islemi sirasinda DEBUG modunun acik olup olmayacagi kullanicidan alinmali. Eger kullanici belirtmeyi tercih etmiyorsa default olarak DEBUG mod kapali gelmeli.
4. Kullanici build islemi bittikten sonra cikan artifact'lerin hangi formatta compress edilecegini secebilmeli, kullaniciya iki secenek sunulmali `zip` ve ya `tar.gz ` . Bu iki compress formatindan baska bir format verilmisse build islemi baslamamali, script kirilmalidir. (Not: artifact ismi branch_name.tar.gz ve branch_name.zip formatinda olmali, yani o an uzerinde calisilan branch'in ismi o compress edilen dosyanin ismi olmalidir.)
5. Compress edilen artifact'lerin hangi dizine tasinacagi kullanicidan alinmalidir.




`Kullanici`: Bu build scriptini kullanan yazilimci, developer, gelistirici.

---

#### Not: [![](./docs/img/pin.svg)](#not)

- Burada verilen proje `Java Spring Boot` ile yazilmistir ve `Maven` paket yoneticisi ile yonetilmektedir. Build scriptini bunu dikkate alarak yaziniz.
- Burada verilen projeden farkli bir projede kullanilabilir. Ornegin bir `NodeJS` uygulamasi ve paket yonetimi icin `npm` kullanabilirsiniz. 

---


#### Example Usage: [![](./docs/img/pin.svg)](#usage)

```shell

$ build.sh --help

Usage:
    -b  <branch_name>     Branch name
    -n  <new_branch>      Create new branch
    -f  <zip|tar>         Compress format
    -p  <artifact_path>   Copy artifact to spesific path



```


