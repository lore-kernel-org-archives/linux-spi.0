From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 3/3] spi: correct the transfer_one_message documentation wording
Date: Fri, 24 Jan 2014 10:36:30 +0200
Message-ID: <c21dbf62389fa49a60ebca922a981c2e6b9f058c.1390552232.git.baruch@tkos.co.il>
References: <cover.1390552232.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390552232.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The transfer_one_message callback handles messages, not transfers.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 Documentation/spi/spi-summary | 2 +-
 include/linux/spi/spi.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 735acbf1ce0c..ea2f2da611a6 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -543,7 +543,7 @@ SPI MASTER METHODS
 	queuing transfers that arrive in the meantime. When the driver is
 	finished with this message, it must call
 	spi_finalize_current_message() so the subsystem can issue the next
-	transfer. This may sleep.
+	message. This may sleep.
 
     master->transfer_one(struct spi_master *master, struct spi_device *spi,
 			 struct spi_transfer *transfer)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f5a08c3f3e60..60b787ad4ed1 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -273,7 +273,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	message while queuing transfers that arrive in the meantime. When the
  *	driver is finished with this message, it must call
  *	spi_finalize_current_message() so the subsystem can issue the next
- *	transfer
+ *	message
  * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
