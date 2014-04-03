From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] devicetree: Add devicetree bindings documentation
 for Zynq Quad SPI
Date: Thu, 3 Apr 2014 10:50:48 -0700
Message-ID: <46a3a23e-786e-4acf-aa42-c3808b1a46d3@CH1EHSMHS028.ehs.local>
References: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <broonie@kernel.org>, <grant.likely@linaro.org>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<michal.simek@xilinx.com>, <kpc528@gmail.com>,
	<kalluripunnaiahchoudary@gmail.com>, <harinik@xilinx.com>,
	Punnaiah Choudary Kalluri <punnaia@xilinx.com>
To: Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ee057d8c-50d9-4d4b-ac86-d7c5fc44b1b0@TX2EHSMHS034.ehs.local>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Punnaiah,

On Thu, 2014-04-03 at 10:33PM +0530, Punnaiah Choudary Kalluri wrote:
> Add bindings documentation for Zynq Quad SPI driver.
>=20
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
>  .../devicetree/bindings/spi/spi-zynq-qspi.txt      |   26 ++++++++++=
++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qs=
pi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt =
b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> new file mode 100644
> index 0000000..88e00f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> @@ -0,0 +1,26 @@
> +Xilinx Zynq QSPI controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "xlnx,zynq-qspi-1.0".
> +- reg			: Physical base address and size of QSPI registers map.
> +- interrupts		: Property with a value describing the interrupt
> +			  number.
> +- interrupt-parent	: Must be core interrupt controller
> +- clock-names		: List of input clock names - "ref_clk", "aper_clk"
> +			  (See clock bindings for details).
> +- clocks		: Clock phandles (see clock bindings for details).
> +
> +Optional properties:
> +- num-cs		: Number of chip selects used.
> +
> +Example:
> +	qspi@e000d000 {
> +		compatible =3D "xlnx,zynq-qspi-1.0";
> +		clock-names =3D "ref_clk", "aper_clk";

These seem to be the SOC names of the clocks. Doesn't have the IP its
own naming for these clock inputs?

	S=C3=B6ren


