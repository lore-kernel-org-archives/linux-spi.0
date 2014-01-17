From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: Remove duplicate code to set default bits_per_word setting
Date: Fri, 17 Jan 2014 13:55:27 +0100
Message-ID: <201401171355.27291.marex@denx.de>
References: <1389956020.6412.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>,
	Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389956020.6412.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, January 17, 2014 at 11:53:40 AM, Axel Lin wrote:
> The implementation in spi_setup() already set spi->bits_per_word = 8 when
> spi->bits_per_word is 0 before calling spi->master->setup.
> So we don't need to do it again in setup() callback.
> 
> Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Cc: Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Cc: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>


Good catch,

for spi-mxs:

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
