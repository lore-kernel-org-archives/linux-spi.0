From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v2 1/2] spi: support inter-word delay requirement for devices
Date: Fri, 25 Jan 2019 13:24:24 +0100
Message-ID: <20190125122425.30676-2-jonas@norrbonn.se>
References: <20190125122425.30676-1-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125122425.30676-1-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
 drivers/spi/spi.c                                 | 4 ++++
 include/linux/spi/spi.h                           | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..a5f20060676d 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
 		    Defaults to 1 if not present.
 - spi-rx-delay-us - Microsecond delay after a read transfer.
 - spi-tx-delay-us - Microsecond delay after a write transfer.
+- spi-word-delay-us - Microsecond delay between individual words of a transfer
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7c3237..cd4d4065eca2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1692,6 +1692,10 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 	spi->max_speed_hz = value;
 
+	if (!of_property_read_u32(nc, "spi-word-delay-us", &value)) {
+		spi->word_delay = value;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..e5200dd9d750 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -164,6 +164,7 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
 	int			cs_gpio;	/* chip select gpio */
+	uint16_t		word_delay;	/* inter-word delay (us) */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.19.1
