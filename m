From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Sat, 10 Feb 2018 13:25:32 +0100
Message-ID: <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add a SW-controlled timer for inserting delays between individual words
as transmitted over the SPI bus. The DT property name is loosely
modelled after a similar, but HW-based feature in spi-davinci.c (commit
365a7bb32e09) -- hence the DT property name.

My HW sucks. One of the less-serious troubles is that it requires a 3us
delay between all SPI words. It also requires "big" transfers, easily
around 40kB, which is 20k of 16-bit words. It's also a specialised,
proprietary thing with no need for an in-kernel driver, so I'm using
spidev to access it.

There's a limit in spidev's SPI_IOC_MESSAGE and ioctl architecture in
general which means that I can stash at most 512 individual
spi_ioc_transfer into one ioctl. When I needed to transfer small
pockets, that was enough -- I could simply build a series of hundreds of
spi_ioc_trnasfers, two bytes each, with a proper delay_usecs to persuade
the SPI core to implement these delays for me. However, this won't work
if I need to send more than 1kB of data that way.

It seems that there's nothing generic in Linux to implement this
feature. The TI's spi-davinci.c can do something liek this in HW. People
at various forums apparently want to do something similar on Zynq and on
RPis, perhaps in SW. I wasn't able to find any ready-made patches,
though. My SoC (88F68xx, Marvell Armada A38x) apparently cannot do this
natively, so this patch simply adds a call to udelay which does the
trick for me.

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-orion.txt | 20 ++++++++++++++++++++
 drivers/spi/spi-orion.c                             | 19 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index 8434a65fc12a..ed35cba1bc33 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -29,6 +29,10 @@ Optional properties:
 		used, the name must be "core", and "axi" (the latter
 		is only for Armada 7K/8K).
 
+Optional properties of child nodes (SPI slave devices):
+- linux,spi-wdelay : If present and non-zero, specifies a delay in
+		     microseconds between words transferred over the SPI bus.
+
 
 Example:
        spi@10600 {
@@ -77,3 +81,19 @@ are used in the default indirect (PIO) mode):
 For further information on the MBus bindings, please see the MBus
 DT documentation:
 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
+
+Example of a per-child inter-word delay:
+
+	spi0: spi@10600 {
+		/* ... */
+
+		some_slave_device@2 {
+			reg = <2>;
+			compatible = "something";
+			/* ... */
+
+			/* Wait 3 microseconds between all words within all
+			SPI transactions */
+			linux,spi-wdelay = /bits/ 16 <3>;
+		};
+	};
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 1eccc2287079..1a9475857808 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -92,6 +92,7 @@ struct orion_direct_acc {
 
 struct orion_child_options {
 	struct orion_direct_acc direct_access;
+	u16			word_delay;
 };
 
 struct orion_spi {
@@ -469,6 +470,8 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 			if (orion_spi_write_read_8bit(spi, &tx, &rx) < 0)
 				goto out;
 			count--;
+			if (orion_spi->child[cs].word_delay)
+				udelay(orion_spi->child[cs].word_delay);
 		} while (count);
 	} else if (word_len == 16) {
 		const u16 *tx = xfer->tx_buf;
@@ -477,6 +480,8 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 		do {
 			if (orion_spi_write_read_16bit(spi, &tx, &rx) < 0)
 				goto out;
+			if (orion_spi->child[cs].word_delay)
+				udelay(orion_spi->child[cs].word_delay);
 			count -= 2;
 		} while (count);
 	}
@@ -681,7 +686,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out_rel_axi_clk;
 	}
 
-	/* Scan all SPI devices of this controller for direct mapped devices */
+	/* Scan all SPI devices of this controller for direct mapped devices and word delay */
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
 		u32 cs;
 
@@ -694,6 +699,12 @@ static int orion_spi_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		spi->child[cs].word_delay = 0;
+		if (!of_property_read_u16(np, "linux,spi-wdelay",
+					&spi->child[cs].word_delay))
+			dev_info(&pdev->dev, "%pOF: %dus delay between words\n",
+					np, spi->child[cs].word_delay);
+
 		/*
 		 * Check if an address is configured for this SPI device. If
 		 * not, the MBus mapping via the 'ranges' property in the 'soc'
@@ -705,6 +716,12 @@ static int orion_spi_probe(struct platform_device *pdev)
 		if (status)
 			continue;
 
+		if (spi->child[cs].word_delay) {
+			dev_warn(&pdev->dev,
+				"%pOF linux,spi-wdelay takes preference over a direct-mode", np);
+			continue;
+		}
+
 		/*
 		 * Only map one page for direct access. This is enough for the
 		 * simple TX transfer which only writes to the first word.
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
