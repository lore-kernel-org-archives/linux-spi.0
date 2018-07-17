From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Tue, 17 Jul 2018 15:19:55 -0700
Message-ID: <CAD=FV=W1LA3XFDDhD7wZOWF2wLoGA1xTbKkXJDj0t_BE13J0BA@mail.gmail.com>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 2:46 PM, Girish Mahadevan <girishm@codeaurora.org> wrote:
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
> +- compatible:  Should contain:
> +               "qcom,qspi-v1"
> +- reg:         Contains the base register location and length
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Contains the core and AHB clock names.
> +- clock-names: "core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:   Maximum SPI core clock frequency in Hz.
> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +       qspi: qspi@7418000 {
> +               compatible = "qcom,qspi-v1";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x7418000 0x600>;
> +               interrupts = <0 459 0>;

Please use a more proper interrupts example, AKA:
    interrupts = <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>;


> +               clock-names = "iface", "core";
> +               clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +                        <&clock_gcc clk_gcc_qspi_ser_clk>;

In upstream I believe that the clock #defines are usually in ALL CAPS.
Maybe good to use that in your example.  In the clock patches I'm
hoping to send up for SDM845, for instance, this will be:

clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
    <&gcc GCC_QSPI_CORE_CLK>;


> +
> +               device@0 {
> +                       compatible = "dummy_device";
> +                       reg = <x>; /* CS for the device */
> +                       spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */

Since you are a Quad SPI controller, maybe you'd want your example to
include how to enable that?  AKA:

spi-tx-bus-width = <4>;
spi-rx-bus-width = <4>;


-Doug
