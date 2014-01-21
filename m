From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH v2 2/5] spi: Clarify transfer_one() w.r.t. spi_finalize_current_transfer()
Date: Tue, 21 Jan 2014 16:10:06 +0100
Message-ID: <1390317009-8292-2-git-send-email-geert@linux-m68k.org>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390317009-8292-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
v2: Rephrased

 include/linux/spi/spi.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 21a7251d85ee..ba69940a6515 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -282,10 +282,12 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @prepare_message: set up the controller to transfer a single message,
  *                   for example doing DMA mapping.  Called from threaded
  *                   context.
- * @transfer_one: transfer a single spi_transfer. When the
- *	          driver is finished with this transfer it must call
- *	          spi_finalize_current_transfer() so the subsystem can issue
- *                the next transfer
+ * @transfer_one: transfer a single spi_transfer.
+ *                  - return 0 if the transfer is finished,
+ *                  - return 1 if the transfer is still in progress. When
+ *                    the driver is finished with this transfer it must
+ *                    call spi_finalize_current_transfer() so the subsystem
+ *                    can issue the next transfer
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
