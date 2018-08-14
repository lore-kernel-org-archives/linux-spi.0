From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Date: Tue, 14 Aug 2018 14:21:22 -0600
Message-ID: <20180814202122.GA26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 
> This patch adds the binding documentation for Spreadtrum SPI
> controller device.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-sprd.txt |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> new file mode 100644
> index 0000000..06ff746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> @@ -0,0 +1,31 @@
> +Spreadtrum SPI Controller
> +
> +Required properties:
> +- compatible: Should be "sprd,sc9860-spi".
> +- reg: Offset and length of SPI controller register space.
> +- interrupts: Should contain SPI interrupt.
> +- clock-names: Should contain following entries:
> +	"spi" for SPI clock,
> +	"source" for SPI source (parent) clock,

Do the h/w block actually get this clock or the driver needs it? In the 
latter case, it should not be in DT.

> +	"enable" for SPI module enable clock.
> +- clocks: List of clock input name strings sorted in the same order
> +	as the clock-names property.
> +- #address-cells: The number of cells required to define a chip select
> +	address on the SPI bus. Should be set to 1.
> +- #size-cells: Should be set to 0.
> +
> +Optional properties:
> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
> +	converted to the delay clock cycles = interval number * 4 + 10.

There are read and write delay properties you can use.

> +
> +Example:
> +spi0: spi@70a00000{
> +	compatible = "sprd,sc9860-spi";
> +	reg = <0 0x70a00000 0 0x1000>;
> +	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	clock-names = "spi", "source","enable";
> +	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> +	sprd,spi-interval = <9>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +};
> -- 
> 1.7.9.5
> 
