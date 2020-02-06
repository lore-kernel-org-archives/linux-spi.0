From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 4/5] dt-bindings: spi: spi-nxp-fspi: Add support for
 imx8mm, imx8qxp
Date: Thu, 6 Feb 2020 18:40:30 +0000
Message-ID: <20200206184030.GA11381@bogus>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-4-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200202125950.1825013-4-aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Feb 02, 2020 at 06:59:49AM -0600, Adam Ford wrote:
> Add support for nxp,imx8qxp-fspi and nxp,imx8mm-fspi do the bindings

s/do/to/

> document.
> 
> Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> V2: No change
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> index 2cd67eb727d4..7ac60d9fe357 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> @@ -2,6 +2,9 @@
>  
>  Required properties:
>    - compatible : Should be "nxp,lx2160a-fspi"
> +			    "nxp,imx8qxp-fspi"
> +			    "nxp,imx8mm-fspi"

All 3 are different and no compatibility?

> +
>    - reg :        First contains the register location and length,
>                   Second contains the memory mapping address and length
>    - reg-names :  Should contain the resource reg names:
> -- 
> 2.24.0
> 
