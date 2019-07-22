From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/4][V3] iio: imu: adis: Add support for SPI transfer cs_change_delay
Date: Mon, 22 Jul 2019 15:47:45 +0300
Message-ID: <20190722124747.4792-3-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The ADIS16460 requires a higher delay before the next transfer. Since the
SPI framework supports configuring the delay before the next transfer, this
driver will become the first user of it.

The support for this functionality in ADIS16460 requires an addition to the
ADIS lib to support the `cs_change_delay` functionality in SPI.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       | 6 ++++++
 include/linux/iio/imu/adis.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index c771ae6803a9..47f64a6bbc69 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -40,18 +40,21 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -134,12 +137,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -147,6 +152,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
+			.cs_change_delay = adis->data->cs_change_delay,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 469a493f7ae0..fd884b45ed45 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -27,6 +27,7 @@ struct adis_burst;
  * struct adis_data - ADIS chip variant specific data
  * @read_delay: SPI delay for read operations in us
  * @write_delay: SPI delay for write operations in us
+ * @cs_change_delay: SPI delay between CS changes in us
  * @glob_cmd_reg: Register address of the GLOB_CMD register
  * @msc_ctrl_reg: Register address of the MSC_CTRL register
  * @diag_stat_reg: Register address of the DIAG_STAT register
@@ -36,6 +37,7 @@ struct adis_burst;
 struct adis_data {
 	unsigned int read_delay;
 	unsigned int write_delay;
+	unsigned int cs_change_delay;
 
 	unsigned int glob_cmd_reg;
 	unsigned int msc_ctrl_reg;
-- 
2.20.1
