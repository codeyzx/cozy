import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat dan Ketentuan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Syarat dan Ketentuan',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Terakhir diperbarui: 1 Mei 2024',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSection(
              title: 'Penggunaan Layanan',
              content: '''
              Dengan menggunakan aplikasi Chyess, Anda setuju untuk mematuhi syarat dan ketentuan berikut:
              
              - Anda bertanggung jawab sepenuhnya atas akun Anda dan segala kegiatan yang terjadi di bawahnya.
              - Anda menjamin bahwa informasi yang Anda berikan kepada kami adalah akurat, lengkap, dan terbaru.
              - Anda tidak boleh menggunakan layanan kami untuk tujuan ilegal atau melanggar hukum.
              - Kami berhak untuk menangguhkan atau menghentikan akun Anda jika kami mendeteksi pelanggaran terhadap syarat dan ketentuan ini.
              - Chyess berhak mengubah atau menghapus fitur layanan kami tanpa pemberitahuan terlebih dahulu.
              ''',
            ),

            _buildSection(
              title: 'Privasi Pengguna',
              content: '''
              Kami menghargai privasi pengguna kami dan berkomitmen untuk melindungi data pribadi Anda. Kami tidak akan membagikan data pribadi Anda kepada pihak ketiga tanpa izin Anda.
              ''',
            ),

            _buildSection(
              title: 'Konten Pengguna',
              content: '''
              Anda bertanggung jawab atas konten yang Anda bagikan di Chyess. Anda tidak boleh membagikan konten yang melanggar hak cipta, mengandung kekerasan, atau tidak pantas.
              ''',
            ),

            _buildSection(
              title: 'Pembayaran',
              content: '''
              Beberapa fitur layanan kami mungkin memerlukan pembayaran. Dengan menggunakan fitur tersebut, Anda menyetujui tarif yang berlaku dan bertanggung jawab atas pembayaran yang harus dilakukan tepat waktu.
              ''',
            ),
            _buildSection(
              title: 'Penggunaan Data',
              content: '''
              Dengan menggunakan layanan kami, Anda menyetujui pengumpulan, penggunaan, dan penyimpanan data Anda oleh Chyess. Kami akan menggunakan data Anda untuk meningkatkan layanan kami dan memberikan pengalaman yang lebih baik kepada pengguna kami.
              ''',
            ),
            // Tambahkan bagian lain dengan cara yang serupa
            // bagian syarat dan ketentuan lainnya
            // seperti pembatalan, pengembalian dana, dll
            _buildSection(
              title: 'Perubahan pada Syarat dan Ketentuan',
              content: '''
              Kami berhak untuk mengubah syarat dan ketentuan ini kapan saja tanpa pemberitahuan terlebih dahulu. Dengan melanjutkan penggunaan layanan kami setelah perubahan tersebut, Anda menyetujui syarat dan ketentuan yang baru.
              ''',
            ),

            Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Jika Anda memiliki pertanyaan tentang Syarat dan Ketentuan ini, Anda dapat menghubungi kami:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              'Melalui email: support@chyess.com Dengan mengunjungi halaman ini di situs web kami: chyess.com/hubungi-kami\n',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildContentLines(content),
        ),
      ],
    );
  }

  List<Widget> _buildContentLines(String content) {
    List<String> lines =
        content.split('\n').map((line) => line.trim()).toList();
    return lines
        .map((line) => Text(
              line,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
              textAlign: TextAlign.justify,
            ))
        .toList();
  }
}
