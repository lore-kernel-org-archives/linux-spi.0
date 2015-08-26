From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v5 3/5] mtd: spi-nor: allow to tune the number of dummy cycles
Date: Wed, 26 Aug 2015 16:39:02 +0200
Message-ID: <201508261639.02377.marex@denx.de>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com> <4324f398c0e69e3057e7da6a1a3e0328b44f224f.1440580764.git.cyrille.pitchen@atmel.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4324f398c0e69e3057e7da6a1a3e0328b44f224f.1440580764.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, August 26, 2015 at 02:30:25 PM, Cyrille Pitchen wrote:
> The number of dummy cycles used during Fast Read commands can be reduced
> to improve transfer performances. Each manufacturer has a dedicated set of
> registers to provide the memory with the exact number of dummy cycles it
> should expect. Both the memory and the (Q)SPI controller must agree on
> this number of dummy cycles.
> 
> The number of dummy cycles can be found into the memory datasheet and
> mostly depends on the SPI clock frequency, the Fast Read op code and the
> Single/Dual Data Rate mode.
> 
> Probing JEDEC Serial Flash Discoverable Parameters (SFDP) tables would
> only provide the driver with a high enough number of dummy cycles for each
> Fast Read command to be used for all clock frequencies: this solution
> would not be optimized.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
