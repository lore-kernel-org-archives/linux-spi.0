From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2] spi: add missing cleanup in spi_map_msg on error
Date: Mon, 25 May 2015 10:10:29 +0000
Message-ID: <1432548630-2202-1-git-send-email-kernel@martin.sperl.org>
References: <1432460086-2549-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432460086-2549-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Changelog:
[V1 -> V2]: for the cleanup to work propperly cur_msg_mapped needs to be
            set, as spi_unmap_msg checks for this condition and will not
            clean up otherwise (which happened in V1)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a1..647a8bb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -552,6 +552,7 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 					  DMA_TO_DEVICE);
 			if (ret != 0)
 				return ret;
+			master->cur_msg_mapped = true;
 		}
 
 		if (xfer->rx_buf != NULL) {
@@ -563,11 +564,10 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 					      DMA_TO_DEVICE);
 				return ret;
 			}
+			master->cur_msg_mapped = true;
 		}
 	}
 
-	master->cur_msg_mapped = true;
-
 	return 0;
 }
 
@@ -620,6 +620,7 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 	struct spi_transfer *xfer;
 	void *tmp;
 	unsigned int max_tx, max_rx;
+	int ret;
 
 	if (master->flags & (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX)) {
 		max_tx = 0;
@@ -662,7 +663,11 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		}
 	}
 
-	return __spi_map_msg(master, msg);
+	ret = __spi_map_msg(master, msg);
+	if (ret)
+		spi_unmap_msg(master, msg);
+
+	return ret;
 }
 
 /*
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
