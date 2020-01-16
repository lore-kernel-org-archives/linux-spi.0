From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: [PATCH 5.4 168/203] spi: pxa2xx: Set controller->max_transfer_size in dma mode
Date: Fri, 17 Jan 2020 00:18:05 +0100
Message-ID: <20200116231759.290885917@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116231745.218684830-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>

commit b2662a164f9dc48da8822e56600686d639056282 upstream.

In DMA mode we have a maximum transfer size, past that the driver
falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
Falling back to PIO for big transfers defeats the point of a dma engine,
hence set the max transfer size to inform spi clients that they need
to do something smarter.

This was uncovered by the drm_mipi_dbi spi panel code, which does
large spi transfers, but stopped splitting them after:

commit e143364b4c1774f68e923a5a0bb0fca28ac25888
Author: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Date:   Fri Jul 19 17:59:10 2019 +0200

    drm/tinydrm: Remove tinydrm_spi_max_transfer_size()

After this commit the code relied on the spi core to split transfers
into max dma-able blocks, which also papered over the PIO fallback issue.

Fix this by setting the overall max transfer size to the DMA limit,
but only when the controller runs in DMA mode.

Fixes: e143364b4c17 ("drm/tinydrm: Remove tinydrm_spi_max_transfer_size()")
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-and-tested-by: Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Link: https://lore.kernel.org/r/20191017064426.30814-1-daniel.vetter-/w4YWyX8dFk@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

---
 drivers/spi/spi-pxa2xx.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1612,6 +1612,11 @@ static int pxa2xx_spi_fw_translate_cs(st
 	return cs;
 }
 
+static size_t pxa2xx_spi_max_dma_transfer_size(struct spi_device *spi)
+{
+	return MAX_DMA_LEN;
+}
+
 static int pxa2xx_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1717,6 +1722,8 @@ static int pxa2xx_spi_probe(struct platf
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
 			controller->max_dma_len = MAX_DMA_LEN;
+			controller->max_transfer_size =
+				pxa2xx_spi_max_dma_transfer_size;
 		}
 	}
 
