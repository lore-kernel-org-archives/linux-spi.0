From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 for-next] spi: bcm53xx: add spi_flash_read callback for MMIO-based reads
Date: Mon, 18 Apr 2016 14:39:30 +0200
Message-ID: <1460983170-7390-1-git-send-email-zajec5@gmail.com>
References: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460977843-9426-1-git-send-email-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This implements more efficient reads of SPI-attached flash content.

Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
V2: Add BCM53XXSPI_FLASH_WINDOW and check it in bcm53xxspi_flash_read.
---
 drivers/spi/spi-bcm53xx.c | 78 +++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index cc3f938..afb5169 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -10,6 +10,7 @@
 #include "spi-bcm53xx.h"
=20
 #define BCM53XXSPI_MAX_SPI_BAUD	13500000	/* 216 MHz? */
+#define BCM53XXSPI_FLASH_WINDOW	SZ_32M
=20
 /* The longest observed required wait was 19 ms */
 #define BCM53XXSPI_SPE_TIMEOUT_MS	80
@@ -17,8 +18,10 @@
 struct bcm53xxspi {
 	struct bcma_device *core;
 	struct spi_master *master;
+	void __iomem *mmio_base;
=20
 	size_t read_offset;
+	bool bspi;				/* Boot SPI mode with memory mapping */
 };
=20
 static inline u32 bcm53xxspi_read(struct bcm53xxspi *b53spi, u16 offse=
t)
@@ -32,6 +35,50 @@ static inline void bcm53xxspi_write(struct bcm53xxsp=
i *b53spi, u16 offset,
 	bcma_write32(b53spi->core, offset, value);
 }
=20
+static void bcm53xxspi_disable_bspi(struct bcm53xxspi *b53spi)
+{
+	struct device *dev =3D &b53spi->core->dev;
+	unsigned long deadline;
+	u32 tmp;
+
+	if (!b53spi->bspi)
+		return;
+
+	tmp =3D bcm53xxspi_read(b53spi, B53SPI_BSPI_MAST_N_BOOT_CTRL);
+	if (tmp & 0x1)
+		return;
+
+	deadline =3D jiffies + usecs_to_jiffies(200);
+	do {
+		tmp =3D bcm53xxspi_read(b53spi, B53SPI_BSPI_BUSY_STATUS);
+		if (!(tmp & 0x1)) {
+			bcm53xxspi_write(b53spi, B53SPI_BSPI_MAST_N_BOOT_CTRL,
+					 0x1);
+			ndelay(200);
+			b53spi->bspi =3D false;
+			return;
+		}
+		udelay(1);
+	} while (!time_after_eq(jiffies, deadline));
+
+	dev_warn(dev, "Timeout disabling BSPI\n");
+}
+
+static void bcm53xxspi_enable_bspi(struct bcm53xxspi *b53spi)
+{
+	u32 tmp;
+
+	if (b53spi->bspi)
+		return;
+
+	tmp =3D bcm53xxspi_read(b53spi, B53SPI_BSPI_MAST_N_BOOT_CTRL);
+	if (!(tmp & 0x1))
+		return;
+
+	bcm53xxspi_write(b53spi, B53SPI_BSPI_MAST_N_BOOT_CTRL, 0x0);
+	b53spi->bspi =3D true;
+}
+
 static inline unsigned int bcm53xxspi_calc_timeout(size_t len)
 {
 	/* Do some magic calculation based on length and buad. Add 10% and 1.=
 */
@@ -176,6 +223,8 @@ static int bcm53xxspi_transfer_one(struct spi_maste=
r *master,
 	u8 *buf;
 	size_t left;
=20
+	bcm53xxspi_disable_bspi(b53spi);
+
 	if (t->tx_buf) {
 		buf =3D (u8 *)t->tx_buf;
 		left =3D t->len;
@@ -206,6 +255,22 @@ static int bcm53xxspi_transfer_one(struct spi_mast=
er *master,
 	return 0;
 }
=20
+static int bcm53xxspi_flash_read(struct spi_device *spi,
+				 struct spi_flash_read_message *msg)
+{
+	struct bcm53xxspi *b53spi =3D spi_master_get_devdata(spi->master);
+	int ret =3D 0;
+
+	if (msg->from + msg->len > BCM53XXSPI_FLASH_WINDOW)
+		return -EINVAL;
+
+	bcm53xxspi_enable_bspi(b53spi);
+	memcpy_fromio(msg->buf, b53spi->mmio_base + msg->from, msg->len);
+	msg->retlen =3D msg->len;
+
+	return ret;
+}
+
 /**************************************************
  * BCMA
  **************************************************/
@@ -222,6 +287,7 @@ MODULE_DEVICE_TABLE(bcma, bcm53xxspi_bcma_tbl);
=20
 static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 {
+	struct device *dev =3D &core->dev;
 	struct bcm53xxspi *b53spi;
 	struct spi_master *master;
 	int err;
@@ -231,7 +297,7 @@ static int bcm53xxspi_bcma_probe(struct bcma_device=
 *core)
 		return -ENOTSUPP;
 	}
=20
-	master =3D spi_alloc_master(&core->dev, sizeof(*b53spi));
+	master =3D spi_alloc_master(dev, sizeof(*b53spi));
 	if (!master)
 		return -ENOMEM;
=20
@@ -239,11 +305,19 @@ static int bcm53xxspi_bcma_probe(struct bcma_devi=
ce *core)
 	b53spi->master =3D master;
 	b53spi->core =3D core;
=20
+	if (core->addr_s[0])
+		b53spi->mmio_base =3D devm_ioremap(dev, core->addr_s[0],
+						 BCM53XXSPI_FLASH_WINDOW);
+	b53spi->bspi =3D true;
+	bcm53xxspi_disable_bspi(b53spi);
+
 	master->transfer_one =3D bcm53xxspi_transfer_one;
+	if (b53spi->mmio_base)
+		master->spi_flash_read =3D bcm53xxspi_flash_read;
=20
 	bcma_set_drvdata(core, b53spi);
=20
-	err =3D devm_spi_register_master(&core->dev, master);
+	err =3D devm_spi_register_master(dev, master);
 	if (err) {
 		spi_master_put(master);
 		bcma_set_drvdata(core, NULL);
--=20
1.8.4.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
