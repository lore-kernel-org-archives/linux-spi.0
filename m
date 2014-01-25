From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 1/3] spi: spi.h: clarify the documentation of transfer_one
Date: Sat, 25 Jan 2014 22:36:13 +0200
Message-ID: <598dd86dc07d794d7cd19a3259ea71618ba150bd.1390681463.git.baruch@tkos.co.il>
References: <cover.1390681463.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390681463.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Explicitly note the transfer_one and transfer_one_message are mutually
exclusive, to make the text a little more newcomers friendly.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 include/linux/spi/spi.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 9f5242df9311..f5a08c3f3e60 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -287,7 +287,10 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                  - return 1 if the transfer is still in progress. When
  *                    the driver is finished with this transfer it must
  *                    call spi_finalize_current_transfer() so the subsystem
- *                    can issue the next transfer
+ *                    can issue the next transfer. Note: transfer_one and
+ *                    transfer_one_message are mutually exclusive; when both
+ *                    are set, the generic subsystem does not call your
+ *                    transfer_one callback.
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
