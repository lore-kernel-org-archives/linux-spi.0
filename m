From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: clarify what driver can do with message->status
Date: Tue, 24 Feb 2015 12:04:09 +0200
Message-ID: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently it's unclear from the documentation if an actual driver may or may
not override the message->status field. It seems there is no other way to
indicate an error when transfer is failed, e.g. when gets overrun or underrun
interrupt. The patch states this clearly in the comments near to field
definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ed9489d..92cff9a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -680,6 +680,9 @@ struct spi_message {
 	void			*context;
 	unsigned		frame_length;
 	unsigned		actual_length;
+
+	/* The actual driver may set this field to indicate an error, e.g. -EIO
+	 * for failed transfer. */
 	int			status;
 
 	/* for optional use by whatever driver currently owns the
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
