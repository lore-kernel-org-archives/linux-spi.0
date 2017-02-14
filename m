From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 2/2] mtd: m25p80: Added pm ops support
Date: Tue, 14 Feb 2017 10:32:48 -0500
Message-ID: <1487086368-4118-3-git-send-email-kdasu.kdev@gmail.com>
References: <1487086368-4118-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487086368-4118-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Added power management ops for resume to be able to resan spi-nor
device and set it to right transfer modes in its probed state after
poweron. Some SoC implementations might  power down the spi-nor flash
and loose its initial settings on suspend. A resume should retore the
part to its probed state.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4df3b1..3ab30b2 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -324,10 +324,21 @@ static int m25p_remove(struct spi_device *spi)
 };
 MODULE_DEVICE_TABLE(of, m25p_of_table);
 
+#ifdef CONFIG_PM_SLEEP
+static int m25p_resume(struct device *dev)
+{
+	struct m25p *flash = dev_get_drvdata(dev);
+
+	return spi_nor_init(&flash->spi_nor);
+}
+#endif
+static SIMPLE_DEV_PM_OPS(m25p_pm_ops, NULL, m25p_resume);
+
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
 		.of_match_table = m25p_of_table,
+		.pm     = &m25p_pm_ops,
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
