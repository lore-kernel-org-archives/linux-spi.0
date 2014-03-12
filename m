From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 2/3] spi/xtensa-xtfpga: add DT binding documentation
Date: Wed, 12 Mar 2014 15:13:20 +0000
Message-ID: <20140312151320.GB5035@e106331-lin.cambridge.arm.com>
References: <1394626865-15105-1-git-send-email-jcmvbkbc@gmail.com>
 <1394626865-15105-3-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394626865-15105-3-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 12:21:04PM +0000, Max Filippov wrote:
> Signed-off-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
> new file mode 100644
> index 0000000..b6ebe2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
> @@ -0,0 +1,9 @@
> +Cadence Xtensa XTFPGA platform SPI controller.
> +
> +This simple SPI master controller is built into xtfpga bitstreams and is used
> +to control daughterboard audio codec.
> +
> +Required properties:
> +- compatible: should be "cdns,xtfpga-spi".

Is that the official name of the block? Nothing more specific?

> +- reg: physical base address of the controller and length of memory mapped
> +  region.

No interrupts?

Otherwise, this looks fine to me.

Cheers,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
