From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next 1/4] mtd: spi-nor: remove unused
 read_xfer/write_xfer hooks
Date: Mon, 21 Sep 2015 17:01:45 -0700
Message-ID: <20150922000145.GJ31505@google.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
 <719ad7cc8bf6df151dd799cd4f13292fd9471079.1442590224.git.cyrille.pitchen@atmel.com>
 <201509190508.55496.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org, juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201509190508.55496.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Sep 19, 2015 at 05:08:55AM +0200, Marek Vasut wrote:
> On Friday, September 18, 2015 at 05:49:25 PM, Cyrille Pitchen wrote:
> > struct spi_nor_xfer_cfg and read_xfer/write_xfer hooks were never used by
> > any driver. Do some cleanup by removing them.
> > 
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> 
> Right, if this will ever be needed, it can be re-added.
> 
> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Applied this patch to l2-mtd.git. Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
