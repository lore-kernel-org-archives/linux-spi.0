From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: add DT binding for clps711x SPI
Date: Tue, 12 Jul 2016 15:49:47 -0500
Message-ID: <20160712204947.GA6182@rob-hp-laptop>
References: <20160707094952.4111577-1-arnd@arndb.de>
 <20160707094952.4111577-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160707094952.4111577-2-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 07, 2016 at 11:49:46AM +0200, Arnd Bergmann wrote:
> This documents the binding used by Alexander Shiyan's DT support for
> the clps711x SPI controller.
> 
> I've left the file name to match the ARM platform port name "clps711x"
> for consistency with the other bindings, even though the compatible
> string refers to the later ep7309 chip.
> 
> Linux no longer supports the old clps711x and ep72xx product lines,
> but we still use the name. The entire family is now discontinued
> by the manufacturer.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/spi/spi-clps711x.txt       | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-clps711x.txt b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
> new file mode 100644
> index 000000000000..4c3ec13f423f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-clps711x.txt
> @@ -0,0 +1,33 @@
> +Serial Peripheral Interface on Cirrus Logic CL-PS71xx, EP72xx, EP73xx
> +
> +Required properties
> +- #address-cells: must be <1>
> +- #size-cells: must be <0>
> +- compatible: should include "cirrus,ep7209-spi"
> +- reg: Address and length of one register range
> +- interrupts: one interrupt line
> +- clocks: One entry, refers to the SPI bus clock
> +- cs-gpios: Specifies the gpio pins to be used for chipselects.
> +	    See: Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +An additional register is present in the system controller,
> +which is assumed to be in the same device tree, with and marked
> +as compatible with "cirrus,ep7209-syscon3".
> +
> +Example:
> +
> +spi@80000500 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "cirrus,ep7209-spi";
> +	reg = <0x80000500 0x4>;
> +	interrupts = <15>;
> +	clocks = <&clks CLPS711X_CLK_SPI>;
> +	status = "disabled";
> +};
> +
> +syscon3: syscon@80002200 {

This looks like it shouldn't be here.

> +	compatible = "cirrus,ep7209-syscon3", "syscon";
> +	reg = <0x80002200 0x40>;
> +};
> +
> -- 
> 2.9.0
> 
