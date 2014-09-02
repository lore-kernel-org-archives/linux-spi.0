From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/9] spi: orion: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:51:39 +0900
Message-ID: <002501cfc658$d1c760c0$75562240$%han@samsung.com>
References: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jason Cooper' <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002101cfc658$4f627cf0$ee2776d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: else is not generally useful after a break or return
  WARNING: Missing a blank line after declarations

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-orion.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index c4675fa8b645..345e7d61c399 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -179,8 +179,8 @@ static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
 	for (i = 0; i < ORION_SPI_WAIT_RDY_MAX_LOOP; i++) {
 		if (readl(spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG)))
 			return 1;
-		else
-			udelay(1);
+
+		udelay(1);
 	}
 
 	return -1;
@@ -360,6 +360,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		master->bus_num = pdev->id;
 	if (pdev->dev.of_node) {
 		u32 cell_index;
+
 		if (!of_property_read_u32(pdev->dev.of_node, "cell-index",
 					  &cell_index))
 			master->bus_num = cell_index;
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
