From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Fri, 21 Sep 2018 10:30:57 -0700
Message-ID: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
References: <20180920224055.164856-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>, Ryan Case <ryandcase@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920224055.164856-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Quoting Ryan Case (2018-09-20 15:40:54)
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt=
 b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 000000000000..ecfb1e2bd520
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +Qualcomm Quad Serial Peripheral Interface (QSPI)
> +
> +The QSPI controller allows SPI protocol communication in single, dual, o=
r quad
> +wire transmission modes for read/write access to slaves such as NOR flas=
h.
> +
> +Required properties:
> +- compatible:  Should contain:
> +               "qcom,sdm845-qspi"

Does someone have a more generic compatible string that can be added
here to indicate the type of quad SPI controller this is? I really doubt
this is a one-off hardware block for the specific SDM845 SoC. =


> +- reg:         Should contain the base register location and length.
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Should contain the core and AHB clock.
> +- clock-names: Should be "core" for core clock and "iface" for AHB clock.
> +
