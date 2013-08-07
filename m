From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH] SPI: Set SPI bits per words in an OF DeviceTree SPI node
Date: Wed, 7 Aug 2013 17:44:45 +0200
Message-ID: <201308071544.r77Fij2Y006649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch allows to set up the bits per word together with all other SPI
parameters in the SPI Node of the OF device tree

In the node, you then have to include the 'spi-bits' property.

Exemple:
	fpga-loader@7 {
		compatible = "cs,fpga-loader";
		spi-max-frequency = <10000000>;
		reg = <7>;
		spi-cs-high;
		spi-bits = <16>;
	};

Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

--- linux-3.8.13/drivers/spi/spi.c	2013-05-11 22:57:46.000000000 +0200
+++ linux/drivers/spi/spi.c	2013-08-06 18:19:30.000000000 +0200
@@ -870,6 +870,11 @@
 		if (of_find_property(nc, "spi-3wire", NULL))
 			spi->mode |= SPI_3WIRE;
 
+		/* Bits per word */
+		prop = of_get_property(nc, "spi-bits", &len);
+		if (prop && len >= sizeof(*prop))
+			spi->bits_per_word = prop[0];
+
 		/* Device speed */
 		prop = of_get_property(nc, "spi-max-frequency", &len);
 		if (!prop || len < sizeof(*prop)) {

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
