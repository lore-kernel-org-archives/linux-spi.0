From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: add macros related to MICRON flash
Date: Thu, 11 Oct 2018 08:15:40 +0000
Message-ID: <1539245630-26611-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539245630-26611-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some MICRON related macros in spi-nor domain were ST.
Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.

Added entry of MFR Id for Micron flashes, 0x002C.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
Changes for v2:
- None

 drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
 include/linux/mtd/cfi.h       | 1 +
 include/linux/mtd/spi-nor.h   | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9407ca5..b8b494f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor, const =
struct flash_info *info,
 	u8 cmd;
=20
 	switch (JEDEC_MFR(info)) {
+	case SNOR_MFR_ST:
 	case SNOR_MFR_MICRON:
 		/* Some Micron need WREN command; all will accept it */
 		need_wren =3D true;
@@ -1388,7 +1389,7 @@ static const struct flash_info spi_nor_ids[] =3D {
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUA=
L_READ | SPI_NOR_QUAD_READ) },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
=20
-	/* Micron */
+	/* Micron <--> ST Micro */
 	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_=
READ) },
 	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
 	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
@@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			params->quad_enable =3D macronix_quad_enable;
 			break;
=20
+		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
 			break;
=20
@@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *nam=
e,
 	mtd->_resume =3D spi_nor_resume;
=20
 	/* NOR protection support for STmicro/Micron chips and similar */
-	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
-			info->flags & SPI_NOR_HAS_LOCK) {
+	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
+	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
+	    info->flags & SPI_NOR_HAS_LOCK) {
 		nor->flash_lock =3D stm_lock;
 		nor->flash_unlock =3D stm_unlock;
 		nor->flash_is_locked =3D stm_is_locked;
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index 9b57a9b..cbf7716 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -377,6 +377,7 @@ struct cfi_fixup {
 #define CFI_MFR_SHARP		0x00B0
 #define CFI_MFR_SST		0x00BF
 #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
+#define CFI_MFR_MICRON		0x002C /* Micron */
 #define CFI_MFR_TOSHIBA		0x0098
 #define CFI_MFR_WINBOND		0x00DA
=20
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7f0c730..8b1acf6 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -23,7 +23,8 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
-#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
+#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
+#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
 #define SNOR_MFR_SPANSION	CFI_MFR_AMD
 #define SNOR_MFR_SST		CFI_MFR_SST
--=20
2.7.4
