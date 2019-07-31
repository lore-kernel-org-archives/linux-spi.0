From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute
Date: Wed, 31 Jul 2019 14:47:38 +0200
Message-ID: <20190731124738.14519-1-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert the SPI slave control sysfs attribute from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae5267b7..9fd7926e80c07681 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2105,8 +2105,8 @@ static int match_true(struct device *dev, void *data)
 	return 1;
 }
 
-static ssize_t spi_slave_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2117,9 +2117,8 @@ static ssize_t spi_slave_show(struct device *dev,
 		       child ? to_spi_device(child)->modalias : NULL);
 }
 
-static ssize_t spi_slave_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf,
-			       size_t count)
+static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2157,7 +2156,7 @@ static ssize_t spi_slave_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(slave, 0644, spi_slave_show, spi_slave_store);
+static DEVICE_ATTR_RW(slave);
 
 static struct attribute *spi_slave_attrs[] = {
 	&dev_attr_slave.attr,
-- 
2.17.1
