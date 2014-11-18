From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 2/2] mfd: dln2: add support for USB-SPI module
Date: Tue, 18 Nov 2014 14:09:59 +0200
Message-ID: <1416312599-5176-3-git-send-email-laurentiu.palcu@intel.com>
References: <1416312599-5176-1-git-send-email-laurentiu.palcu@intel.com>
Cc: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416312599-5176-1-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/mfd/dln2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 9765a17..0cdad2d 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -52,6 +52,7 @@ enum dln2_handle {
 	DLN2_HANDLE_CTRL,
 	DLN2_HANDLE_GPIO,
 	DLN2_HANDLE_I2C,
+	DLN2_HANDLE_SPI,
 	DLN2_HANDLES
 };
 
@@ -634,6 +635,12 @@ static struct dln2_platform_data dln2_pdata_i2c = {
 	.port = 0,
 };
 
+/* Only one SPI port supported */
+static struct dln2_platform_data dln2_pdata_spi = {
+	.handle = DLN2_HANDLE_SPI,
+	.port = 0,
+};
+
 static const struct mfd_cell dln2_devs[] = {
 	{
 		.name = "dln2-gpio",
@@ -645,6 +652,11 @@ static const struct mfd_cell dln2_devs[] = {
 		.platform_data = &dln2_pdata_i2c,
 		.pdata_size = sizeof(struct dln2_platform_data),
 	},
+	{
+		.name = "dln2-spi",
+		.platform_data = &dln2_pdata_spi,
+		.pdata_size = sizeof(struct dln2_platform_data),
+	},
 };
 
 static void dln2_disconnect(struct usb_interface *interface)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
