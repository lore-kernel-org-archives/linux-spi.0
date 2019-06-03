From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 23/57] drivers: spi: Use bus_find_device_by_acpi_dev match helper
Date: Mon,  3 Jun 2019 16:49:49 +0100
Message-ID: <1559577023-558-24-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Switch to the generic helper bus_find_device_by_acpi_dev.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/spi/spi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ecdd602..5224ded 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3634,11 +3634,6 @@ static int spi_acpi_controller_match(struct device *dev, const void *data)
 	return ACPI_COMPANION(dev->parent) == data;
 }
 
-static int spi_acpi_device_match(struct device *dev, void *data)
-{
-	return ACPI_COMPANION(dev) == data;
-}
-
 static struct spi_controller *acpi_spi_find_controller_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
@@ -3658,8 +3653,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 {
 	struct device *dev;
 
-	dev = bus_find_device(&spi_bus_type, NULL, adev, spi_acpi_device_match);
-
+	dev = bus_find_device(&spi_bus_type, NULL, adev, device_match_acpi_dev);
 	return dev ? to_spi_device(dev) : NULL;
 }
 
-- 
2.7.4
