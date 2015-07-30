From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 02/27] spi: xcomm: Export I2C module alias information
Date: Thu, 30 Jul 2015 18:18:27 +0200
Message-ID: <1438273132-20926-3-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/spi/spi-xcomm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index d0561a8d9f16..3c28e24b10f5 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -237,6 +237,7 @@ static const struct i2c_device_id spi_xcomm_ids[] = {
 	{ "spi-xcomm" },
 	{ },
 };
+MODULE_DEVICE_TABLE(i2c, spi_xcomm_ids);
 
 static struct i2c_driver spi_xcomm_driver = {
 	.driver = {
-- 
2.4.3
