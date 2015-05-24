From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: add missing cleanup in spi_map_msg on error
Date: Sun, 24 May 2015 09:34:46 +0000
Message-ID: <1432460086-2549-1-git-send-email-kernel@martin.sperl.org>
References: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

applies against for-next

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a1..a73d9e4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
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
