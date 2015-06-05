From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [LINUX RFC V2 1/2] devicetree: Add DT bindings documentation for
 Zynq Ultrascale+ MPSoC GQSPI controller
Date: Fri, 5 Jun 2015 09:00:17 -0700
Message-ID: <20150605160017.GA8863@xsjsorenbubuntu>
References: <1433509653-15142-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<michal.simek@xilinx.com>, <broonie@kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<harinik@xilinx.com>, <punnaia@xilinx.com>, <ran27jit@gmail.com>
To: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433509653-15142-1-git-send-email-ranjit.waghmode@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 2015-06-05 at 06:37PM +0530, Ranjit Waghmode wrote:
> Add bindings documentation for GQSPI controller driver used by
> Zynq Ultrascale+ MPSoC
>=20
> Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
> ---
> No changes in v2
> ---
>  .../devicetree/bindings/spi/spi-zynqmp-qspi.txt    | 26 ++++++++++++=
++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-zynqmp-=
qspi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.tx=
t b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> new file mode 100644
> index 0000000..cec6330
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.txt
> @@ -0,0 +1,26 @@
> +Xilinx Zynq UltraScale+ MPSoC GQSPI controller Device Tree Bindings
> +-------------------------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "xlnx,zynqmp-qspi-1.0".
> +- reg			: Physical base address and size of GQSPI registers map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number.
> +- interrupt-parent	: Must be core interrupt controller.
> +- clock-names		: List of input clock names - "ref_clk", "pclk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +
> +Optional properties:
> +- num-cs		: Number of chip selects used.
> +
> +Example:
> +	qspi: spi@ff0f0000 {
> +		compatible =3D "xlnx,zynqmp-qspi-1.0";
> +		clock-names =3D "ref_clk", "pclk";
> +		clocks =3D <&misc_clk &misc_clk>;
> +		interrupts =3D <0 15 4>;
> +		interrupt-parent =3D <&gic>;
> +		num-cs =3D <1>;
> +		reg =3D <0x0 0xff0f0000 0x1000 0x0 0xc0000000 0x8000000>;

Please make this
  reg =3D <0x0 0xff0f0000 0x1000>, <0x0 0xc0000000 0x8000000>;

  	S=C3=B6ren
