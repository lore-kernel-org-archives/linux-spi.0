From: "Kwiatkowski, Arkadiusz" <arkadiusz.kwiatkowski@aptiv.com>
Subject: [PATCH] Fixes in TI QSPI driver to allow more than one flash chip
Date: Thu, 22 Mar 2018 12:33:56 +0000
Message-ID: <0ece6261f37a424cbde7122907548a9f@CO1PR6802MB0085.017d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>,
        "sourav.poddar@ti.com" <sourav.poddar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: pl-PL
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add checking for which SPI device was memory-mapped to allow more than
one flash device being used on QSPI bus. Fix parameters order in
regmap_update_bits calls.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b4..3d1dc4f 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -66,7 +66,7 @@ struct ti_qspi {
 u32 cmd;
 u32 dc;

-bool mmap_enabled;
+struct spi_device*mmap_spi_device;
 };

 #define QSPI_PID(0x0)
@@ -490,10 +490,10 @@ static void ti_qspi_enable_memory_map(struct spi_devi=
ce *spi)
 ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 if (qspi->ctrl_base) {
 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-   MEM_CS_EN(spi->chip_select),
-   MEM_CS_MASK);
+   MEM_CS_MASK,
+   MEM_CS_EN(spi->chip_select));
 }
-qspi->mmap_enabled =3D true;
+qspi->mmap_spi_device =3D spi;
 }

 static void ti_qspi_disable_memory_map(struct spi_device *spi)
@@ -503,8 +503,8 @@ static void ti_qspi_disable_memory_map(struct spi_devic=
e *spi)
 ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 if (qspi->ctrl_base)
 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-   0, MEM_CS_MASK);
-qspi->mmap_enabled =3D false;
+   MEM_CS_MASK, 0);
+qspi->mmap_spi_device =3D NULL;
 }

 static void ti_qspi_setup_mmap_read(struct spi_device *spi,
@@ -544,8 +544,12 @@ static int ti_qspi_spi_flash_read(struct spi_device *s=
pi,

 mutex_lock(&qspi->list_lock);

-if (!qspi->mmap_enabled)
+if (qspi->mmap_spi_device !=3D spi) {
+if (qspi->mmap_spi_device !=3D NULL)
+ti_qspi_disable_memory_map(qspi->mmap_spi_device);
 ti_qspi_enable_memory_map(spi);
+}
+
 ti_qspi_setup_mmap_read(spi, msg);

 if (qspi->rx_chan) {
@@ -600,7 +604,7 @@ static int ti_qspi_start_transfer_one(struct spi_master=
 *master,

 mutex_lock(&qspi->list_lock);

-if (qspi->mmap_enabled)
+if (qspi->mmap_spi_device !=3D NULL)
 ti_qspi_disable_memory_map(spi);

 list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -787,7 +791,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 master->spi_flash_read =3D NULL;
 }
 }
-qspi->mmap_enabled =3D false;
+qspi->mmap_spi_device =3D NULL;

 ret =3D devm_spi_register_master(&pdev->dev, master);
 if (!ret)
--
2.7.4
***************************************************************************=
************* Note: If the reader of this message is not the intended recip=
ient, or an employee or agent responsible for delivering this message to th=
e intended recipient, you are hereby notified that any dissemination, distr=
ibution or copying of this communication is strictly prohibited. If you hav=
e received this communication in error, please notify us immediately by rep=
lying to the message and deleting it from your computer. Thank you. *******=
***************************************************************************=
******
