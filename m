From: "Jens Renner (EFE)" <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
Subject: [v2] spi: spi-xilinx: Use DT information for bits_per_word value
Date: Tue, 28 May 2013 16:05:41 +0200
Message-ID: <51A4B9B5.6010203@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patch overrides the default value of bits_per_word with the actual value
of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word
lengths. In case of a non-existing entry this will be ignored. 

Signed-off-by: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
---
Changes in v2:
- use of_property_read_u32() instead of of_get_property()
- added some documentation
- original patch v1 #2124911

Grant Likely - March 2, 2013, 9:22 p.m.

On Mon, 11 Feb 2013 17:28:01 +0100, "Jens Renner (EFE)" <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org> wrote:
> From: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
> 
> This patch overrides the default value of bits_per_word with the actual value
> of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word
> lengths.
> 
> Signed-off-by: Jens Renner <renner-Xf229rFC5gsb1SvskN2V4Q@public.gmane.org>
> ---
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index e1d7696..03abdfa 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -487,6 +487,12 @@ static int xilinx_spi_probe(struct platform_device *dev)
> 				       &len);
> 		if (prop && len >= sizeof(*prop))
> 			num_cs = __be32_to_cpup(prop);
> +
> +		/* override default number of bits per word */
> +		prop = of_get_property(dev->dev.of_node,
> +				       "xlnx,num-transfer-bits", &len);
> +		if (prop && len >= sizeof(*prop))
> +			bits_per_word = __be32_to_cpup(prop);

Hi Jens,

Please remember to update documentation when modifying a DT binding.

Also, if you use of_property_read_u32() the code will be a lot simpler.

g.

 drivers/spi/spi-xilinx.c                                     |   13 ++++++-------
 Documentation/devicetree/bindings/spi/spi-xilinx.txt         |   32 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index e1d7696..6859833 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -479,14 +479,13 @@ static int xilinx_spi_probe(struct platform_device *dev)

 #ifdef CONFIG_OF
        if (dev->dev.of_node) {
-               const __be32 *prop;
-               int len;
-
                /* number of slave select bits is required */
-               prop = of_get_property(dev->dev.of_node, "xlnx,num-ss-bits",
-                                      &len);
-               if (prop && len >= sizeof(*prop))
-                       num_cs = __be32_to_cpup(prop);
+               of_property_read_u32(dev->dev.of_node, "xlnx,num-ss-bits",
+                                    &num_cs);
+
+               /* override default number of bits per word */
+               of_property_read_u32(dev->dev.of_node, "xlnx,num-transfer-bits",
+                                    &bits_per_word);
        }
 #endif

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
new file mode 100644
index 0000000..768a1ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -0,0 +1,32 @@
+Xilinx SPI controller:
+
+Required properties:
+- compatible : Must be "xlnx,axi-1.02.a" or "xlnx,xps-spi-2.00.a"
+- interrupt-parent : reference to parent interrupt controller
+- interrupts : SPI controller interrupt
+- reg : SPI register location and length
+
+Optional properties:
+- xlnx,num-ss-bits : # of slave select bits
+- xlnx,num-transfer_bits : # of data transfer bits (defaults to 8)
+- xlnx,... : not considered by kernel module
+- #address-cells = <1> : if child nodes are defined
+- #size-cells = <0> : if child nodes are defined
+- Child nodes conforming to SPI bus binding
+
+Example with 3 slave select bits and 32 bit transfer size:
+
+       axi_spi_0: spi@40a00000 {
+               compatible = "xlnx,axi-spi-1.02.a", "xlnx,xps-spi-2.00.a";
+               interrupt-parent = <&axi_intc_0>;
+               interrupts = < 2 2 >;
+               reg = < 0x40a00000 0x10000 >;
+               xlnx,family = "spartan6";
+               xlnx,fifo-exist = <0x1>;
+               xlnx,instance = "axi_spi_0";
+               xlnx,num-ss-bits = <0x3>;
+               xlnx,num-transfer-bits = <0x20>;
+               xlnx,sck-ratio = <0x4>;
+               #address-cells = <1>;
+               #size-cells = <0>;
+       } ;

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
