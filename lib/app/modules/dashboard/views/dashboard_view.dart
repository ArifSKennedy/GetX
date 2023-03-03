import 'package:aplikasi_uji/app/data/headline_response.dart';
import 'package:aplikasi_uji/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();
    // Mendefinisikan sebuah widget bernama build dengan tipe StatelessWidget yang memerlukan BuildContext.
    return SafeArea(
      // Widget SafeArea menempatkan semua konten widget ke dalam area yang aman (safe area) dari layar.
      child: DefaultTabController(
        length: 5,
        // Widget DefaultTabController digunakan untuk mengatur tab di aplikasi.
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await auth.erase();
              Get.offAll(() => const HomeView());
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.logout_rounded),
          ),
          // Widget Scaffold digunakan sebagai struktur dasar aplikasi.
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            // Widget PreferredSize digunakan untuk menyesuaikan tinggi appBar.
            child: Column(
              // Widget Column adalah widget yang menyatukan widget-childnya secara vertikal.
              children: [
                ListTile(
                  // Widget ListTile digunakan untuk menampilkan tampilan list sederhana.
                  title: const Text(
                    "Hallo!",
                    textAlign: TextAlign.end,
                    // Properti textAlign digunakan untuk menentukan perataan teks.
                  ),
                  subtitle: Text(
                    auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    // Widget Container digunakan untuk mengatur tampilan konten dalam kotak.
                    margin: const EdgeInsets.only(right: 10),
                    // Properti margin digunakan untuk menentukan jarak dari tepi kontainer ke tepi widget yang di dalamnya.
                    width: 50.0,
                    height: 50.0,
                    child: Lottie.network(
                      // Widget Lottie.network digunakan untuk menampilkan animasi Lottie dari suatu URL.
                      'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                      fit: BoxFit.cover,
                      // Properti fit digunakan untuk menyesuaikan ukuran konten agar sesuai dengan kontainer.
                    ),
                  ),
                ),
                const Align(
                  // Widget Align digunakan untuk menempatkan widget pada posisi tertentu di dalam widget induk.
                  alignment: Alignment.topLeft,
                  // Properti alignment digunakan untuk menentukan letak widget di dalam widget induk.
                  child: TabBar(
                    // Widget TabBar digunakan untuk menampilkan tab di aplikasi.
                    labelColor: Colors.black,
                    // Properti labelColor digunakan untuk menentukan warna teks tab yang dipilih.
                    indicatorSize: TabBarIndicatorSize.label,
                    // Properti indicatorSize digunakan untuk menentukan ukuran indikator tab yang dipilih.
                    isScrollable: true,
                    // Properti isScrollable digunakan untuk menentukan apakah tab dapat di-scroll atau tidak.
                    indicatorColor: Colors.white,
                    // Properti indicatorColor digunakan untuk menentukan warna indikator tab yang dipilih.
                    tabs: [
                      // Properti tabs digunakan untuk menentukan teks yang akan ditampilkan pada masing-masing tab.
                      Tab(text: "Headline"),
                      Tab(text: "Teknologi"),
                      Tab(text: "Olahraga"),
                      Tab(text: "Hiburan"),
                      Tab(text: "Profile"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            // Widget TabBarView digunakan untuk menampilkan konten yang terkait dengan masing-masing tab.
            children: [
              // Properti children digunakan untuk menentukan konten yang akan ditampilkan pada masing-masing tab.
              headline(controller, scrollController),
              Center(child: Text('Berita Teknologi')),
              Center(child: Text('Berita Olahraga')),
              Center(child: Text('Berita Hiburan')),
              Center(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                              //set border radius more than 50% of height and width to make circle
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: 30,
                                child: ClipOval(
                                  child: Image.network(
                                      'data:image/png;base64,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'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          child: Card(
                            child: Wrap(
                              children: [
                                Image.network(
                                    'https://global-uploads.webflow.com/6100d0111a4ed76bc1b9fd54/62a1ac70484ab90ae870152b_github%204.png'),
                                ListTile(
                                  title: Text('@ArifSKennedy.github'),
                                  subtitle: Text('Seorang Frontend Dev'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          child: Card(
                            child: Wrap(
                              children: [
                                Image.network(
                                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAdVBMVEX///8Yd/IAcvIAbvL1+v4SevKWuvgAcPGHr/elxfkAb/INdPIGc/L7/v/Q4fy30fqyzvrw9v7e6v0jfvPC1/sAaPGgwvnV5Pzr8/681fvl7f2KtfhsoPVKjfQsgvNclvVMkPRzp/Znn/ZemvXH3Pt/qvaTuPhyXbNsAAADSklEQVR4nO3b63LaMBSFUWIb7EjmZhMC4Z7b+z9iC0lmmrbEspQzZ592f/+Z0RpjSxZiMGCMMcYYY4wxxhhjjDHGGGOMMcYYY4wxxtgvFatmspjOZrPpejFpHlbzYqw9pO+rmW62uzZzuXsvz1023O8O22p0+9ystMeX1nx92teurP3N73nv66wsz9bjabmw6RxPj879BfeHtS7vltqDjWi1GbpO3UflrfZwe7eqfBnKMykc9fLZE963rpfPnHBUBt9/JoXFoe8FNCZctVl/oCVhM+z9DbUlfGijgHaERdwVtCMc7+o4oBlh1W+atyecRkwTpoRFtM+K8DFmIrQknMR/R40Ij5EThRnhOk8AmhAeUi6hBeF9yl1oQnhKeJDaEKZdQgPChOWMEeFT7JLbinA+TAPiCyf9Xiou+/mfgt/zfu0hzHK/226Wt59a3msTOgqe7r3z1fNce7j9m7eBwLJFv9+u1ATOFa6y+rNo4GzoptoDjW4Z9KDJF9rjjK8KWZQ6o7fgpceAFU39pD3KlEJe732jPcqU9t3Ceqs9yKRC7kL0RcuXjQMepa32IJMquqdD41/SonubrZxpDzKpAGE+0R5kUiFCm6e6PgoQukJ7kEkFCDPtMaYVIrT62vQWhRTiRyGF+FFIIX4UUogfhRTiRyGF+P0H+zQBe97aY+yuuhlerxN489Wnf9YCbKfG/9EgIL8HuE2DfsiOFh60eQNhYX3S5g2EhSXCqTZRoUM4hyJ7DRFOMYgKIVY8kkK/19adkxTWj9q6c5LCcqStOycpxDizKCnEOMYgKoQ4Fi0pHGrjLgkKIdbdosLsRRt3SVAIse4WFbpnbdwlyWv4oI27JChsISYLQaHfIbxZSApRDvHLCbONtu0tOaEDOT4sJywh1t2iz1KA/e5zckKU/ymICf1Rm/aemBBk3S0oBFl3DwYveXm1EPzVD9+ttWnvrV9HV3vt/uuav/rhDcij9MvG//6v3DypQCF8FFKIH4UU4kchhfhRSCF+FFKIH4UU4kchhfhRSCF+FFKIH4UU4kchhfhRSCF+FFKIH4UU4kchhfhRSCF+FFKIH4UU4kchhfhRSCF+FFKIH4UU4kchhfhRSCF+FFL4Df0A5OFCR5kbfNAAAAAASUVORK5CYII='),
                                ListTile(
                                  title: Text('FB'),
                                  subtitle: Text('@arif'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Membuat sebuah ListView yang mengandung satu container dengan gambar, judul, dan sumber berita
// Function untuk menampilkan daftar headline berita dalam bentuk ListView.Builder dengan menggunakan data yang didapatkan dari future yang dikembalikan oleh controller
  FutureBuilder<HeadlineResponse> headline(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getHeadline(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber :${snapshot.data!.data![index].name}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
