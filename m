From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to state
 errata fixed
Date: Wed, 1 May 2019 15:07:11 -0500
Message-ID: <20190501200711.GA31231@bogus>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.o
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 26, 2019 at 08:05:51AM +0000, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add it to show the errata fixed.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 2d32641..32c4263d 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -10,6 +10,8 @@ Required properties:
>    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
>    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
> +  - "fsl,imx6ul-ecspi" ERR009165 fixed on i.MX6UL and later Soc
> +    (https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf)

What about other i.MX6 chips?

Seems like this is missing some fallbacks. The binding doc should make 
it clear what are all valid combinations of compatible strings.

>    - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
> -- 
> 2.7.4
> 
