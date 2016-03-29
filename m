From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Fix cs_change management" to the spi tree
Date: Tue, 29 Mar 2016 00:42:22 -0700
Message-ID: <E1akoIA-0007oY-3Y@finisterre>
References: <1458498617-11566-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458498617-11566-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Fix cs_change management

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

>From a52db659c79ceede44e2d5ca63ca058d49df8dea Mon Sep 17 00:00:00 2001
From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 20 Mar 2016 19:30:17 +0100
Subject: [PATCH] spi: pxa2xx: Fix cs_change management

Fix cs_change management so that it is in line with other spi drivers.

In the spi core api helpers such as spi_bus_lock/unlock and spi_sync_locked
or cs_change field in spi_transfer help to manage chip select from the
device driver.

The driver was setting the chip select to idle if the message queue was
empty despite cs_change or other status field set by spi_bus_lock/unlock
or spi_sync_locked.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 86c155aea0cf..0ce82db8e484 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -570,9 +570,8 @@ static void giveback(struct driver_data *drv_data)
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
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
