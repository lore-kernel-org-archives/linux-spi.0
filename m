From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/4] spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail
Date: Mon,  8 Feb 2016 17:14:29 +0200
Message-ID: <1454944471-50119-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1454944471-50119-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bastien Nocera <bugzilla@hadess.net>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454944471-50119-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ab9914ad8365..7c795cfbbf9d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1438,6 +1438,28 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
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
@@ -1490,6 +1512,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->setup = setup;
 	master->transfer_one_message = pxa2xx_spi_transfer_one_message;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
+	master->fw_translate_cs = pxa2xx_spi_fw_translate_cs;
 	master->auto_runtime_pm = true;
 
 	drv_data->ssp_type = ssp->type;
-- 
2.7.0
