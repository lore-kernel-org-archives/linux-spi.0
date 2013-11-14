From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv4 2/3] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Thu, 14 Nov 2013 14:03:52 +0200
Message-ID: <1384430633-23426-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384430633-23426-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Current I2C adapter id - client address "x-00yy" based device naming scheme
is not always stable enough to be used in name based matching, for instance
within ALSA SoC subsystem.

This is problematic in PC kind of platforms where I2C adapter numbers can
change due variable amount of bus controllers, probe order, add-on cards or
just because of BIOS settings.

This patch addresses the problem by using the ACPI device name with
"i2c-" prefix for ACPI enumerated I2C slaves. For them device name
"x-00yz" becomes "i2c-INTABCD:ij" after this patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f74af33..bc9a294 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -618,6 +618,22 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
 }
 EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
 
+static void i2c_dev_set_name(struct i2c_adapter *adap,
+			     struct i2c_client *client)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+
+	if (adev) {
+		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
+		return;
+	}
+
+	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
+	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
+		     client->addr | ((client->flags & I2C_CLIENT_TEN)
+				     ? 0xa000 : 0));
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -676,10 +692,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
 
-	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
-	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
-		     client->addr | ((client->flags & I2C_CLIENT_TEN)
-				     ? 0xa000 : 0));
+	i2c_dev_set_name(adap, client);
 	status = device_register(&client->dev);
 	if (status)
 		goto out_err;
-- 
1.8.4.2
