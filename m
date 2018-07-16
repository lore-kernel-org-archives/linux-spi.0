From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Date: Mon, 16 Jul 2018 16:27:21 -0600
Message-ID: <20180716222721.GA12854@rob-hp-laptop>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 05, 2018 at 03:46:41PM -0600, Girish Mahadevan wrote:
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++++++++
>  err.txt                                            | 27 ----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
>  delete mode 100644 err.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 0000000..3baa893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)
> +
> +QSPI [Quad Serial Peripheral Interface] allows single dual and quad read/write
> +access to slaves. QTI's QSPI controller implements the QSPI protocol to interface
> +with slaves like NOR Flash devices.
> +
> +Required properties:
> +- compatible:	Should contain:
> +		"qcom,qspi-v1"

Needs an SoC specific compatible string.

> +- reg:		Contains the base register location and length
> +- interrupts:	Interrupt number used by the controller.
> +- clocks:	Contains the core and AHB clock names.
> +- clock-names:	"core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:	Maximum SPI core clock frequency in Hz.

This goes in the slave device nodes.

> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +	qspi: qspi@7418000 {
> +		compatible = "qcom,qspi-v1";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x7418000 0x600>;
> +		interrupts = <0 459 0>;
> +		clock-names = "iface", "core";
> +		clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +			 <&clock_gcc clk_gcc_qspi_ser_clk>;
> +
> +		device@0 {
> +			compatible = "dummy_device";

Why don't you use an actual NOR flash chip here.

> +			reg = <x>; /* CS for the device */

It's an example, show a CS#.

> +			spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */
> +		};
> +	};
