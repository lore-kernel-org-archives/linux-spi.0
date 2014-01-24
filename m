From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 1/3] spi: spi.h: clarify the documentation of transfer_one
Date: Fri, 24 Jan 2014 08:28:04 +0200
Message-ID: <39ffc897bd2e5fd48a3141ed4cd122a80c5bbb20.1390544495.git.baruch@tkos.co.il>
References: <cover.1390544495.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390544495.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Explicitly note the transfer_one and transfer_one_message are mutually
exclusive, to make the text a little more newcomers friendly.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 include/linux/spi/spi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba74dd91..060b21e82e73 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -285,7 +285,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @transfer_one: transfer a single spi_transfer. When the
  *	          driver is finished with this transfer it must call
  *	          spi_finalize_current_transfer() so the subsystem can issue
- *                the next transfer
+ *                the next transfer. Note: transfer_one and
+ *                transfer_one_message are mutually exclusive; when both are
+ *                set, transfer_one takes precedence.
  * @unprepare_message: undo any work done by prepare_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
