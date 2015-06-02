TugasAkhir-ICA/ReadMe.md - Panduan Skrip Tugas Akhir bagustris (Final Project Matlab's Code)
<br/>Judul : Pemisahan Banyak Sumber Suara Mesin Dengan Metode Independent Component Analysis Untuk Deteksi Kerusakan]
<br/>          Machines Sound Source Separation using ICA for fault deterction
<br/>Tahun : 2009
<br/>NRP: 2405100019
<br/>Programming Language: Matlab/Octave

File pdf: [TABagus.pdf](https://dl.dropboxusercontent.com/u/91803768/TAbagus.pdf)

List file:

- fp_tdica.m : Program pemisahan sinyal suara dalam domain waktu (time domain)
- fp_fdica.m : Program pemisahan sinyal suara dalam domain frekuensi (frequency domain, buggy)
- sep.m : Fungsi untuk pembelajaran data (training)
- sepout.m : Fungsi untuk menampilkan teks output (separation output result)
- wchange.m : Fungsi untuk tracking ukuran dan arah perubahan pembobotan (tracking the change of weighting filter)
- fp_if.m :Program untuk menampilkan spektrogram dan frekuensi sesaat (plot instantaneous frequency spectrogram)
- ifgram.m : Fungsi untuk menghitung/plot frekuensi sesaat (calculate IF)
- extractrax.m : Fungsi untuk mengekstrak Peak amplitude frekuensi sesaat (extract IF peak amplitude)
- colinterpvals.m : Fungsi untuk menginterpolasi kolom frekuensi sesaat (IF interpolation)


Git Clone

Untuk mengcopy file ini dalam satu folder, gunakan: $ git clone https://github.com/bagustris/TugasAkhir-ICA.git



