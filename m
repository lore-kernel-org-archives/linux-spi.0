From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [RFC 2/2] spi core: Add new sysfs 'num_chipselect' file
Date: Mon, 18 Apr 2016 16:48:28 +0530
Message-ID: <1460978308-8062-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gregkh@linuxfoundation.org>, <stefan@agner.ch>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
	Stefan Agner <stefan.agner@toradex.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add new sysfs 'num_chipselect' file to expose the maximum number
of chipselects a SPI master can support.
This allows to create a script in user space which automatically
creates a new spidev instance for every chipselect on a bus.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 Documentation/spi/spi-summary |  3 +++
 drivers/spi/spi.c             | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index d1824b3..b4d15e4 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -181,6 +181,9 @@ shows up in sysfs in several locations:
 	controller managing bus "B".  All spiB.* devices share one
 	physical SPI bus segment, with SCLK, MOSI, and MISO.
 
+   /sys/class/spi_master/spiB/num_chipselect ... exposes the maximum
+	number of chipselects a SPI master can support.
+
 Note that the actual location of the controller's class state depends
 on whether you enabled CONFIG_SYSFS_DEPRECATED or not.  At this time,
 the only class-specific state is the bus number ("B" in "spiB"), so
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f9..c3eb29f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -67,6 +67,19 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t
+num_chipselect_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct spi_master *master = container_of(dev,
+						 struct spi_master, dev);
+
+	return sprintf(buf, "%d\n", master->num_chipselect);
+}
+static struct device_attribute dev_attr_num_chipselect = {
+	.attr = { .name = "num_chipselect", .mode = S_IRUGO },
+	.show = num_chipselect_show,
+};
+
 #define SPI_STATISTICS_ATTRS(field, file)				\
 static ssize_t spi_master_##field##_show(struct device *dev,		\
 					 struct device_attribute *attr,	\
@@ -155,6 +168,15 @@ static const struct attribute_group spi_dev_group = {
 	.attrs  = spi_dev_attrs,
 };
 
+static struct attribute *spi_master_attrs[] = {
+	&dev_attr_num_chipselect.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_master_group = {
+	.attrs  = spi_master_attrs,
+};
+
 static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_messages.attr,
 	&dev_attr_spi_device_transfers.attr,
@@ -236,6 +258,7 @@ static const struct attribute_group spi_master_statistics_group = {
 };
 
 static const struct attribute_group *spi_master_groups[] = {
+	&spi_master_group,
 	&spi_master_statistics_group,
 	NULL,
 };
-- 
2.7.3
