From: Adrian Fiergolski <adrian.fiergolski@cern.ch>
Subject: [PATCH] Add possibility to define bits-per-word property.
Date: Thu, 16 Feb 2017 14:39:10 +0100
Message-ID: <20170216133910.18278-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        Adrian Fiergolski <adrian.fiergolski@cern.ch>
To: <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Adrian Fiergolski <adrian.fiergolski@cern.ch>
---
 drivers/spi/spi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0239b45..d2267e9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1549,6 +1549,17 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	}
 	spi->max_speed_hz = value;
 
+	/* Device bits-per-word */
+	if( ! of_property_read_u32(nc, "spi-bits-per-word", &value) ){
+	  if( value > 32 )
+	    dev_warn(&master->dev,
+		     "bits-per-word %d not supported\n",
+		     value);
+	  else
+	    spi->bits_per_word = value;
+	}
+
+
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
 	spi->dev.of_node = nc;
@@ -1626,6 +1637,13 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 
 			spi->max_speed_hz = sb->connection_speed;
 
+			if(sb->data_bit_length > 32)
+				    dev_warn(&master->dev,
+					     "bits-per-word %d not supported\n",
+					     sb->data_bit_length);
+			else
+			  spi->bits_per_word = sb->data_bit_length;
+
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
 				spi->mode |= SPI_CPHA;
 			if (sb->clock_polarity == ACPI_SPI_START_HIGH)
--
2.9.3
