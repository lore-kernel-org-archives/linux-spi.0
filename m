From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH] spi: orion: Allow specifying which HW CS to use with a GPIO
 CS
Date: Tue, 23 Jan 2018 20:56:15 +0100
Message-ID: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit b28b9149b37f added support for using an additional GPIO pin for
Chip Select. According to that commit and to my understanding of a
semi-public datahseet, it seems that the SPI hardware really insists on
driving *some* HW CS signal whenever a SPI transaction is in progress.

The old code effectively forced the HW CS pin to be CS0. That means that
there could not be anything connected to the real CS0 signal when one
uses a GPIO CS. That assumption does not hold on e.g. Solidrun Clearfog
where some SOM models have a built-in SPI flash on SPI1, CS0.

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-orion.txt          | 22 ++++++++++++++++++++++
 drivers/spi/spi-orion.c                            | 10 +++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index 8434a65fc12a..c7027af04fb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -28,6 +28,11 @@ Optional properties:
 - clock-names : names of used clocks, mandatory if the second clock is
 		used, the name must be "core", and "axi" (the latter
 		is only for Armada 7K/8K).
+- orion-spi,cs-gpio-hw-cs : Because the SoC always wants to drive some HW Chip
+			    Select pin, it is necessary to specify which one
+			    should be used when Linux drives an additional
+			    GPIO as a software-controlled CS. Defaults to HW
+			    CS 0.
 
 
 Example:
@@ -74,6 +79,23 @@ are used in the default indirect (PIO) mode):
 			 <MBUS_ID(0x01, 0x5e) 0 0 0xf1100000 0x10000>,	/* SPI0-DEV1 */
 			 <MBUS_ID(0x01, 0x9a) 0 0 0xf1110000 0x10000>;	/* SPI1-DEV2 */
 
+
+Example with a GPIO CS to be driven by software in addition to HW CS3. This
+can be used when the board or the pinmux does not allow connections to HW CS
+pins, for example:
+
+	spi0: spi@10600 {
+		/* ... */
+		cs-gpios = <0>, <&gpio0 22 GPIO_ACTIVE_HIGH>, <0>;
+		orion-spi,cs-gpio-hw-cs = <3>;
+
+		something@1 {
+			reg = <1>;
+			/* this device should be now connected to a custom GPIO CS */
+		};
+	}
+
+
 For further information on the MBus bindings, please see the MBus
 DT documentation:
 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 482a0cf3b7aa..b1b0537b4450 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -96,6 +96,7 @@ struct orion_spi {
 	struct clk              *clk;
 	struct clk              *axi_clk;
 	const struct orion_spi_dev *devdata;
+	int			cs_hw_gpio;
 
 	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
 };
@@ -324,13 +325,13 @@ static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 	struct orion_spi *orion_spi;
 	int cs;
 
+	orion_spi = spi_master_get_devdata(spi->master);
+
 	if (gpio_is_valid(spi->cs_gpio))
-		cs = 0;
+		cs = orion_spi->cs_hw_gpio;
 	else
 		cs = spi->chip_select;
 
-	orion_spi = spi_master_get_devdata(spi->master);
-
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
 	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
 				ORION_SPI_CS(cs));
@@ -645,6 +646,9 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	tclk_hz = clk_get_rate(spi->clk);
 
+	if (!pdev->dev.of_node || of_property_read_u32(pdev->dev.of_node, "orion-spi,cs-gpio-hw-cs", &spi->cs_hw_gpio))
+		spi->cs_hw_gpio = 0;
+
 	/*
 	 * With old device tree, armada-370-spi could be used with
 	 * Armada XP, however for this SoC the maximum frequency is
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
