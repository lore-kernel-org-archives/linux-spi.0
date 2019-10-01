From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Date: Tue, 1 Oct 2019 07:02:03 -0500
Message-ID: <20191001120203.GA28106@bogus>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> Note in the bindings documentation that pclk should be renamed if a clock
> domain is used to enable the optional bus clock.
> 
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> ---
> v2: Introduced this patch.
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> index f54c8c3..3ed08ee 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> @@ -16,7 +16,8 @@ Required properties:
>  Optional properties:
>  - clock-names : Contains the names of the clocks:
>      "ssi_clk", for the core clock used to generate the external SPI clock.
> -    "pclk", the interface clock, required for register access.
> +    "pclk", the interface clock, required for register access. If a clock domain
> +     used to enable this clock then it should be named "pclk_clkdomain".

What's a clock domain?

Unless this is a h/w difference in the IP block, then this change 
doesn't make sense.

>  - cs-gpios : Specifies the gpio pins to be used for chipselects.
>  - num-cs : The number of chipselects. If omitted, this will default to 4.
>  - reg-io-width : The I/O register width (in bytes) implemented by this
> -- 
> 2.7.4
> 
