From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 2/2] mfd: dln2: add support for USB-SPI module
Date: Fri,  7 Nov 2014 14:45:14 +0200
Message-ID: <1415364314-30320-3-git-send-email-laurentiu.palcu@intel.com>
References: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
Cc: Octavian Purdila <octavian.purdila@intel.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
To: Mark Brown <broonie@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Johan Havold <johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@intel.com>
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
