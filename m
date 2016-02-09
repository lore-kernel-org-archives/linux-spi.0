From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Let drivers translate ACPI DeviceSelection to suitable Linux chip select" to the spi tree
Date: Tue, 09 Feb 2016 18:20:18 +0000
Message-ID: <E1aTCte-0001XE-PI@debutante>
References: <1453807111-103111-2-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453807111-103111-2-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Let drivers translate ACPI DeviceSelection to suitable Linux chip select

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a0a90718f18264dc904d34a580f332006f5561e9 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 8 Feb 2016 17:14:28 +0200
Subject: [PATCH] spi: Let drivers translate ACPI DeviceSelection to suitable
 Linux chip select

In Windows it is up to the SPI host controller driver to handle the ACPI
DeviceSelection as it likes. The SPI core does not take any part in it.
This is different in Linux because we always expect to have chip select in
range of 0 .. master->num_chipselect - 1.

In order to support this in Linux we need a way to allow the driver to
translate between ACPI DeviceSelection field and Linux chip select number
so provide a new optional hook ->fw_translate_cs() that can be used by a
driver to handle translation and call this hook if set during SPI slave
ACPI enumeration.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 19 ++++++++++++++++++-
 include/linux/spi/spi.h |  5 +++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 47eff8012a77..2c0c26a57f03 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1581,13 +1581,30 @@ static void of_register_spi_devices(struct spi_master *master) { }
 static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 {
 	struct spi_device *spi = data;
+	struct spi_master *master = spi->master;
 
 	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
 		struct acpi_resource_spi_serialbus *sb;
 
 		sb = &ares->data.spi_serial_bus;
 		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_SPI) {
-			spi->chip_select = sb->device_selection;
+			/*
+			 * ACPI DeviceSelection numbering is handled by the
+			 * host controller driver in Windows and can vary
+			 * from driver to driver. In Linux we always expect
+			 * 0 .. max - 1 so we need to ask the driver to
+			 * translate between the two schemes.
+			 */
+			if (master->fw_translate_cs) {
+				int cs = master->fw_translate_cs(master,
+						sb->device_selection);
+				if (cs < 0)
+					return cs;
+				spi->chip_select = cs;
+			} else {
+				spi->chip_select = sb->device_selection;
+			}
+
 			spi->max_speed_hz = sb->connection_speed;
 
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 53be3a4c60cb..8a25e6c2fb56 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -369,6 +369,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @dma_rx: DMA receive channel
  * @dummy_rx: dummy receive buffer for full-duplex devices
  * @dummy_tx: dummy transmit buffer for full-duplex devices
+ * @fw_translate_cs: If the boot firmware uses different numbering scheme
+ *	what Linux expects, this optional hook can be used to translate
+ *	between the two.
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -537,6 +540,8 @@ struct spi_master {
 	/* dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
+
+	int (*fw_translate_cs)(struct spi_master *master, unsigned cs);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
