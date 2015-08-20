From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias when probing using DT
Date: Thu, 20 Aug 2015 09:07:31 +0200
Message-ID: <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

An SPI driver that supports both OF and legacy platforms, will have
both an OF and SPI ID table. This means that when built as a module,
the aliases will be filled from both tables, e.g:

$ modinfo cros_ec_spi | grep alias
alias:          spi:cros-ec-spi
alias:          of:N*T*Cgoogle,cros-ec-spi*

But currently the SPI core always report a module alias of the form
spi:<modalias>, e.g:

$ cat /sys/devices/12d40000.spi/spi_master/spi2/spi2.0/modalias
spi:cros-ec-spi

And also this spi:<modalias> is always reported to user-space as
MODALIAS regardless of the mechanism that was used to register the
device (i.e: OF or board code).

This means that OF-only drivers needs to have both OF and SPI id
tables that have to be kept in sync and also the dev node compatible
manufacturer prefix is stripped when reporting the MODALIAS. Which can
lead to issues if two vendors use the same SPI device name for example.

This patch changes the SPI core to report an OF related MODALIAS uevent
(of:N*T*C) env var instead so the module can be auto-loaded and also
the correct modalias is reported on sysfs, e.g:

$ cat /sys/devices/12d40000.spi/spi_master/spi2/spi2.0/modalias
of:Ncros-ecT<NULL>Cgoogle,cros-ec-spi

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/spi/spi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 08861a0233ca..beb7fb2b15c5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -59,6 +59,10 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 	const struct spi_device	*spi = to_spi_device(dev);
 	int len;
 
+	len = of_device_get_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
@@ -250,6 +254,10 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	const struct spi_device		*spi = to_spi_device(dev);
 	int rc;
 
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
-- 
2.4.3
