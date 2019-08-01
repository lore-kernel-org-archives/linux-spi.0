From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute" to the spi tree
Date: Thu,  1 Aug 2019 14:10:55 +0100 (BST)
Message-ID: <20190801131055.CB19E2742C48@ypsilon.sirena.org.uk>
References: <20190731124738.14519-1-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731124738.14519-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cc8b4659491d23577eb8992449d82c7f4f4fc170 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 31 Jul 2019 14:47:38 +0200
Subject: [PATCH] spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs
 attribute

Convert the SPI slave control sysfs attribute from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20190731124738.14519-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..9fd7926e80c0 100644
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
2.20.1
