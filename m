From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Date: Mon, 15 Apr 2019 14:30:28 -0700
Message-ID: <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some SPI slaves expect bytes to be in least significant first order
and some expects most significant first oder.

This patch adds support for requesting SPI master controllers for
least significant first order using SPI_LSBYTE_FIRST mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 18 ++++++++++--------
 include/linux/spi/spi.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index bf4027b54a19..59b1e57cae74 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2982,14 +2982,16 @@ int spi_setup(struct spi_device *spi)
 
 	spi_set_cs(spi, false);
 
-	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
-			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
-			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
-			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
-			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
-			(spi->mode & SPI_LOOP) ? "loopback, " : "",
-			spi->bits_per_word, spi->max_speed_hz,
-			status);
+	dev_dbg(&spi->dev,
+		"setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
+		(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
+		(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
+		(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+		(spi->mode & SPI_LSBYTE_FIRST) ? "lsbyte, " : "",
+		(spi->mode & SPI_3WIRE) ? "3wire, " : "",
+		(spi->mode & SPI_LOOP) ? "loopback, " : "",
+		spi->bits_per_word, spi->max_speed_hz,
+		status);
 
 	return status;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 053abd22ad31..fc4d21b4c2e4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,7 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_LSBYTE_FIRST	0x10000		/* per-word bytes-on-wire */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.7.4
