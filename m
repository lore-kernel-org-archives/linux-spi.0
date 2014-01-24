From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 2/3] Doc: spi: document the transfer_one spi_master callback
Date: Fri, 24 Jan 2014 10:36:29 +0200
Message-ID: <1abe062855111800754477d1340635b5a69d5635.1390552232.git.baruch@tkos.co.il>
References: <cover.1390552232.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390552232.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 Documentation/spi/spi-summary | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index f21edb983413..735acbf1ce0c 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -545,6 +545,16 @@ SPI MASTER METHODS
 	spi_finalize_current_message() so the subsystem can issue the next
 	transfer. This may sleep.
 
+    master->transfer_one(struct spi_master *master, struct spi_device *spi,
+			 struct spi_transfer *transfer)
+	The subsystem calls the driver to transfer a single transfer while
+	queuing transfers that arrive in the meantime. When the driver is
+	finished with this message, it must call
+	spi_finalize_current_transfer() so the subsystem can issue the next
+	transfer. This may sleep. Note: transfer_one and transfer_one_message
+	are mutually exclusive; when both are set, the generic subsystem does
+	not call your transfer_one callback.
+
     DEPRECATED METHODS
 
     master->transfer(struct spi_device *spi, struct spi_message *message)
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
