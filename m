From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH linux-next v5 4/5] Documentation: atmel-quadspi: add
 binding file for Atmel QSPI driver
Date: Tue, 8 Sep 2015 18:29:20 -0500
Message-ID: <55EF6F50.5020006@kernel.org>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <793cb906c79eed821cf9b47e79dc1b54a7a5dbd0.1440580764.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux-mtd@lists.infradead.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>,
	nicolas.ferre@atmel.com, broonie@kernel.org,
	linux-spi@vger.kernel.org, dwmw2@infradead.org,
	computersforpeace@gmail.com, zajec5@gmail.com, beanhuo@micron.com,
	juhosg@openwrt.org, marex@denx.de, shijie.huang@intel.com,
	ben@decadent.org.uk
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <793cb906c79eed821cf9b47e79dc1b54a7a5dbd0.1440580764.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/26/2015 07:30 AM, Cyrille Pitchen wrote:
> This patch documents the DT bindings for the driver of the Atmel QSPI
> controller embedded inside sama5d2x SoCs.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Marek Vasut <marex@denx.de>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/mtd/atmel-quadspi.txt      | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> new file mode 100644
> index 000000000000..0b8d545bb198
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
> @@ -0,0 +1,29 @@
> +* Atmel Quad Serial Peripheral Interface (QSPI)
> +
> +Required properties:
> +- compatible:     should be "atmel,sama5d2-qspi"
> +- reg:            the first contains the register location and length,
> +                  the second contains the memory mapping address and length
> +- interrupts:     should contain the interrupt for the device
> +- clocks:         the phandle of the clock needed by the QSPI controller
> +- #address-cells: should be <1>
> +- #size-cells:    should be <0>
> +
> +Example:
> +
> +spi@f0020000 {
> +	compatible = "atmel,sama5d2-qspi";
> +	reg = <0xf0020000 0x100>,
> +	      <0xd0000000 0x8000000>;
> +	interrupts = <52 IRQ_TYPE_LEVEL_HIGH 7>;
> +	clocks = <&spi0_clk>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi0_default>;
> +	status = "okay";
> +
> +	m25p80@0 {
> +		...
> +	};
> +};
> 
