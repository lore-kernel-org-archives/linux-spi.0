From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: pxa2xx: Fix cs_change management
Date: Sun, 20 Mar 2016 19:30:17 +0100
Message-ID: <1458498617-11566-1-git-send-email-christophe-h.ricard@st.com>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christophe-h.ricard-qxv4g6HH51o@public.gmane.org,
	benoit.houyere-qxv4g6HH51o@public.gmane.org, jean-luc.blanc-qxv4g6HH51o@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix cs_change management so that it is in line with other spi drivers.

In the spi core api helpers such as spi_bus_lock/unlock and spi_sync_locked
or cs_change field in spi_transfer help to manage chip select from the
device driver.

The driver was setting the chip select to idle if the message queue was
empty despite cs_change or other status field set by spi_bus_lock/unlock
or spi_sync_locked.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ab9914a..ed034ed 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -532,9 +532,8 @@ static void giveback(struct driver_data *drv_data)
 		/* see if the next and current messages point
 		 * to the same chip
 		 */
-		if (next_msg && next_msg->spi != msg->spi)
-			next_msg = NULL;
-		if (!next_msg || msg->state == ERROR_STATE)
+		if ((next_msg && next_msg->spi != msg->spi) ||
+		    msg->state == ERROR_STATE)
 			cs_deassert(drv_data);
 	}
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
