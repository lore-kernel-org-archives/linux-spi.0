From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: dts: sun4i: Add support for inter-word
 wait cycles using the SPI Wait Clock Register
Date: Fri, 11 Dec 2015 23:45:39 +0100
Message-ID: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRBJFEVWZQKGQEDJ4ZK2I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Adds support and binding documentation for a new slave device property
"sun4i,spi-word-wait-ns" that allows to set a hardware based delay
between the transmission of words using the SPI Wait Clock Register.
The SPI hardware needs 3 clock cycles to set up the delay, which makes
the minimum non-zero wait time 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes from v1:
 * renamed the property for more clarity
 * wait time is set in nanoseconds instead of number of clock cycles
 * transparently handle the 3 setup clock cycles

There is one review comment that I didn't address: Rob Herring suggested
that this should be in the core-binding rather than in sun4i. I checked
many of the hardware manuals of other SPI drivers and it looks to me like
this hardware based inter-word delay is a feature that not many SPI
controllers offer. And the SPI core currently has no way to control an
inter-word delay, only inter-message. So I would like to propose this again
as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
feature.
---
 .../devicetree/bindings/spi/spi-sun4i.txt          | 11 +++++++++++
 drivers/spi/spi-sun4i.c                            | 23 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
index de827f5..d6c55fc 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
@@ -10,6 +10,10 @@ Required properties:
   - "mod": the parent module clock
 - clock-names: Must contain the clock names described just above
 
+Optional properties for slave devices:
+- sun4i,spi-word-wait-ns: hardware based delay in nanoseconds between
+			  transmission of words
+
 Example:
 
 spi1: spi@01c06000 {
@@ -21,4 +25,11 @@ spi1: spi@01c06000 {
 	status = "disabled";
 	#address-cells = <1>;
 	#size-cells = <0>;
+
+	spi1_0 {
+		compatible = "example,dummy";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		sun4i,spi-word-wait-ns = <12000>;
+	};
 };
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..8cfd96c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 
@@ -173,6 +174,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	u32 wait_ns = 0;
+	int wait_clk = 0;
+	int clk_ns = 0;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -261,6 +265,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/* Setup wait time beteen words */
+	of_property_read_u32(spi->dev.of_node, "sun4i,spi-word-wait-ns",
+			     &wait_ns);
+	if (wait_ns) {
+		/* The wait time is set in SPI_CLK cycles. The SPI hardware
+		 * needs 3 additional cycles to setup the wait counter, so
+		 * the minimum delay time is 4 cycles.
+		 */
+		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
+		wait_clk = DIV_ROUND_UP(wait_ns, clk_ns) - 3;
+		if (wait_clk < 1) {
+			wait_clk = 1;
+			dev_info(&spi->dev,
+				 "using minimum of 4 word wait cycles (%uns)",
+				 4 * clk_ns);
+		}
+	}
+	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
+
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
-- 
1.9.1
