From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 1/2] spi: dts: Add new device property to
 specifcy a wait time between word transmissions
Date: Thu, 17 Dec 2015 12:40:26 +0100
Message-ID: <1450352427-25350-2-git-send-email-mweseloh42@gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRB3V6ZKZQKGQELO2KEWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1450352427-25350-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Adds a new property "spi-word-wait-ns" to the spi-bus binding that allows
SPI slave devices to set a wait time between the transmission of words.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
 drivers/spi/spi.c                                 | 2 ++
 include/linux/spi/spi.h                           | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index bbaa857..434d321 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -61,6 +61,8 @@ contain the following properties.
                       used for MOSI. Defaults to 1 if not present.
 - spi-rx-bus-width - (optional) The bus width(number of data wires) that
                       used for MISO. Defaults to 1 if not present.
+- spi-word-wait-ns - (optional) Delay between transmission of words
+                      in nanoseconds
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2b0a8ec..186373b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1467,6 +1467,8 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	if (of_find_property(nc, "spi-lsb-first", NULL))
 		spi->mode |= SPI_LSB_FIRST;
 
+	of_property_read_u32(nc, "spi-word-wait-ns", &spi->word_wait_ns);
+
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
 		switch (value) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6..ea3037f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -118,6 +118,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	when not using a GPIO line)
+ * @word_wait_ns: A wait time between word transfers in nanoseconds
  *
  * @statistics: statistics for the spi_device
  *
@@ -158,6 +159,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	u32			word_wait_ns;	/* wait time between words */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
1.9.1
