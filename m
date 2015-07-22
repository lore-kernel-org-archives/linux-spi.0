From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2 2/5] Documentation: mtd: add a DT property to set the number of dummy cycles
Date: Wed, 22 Jul 2015 15:43:54 +0200
Message-ID: <201507221543.54761.marex@denx.de>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com> <8119e3b46b91e43c10466b2400c6938a113b1c02.1437569902.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8119e3b46b91e43c10466b2400c6938a113b1c02.1437569902.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, July 22, 2015 at 03:17:07 PM, Cyrille Pitchen wrote:
> Depending on the SPI clock frequency, the Fast Read op code and the
> Single/Dual Data Rate mode, the number of dummy cycles can be tuned to
> improve transfer speed.
> The actual number of dummy cycles is specific for each memory model and is
> provided by the manufacturer thanks to the memory datasheet.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
> 2bee68103b01..4387567d8024 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
> @@ -19,6 +19,11 @@ Optional properties:
>                     all chips and support for it can not be detected at
> runtime. Refer to your chips' datasheet to check if this is supported by
> your chip.
> +- m25p,num-dummy-cycles : Set the number of dummy cycles for Fast Read
> commands. +                          Depending on the manufacturer
> additional dedicated +                          commands are sent to the
> flash memory so the +                          controller and the memory
> can agree on the number of +                          dummy cycles to use.

Can't you just try negotiating this value at probe time, starting with some
high value and see how low you can get with the negotiations ? This way, you'd 
be able to effectively auto-detect this value at probe-time.

I might be wrong though :)

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
