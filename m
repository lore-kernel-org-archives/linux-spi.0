From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail" to the spi tree
Date: Tue, 09 Feb 2016 19:43:17 +0000
Message-ID: <E1aTEBx-0003Lr-TS@debutante>
References: <1454944471-50119-3-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454944471-50119-3-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail

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

>From 0c27d9cf7245d832d3d34f289c1bcd4f7f3fbd30 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 8 Feb 2016 17:14:29 +0200
Subject: [PATCH] spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip
 select on Baytrail

The Windows Baytrail SPI host controller driver uses 1 as the first (and
only) value for ACPI DeviceSelection like can be seen in DSDT taken from
Lenovo Thinkpad 10:

    Device (FPNT)
    {
        ...
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (UBUF, ResourceTemplate ()
            {
                SpiSerialBus (0x0001, // DeviceSelection
                    PolarityLow, FourWireMode, 0x08,
                    ControllerInitiated, 0x007A1200, ClockPolarityLow,
                    ClockPhaseFirst, "\\_SB.SPI1",
                    0x00, ResourceConsumer,,)

This will fail to enumerate in Linux with following error:

[    0.241296] pxa2xx-spi 80860F0E:00: cs1 >= max 1
[    0.241312] spi_master spi32766: failed to add SPI device VFSI6101:00 from ACPI

To make the Linux SPI core successfully enumerate the device we provide a
custom version of ->fw_translate_cs() that translates DeviceSelection
correctly.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ce66cf44bba5..7d6d3b74d25b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1445,6 +1445,28 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 }
 #endif
 
+static int pxa2xx_spi_fw_translate_cs(struct spi_master *master, unsigned cs)
+{
+	struct driver_data *drv_data = spi_master_get_devdata(master);
+
+	if (has_acpi_companion(&drv_data->pdev->dev)) {
+		switch (drv_data->ssp_type) {
+		/*
+		 * For Atoms the ACPI DeviceSelection used by the Windows
+		 * driver starts from 1 instead of 0 so translate it here
+		 * to match what Linux expects.
+		 */
+		case LPSS_BYT_SSP:
+			return cs - 1;
+
+		default:
+			break;
+		}
+	}
+
+	return cs;
+}
+
 static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1497,6 +1519,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->setup = setup;
 	master->transfer_one_message = pxa2xx_spi_transfer_one_message;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
+	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
 	master->auto_runtime_pm = true;
 
 	drv_data->ssp_type = ssp->type;
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
