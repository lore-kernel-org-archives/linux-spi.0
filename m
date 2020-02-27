From: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Date: Thu, 27 Feb 2020 17:11:47 +0100
Message-ID: <20200227171147.32cc6fcf@collabora.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
        <20200226093703.19765-2-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200226093703.19765-2-p.yadav-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 26 Feb 2020 15:06:53 +0530
Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:

> Allow spi devices to express DTR receive and transmit capabilities via
> the properties "spi-rx-dtr" and "spi-tx-dtr".

Is the RX/TX granularity really useful?

> 
> Signed-off-by: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/spi/spi-controller.yaml        | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1e0ca6ccf64b..7a84debed213 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -120,6 +120,11 @@ patternProperties:
>          description:
>            Delay, in microseconds, after a read transfer.
>  
> +      spi-rx-dtr:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Device supports receiving in DTR mode.
> +
>        spi-tx-bus-width:
>          allOf:
>            - $ref: /schemas/types.yaml#/definitions/uint32
> @@ -132,6 +137,11 @@ patternProperties:
>          description:
>            Delay, in microseconds, after a write transfer.
>  
> +      spi-tx-dtr:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Device supports transmitting in DTR mode.
> +
>      required:
>        - compatible
>        - reg
