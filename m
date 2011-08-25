From: Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH/RFC 2/2] mtd: m25p80: Call a platform power method in the
	driver
Date: Thu, 25 Aug 2011 16:29:12 +0300
Message-ID: <b7d4ea5c5ca058568f4d561914fa8becfa9324e1.1314278151.git.svarbanov@mm-sol.com>
References: <cover.1314278151.git.svarbanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, Stanimir Varbanov <svarbanov@mm-sol.com>,
	artem.bityutskiy@intel.com, dwmw2@infradead.org
To: spi-devel-general@lists.sourceforge.net,
	linux-mtd@lists.infradead.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1314278151.git.svarbanov@mm-sol.com>
In-Reply-To: <cover.1314278151.git.svarbanov@mm-sol.com>
References: <cover.1314278151.git.svarbanov@mm-sol.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On some devices the flash chip could be powered off when m25p driver
is probed. To avoid erroneous detection the power of the chip must be
turn on, add a power function in m25p_probe to switch on the power by
platform data. The power will be turned off at the probe end.

Also implement a get/put_device callbacks to power on/off the flash
chip.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 drivers/mtd/devices/m25p80.c |   41 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index e6ba034..6ab5896 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -806,6 +806,27 @@ static const struct spi_device_id *__devinit jedec_probe(struct spi_device *spi)
 	return ERR_PTR(-ENODEV);
 }
 
+static void m25p_power(struct flash_platform_data *pdata, int on)
+{
+	if (pdata && pdata->power)
+		pdata->power(on);
+}
+
+static int m25p_get_device(struct mtd_info *mtd)
+{
+	struct flash_platform_data *pdata = mtd->dev.parent->platform_data;
+
+	m25p_power(pdata, 1);
+
+	return 0;
+}
+
+static void m25p_put_device(struct mtd_info *mtd)
+{
+	struct flash_platform_data *pdata = mtd->dev.parent->platform_data;
+
+	m25p_power(pdata, 0);
+}
 
 /*
  * board specific setup should have ensured the SPI clock used here
@@ -820,6 +841,7 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	struct flash_info		*info;
 	unsigned			i;
 	struct mtd_part_parser_data	ppdata;
+	int				ret;
 
 	/* Platform data helps sort out which chip type we have, as
 	 * well as how this board partitions it.  If we don't have
@@ -845,12 +867,16 @@ static int __devinit m25p_probe(struct spi_device *spi)
 
 	info = (void *)id->driver_data;
 
+	/* power on device while probing */
+	m25p_power(data, 1);
+
 	if (info->jedec_id) {
 		const struct spi_device_id *jid;
 
 		jid = jedec_probe(spi);
 		if (IS_ERR(jid)) {
-			return PTR_ERR(jid);
+			ret = PTR_ERR(jid);
+			goto out;
 		} else if (jid != id) {
 			/*
 			 * JEDEC knows better, so overwrite platform ID. We
@@ -867,12 +893,15 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	}
 
 	flash = kzalloc(sizeof *flash, GFP_KERNEL);
-	if (!flash)
-		return -ENOMEM;
+	if (!flash) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	flash->command = kmalloc(MAX_CMD_SIZE + FAST_READ_DUMMY_BYTE, GFP_KERNEL);
 	if (!flash->command) {
 		kfree(flash);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	flash->spi = spi;
@@ -902,6 +931,8 @@ static int __devinit m25p_probe(struct spi_device *spi)
 	flash->mtd.size = info->sector_size * info->n_sectors;
 	flash->mtd.erase = m25p80_erase;
 	flash->mtd.read = m25p80_read;
+	flash->mtd.get_device = m25p_get_device;
+	flash->mtd.put_device = m25p_put_device;
 
 	/* sst flash chips use AAI word program */
 	if (JEDEC_MFR(info->jedec_id) == CFI_MFR_SST)
@@ -956,6 +987,8 @@ static int __devinit m25p_probe(struct spi_device *spi)
 				flash->mtd.eraseregions[i].erasesize / 1024,
 				flash->mtd.eraseregions[i].numblocks);
 
+out:
+	m25p_power(data, 0);
 
 	/* partitions should match sector boundaries; and it may be good to
 	 * use readonly partitions for writeprotected sectors (BP2..BP0).
-- 
1.7.4.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
