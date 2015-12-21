From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v2 7/8] spi: loopback-test: change module parameter name to have_external_loopback
Date: Mon, 21 Dec 2015 11:52:50 +0000
Message-ID: <1450698772-2379-8-git-send-email-kernel@martin.sperl.org>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Change the "loopback" module parameter to "have_external_loopback".

Also change variable name "loopback" to "check_rx_buf", which better
describes the meaning of the variable - have_external_loopback maps
to that, as when we have an external_loopback situation, then we can
check the rx_buf if it contains valid data.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 930e7c2..b42d1a8 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -47,12 +47,12 @@ MODULE_PARM_DESC(dump_messages,
 		 "BIT(2) - also dump the spi_message data after processing, "
 		 "BIT(3) - also dump the spi_message data before processing");

-/* the device is jumpered for loopback - enabling some rx_buf tests */
-int loopback;
-module_param(loopback, int, 0);
-MODULE_PARM_DESC(loopback,
-		 "if set enable loopback mode, where the rx_buf "	\
-		 "is checked to match tx_buf after the spi_message "	\
+/* the device is jumpered for external loopback - enabling some rx_buf tests */
+int check_rx_buf;
+module_param_named(have_external_loopback, check_rx_buf, int, 0);
+MODULE_PARM_DESC(have_external_loopback,
+		 "if set enable external loopback mode, where the rx_buf "
+		 "is checked to match tx_buf after the spi_message "
 		 "is executed");

 /* run only a specific test */
@@ -455,7 +455,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 		return ret;

 	/* if we run without loopback, then return now */
-	if (!loopback)
+	if (!check_rx_buf)
 		return 0;

 	/* if applicable to transfer check that rx_buf is equal to tx_buf */
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
