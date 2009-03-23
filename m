From: =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
Subject: [patch 4/6] xtensa: add m25p80 to s6105 platform
Date: Mon, 23 Mar 2009 16:34:20 +0100
Message-ID: <1237822462-32109-4-git-send-email-dg@emlix.com>
References: <1237822462-32109-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	=?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
To: Chris Zankel <chris@zankel.net>,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758831AbZCWPdx@vger.kernel.org>
In-Reply-To: <1237822462-32109-1-git-send-email-dg@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi_board_info is enclosed in #ifdef CONFIG_MTD_M25P80 to not
interfere with the mmc_spi driver if not used. When mmc_spi is fixed
to work on a shared bus, this #ifdef can be removed.

The stage2 partition contains the kernels for all processors in the
device. In our case a Linux kernel for the SCP core and maybe a
non-Linux kernel for the AUX core. The size of the stage2 partition
is not hardcoded in the bootloader. It depends on the first few bytes
of that partition. Remaining space up to the boot config can be used
for other purposes (f.ex. a filesystem).

The boot configuration is expected at address 0xfff800. The flash chip
ignores the upper two address bits. Rounding down to sectors then
yields an offset of 0x3f0000 for that partition.

Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
---
 arch/xtensa/platforms/s6105/device.c |   47 ++++++++++++++++++++++++++=
++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/platforms/s6105/device.c b/arch/xtensa/platfor=
ms/s6105/device.c
index 789448e..bc254ac 100644
--- a/arch/xtensa/platforms/s6105/device.c
+++ b/arch/xtensa/platforms/s6105/device.c
@@ -12,9 +12,12 @@
 #include <linux/irq.h>
 #include <linux/phy.h>
 #include <linux/mmc/host.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
+#include <linux/spi/flash.h>
 #include <linux/spi/mmc_spi.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_s6000.h>
@@ -211,6 +214,36 @@ static __devinitdata struct s6_spi_platform_data s=
6_spi_pdata =3D {
 #define S6_SPI_CS_EXPANSION	3
 #define S6_SPI_CS_MMC_SLOT	4
=20
+static struct mtd_partition s6_spi_flash_partitions[] =3D {
+	{
+		.name =3D "bootloader",
+		.size =3D 0x10000,
+		.offset =3D 0,
+	},
+	{
+		.name =3D "stage2",
+		.size =3D 0x360000,
+		.offset =3D 0x10000,
+	},
+	{
+		.name =3D "filesystem",
+		.size =3D 0x90000,
+		.offset =3D 0x370000,
+	},
+	{ /* actually 0x800 bytes at 0xfff800 */
+		.name =3D "bootconfig",
+		.size =3D 0x10000,
+		.offset =3D 0x3f0000,
+	}
+};
+
+static struct flash_platform_data s6_spi_flash_pdata =3D {
+	.name =3D "m25p80",
+	.parts =3D s6_spi_flash_partitions,
+	.nr_parts =3D ARRAY_SIZE(s6_spi_flash_partitions),
+	.type =3D "m25p32",
+};
+
 static int __devinit s6_init_mmc_host(struct device *spi,
 				      irqreturn_t (*handler)(int, void *),
 				      void *mmc)
@@ -258,6 +291,20 @@ static struct mmc_spi_platform_data s6_spi_mmc_pda=
ta =3D {
 };
=20
 static struct spi_board_info __initdata s6_spi_devices[] =3D {
+#ifdef CONFIG_MTD_M25P80
+	{
+		.modalias =3D "m25p80",
+		.platform_data =3D &s6_spi_flash_pdata,
+		.bus_num =3D S6_SPI_BUS_NUM,
+		.chip_select =3D S6_SPI_CS_BOOT_FLASH,
+#ifdef CONFIG_M25PXX_USE_FAST_READ
+		.max_speed_hz =3D 50000000,
+#else
+		.max_speed_hz =3D 33000000,
+#endif
+		.mode =3D SPI_MODE_3
+	},
+#endif
 	{
 		.modalias =3D "mmc_spi",
 		.platform_data =3D &s6_spi_mmc_pdata,
--=20
1.6.2.107.ge47ee
