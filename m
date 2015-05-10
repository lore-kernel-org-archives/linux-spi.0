From: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/3] spi: Add addr_width field to struct spi_message
Date: Sun, 10 May 2015 22:47:31 +0800
Message-ID: <1431269253-22890-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Make SPI controller can get address width of the SPI device.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Based on git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git.
Tested on T1040RDB and T2080RDB.
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..c9cef2c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -682,6 +682,9 @@ struct spi_message {
 	unsigned		actual_length;
 	int			status;
 
+	/* deliver the address width of spi device to spi controller */
+	u8			addr_width;
+
 	/* for optional use by whatever driver currently owns the
 	 * spi_message ...  between calls to spi_async and then later
 	 * complete(), that's the spi_master controller driver.
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
