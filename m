From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 5/5] spi: bcm-qspi: Implement the master flash_pm_supported() call
Date: Fri,  3 Feb 2017 18:31:16 -0500
Message-ID: <1486164676-12912-6-git-send-email-kdasu.kdev@gmail.com>
References: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486164676-12912-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Broadcom SoCs needs pm rescan support for the flash device to
to be cofgured in the probed state on pm resume. Implement
flash_pm_supported() spi core interface to return true.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 14f9dea..0abcde6 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -958,6 +958,11 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 	return 0;
 }
 
+static bool bcm_qspi_flash_pm_supported(struct spi_device *spi)
+{
+	return true;
+}
+
 static void bcm_qspi_cleanup(struct spi_device *spi)
 {
 	struct bcm_qspi_parms *xp = spi_get_ctldata(spi);
@@ -1194,6 +1199,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->setup = bcm_qspi_setup;
 	master->transfer_one = bcm_qspi_transfer_one;
 	master->spi_flash_read = bcm_qspi_flash_read;
+	master->flash_pm_supported = bcm_qspi_flash_pm_supported;
 	master->cleanup = bcm_qspi_cleanup;
 	master->dev.of_node = dev->of_node;
 	master->num_chipselect = NUM_CHIPSELECT;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
