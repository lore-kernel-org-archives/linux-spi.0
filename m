From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 2/5] spi: dw: document device tree binding
Date: Sun, 2 Feb 2014 13:23:20 +0100
Message-ID: <20140202122320.GQ20094@book.gsilab.sittig.org>
References: <cover.1391162172.git.baruch@tkos.co.il>
 <a978b266a9b8827747054a689e014ca9efbec235.1391162172.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a978b266a9b8827747054a689e014ca9efbec235.1391162172.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 31, 2014 at 12:07 +0200, Baruch Siach wrote:
> 
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/spi/spi-dw.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

You introduce a new binding, but don't Cc: the devicetree list
for review.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
> @@ -0,0 +1,24 @@
> +Synopsys DesignWare SPI master
> +
> +Required properties:
> +- compatible: should be "snps,designware-spi"
> +- #address-cells: see spi-bus.txt
> +- #size-cells: see spi-bus.txt
> +- reg: address and length of the spi master registers
> +- interrupts: should contain one interrupt
> +- clocks: spi clock phandle
> +- num-cs: see spi-bus.txt

You may want to check Mark Rutland's replies in the DT list
archives with his nits about speaking of phandles only where
specifiers are involved as well, and how he several times
suggested improved descriptions that you can adopt or copy.

Is 'num-cs' really required and not optional?  (It may be, I'm
just asking.  Given that there has not been a binding before,
there is no compatibility issue either.)

> +
> +Optional properties:
> +- cs-gpios: see spi-bus.txt
> +
> +Example:
> +
> +spi: spi@4020a000 {
> +	compatible = "snps,designware-spi";
> +	interrupts = <11 1>;
> +	reg = <0x4020a000 0x1000>;
> +	clocks = <&pclk>;
> +	num-cs = <2>;
> +	cs-gpios = <&banka 0 0>;
> +};


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
