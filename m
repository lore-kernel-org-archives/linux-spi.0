From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/4] iio: imu: adis: convert cs_change_delay to spi_delay struct
Date: Fri, 13 Sep 2019 14:55:49 +0300
Message-ID: <20190913115549.3823-5-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913115549.3823-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The ADIS library is one of the few users of the new `cs_change_delay`
parameter for an spi_transfer.

The introduction of the `spi_delay` struct, requires that the users of of
`cs_change_delay` get an update. This change updates the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..2cd2cc2316c6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
-- 
2.20.1
