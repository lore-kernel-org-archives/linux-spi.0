From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: Re: [PATCH RFT] spi: txx9: Convert to let spi core handle checking
 transfer speed
Date: Mon, 10 Feb 2014 22:24:48 +0900 (JST)
Message-ID: <20140210.222448.505136221.anemo@mba.ocn.ne.jp>
References: <1391919307.26425.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391919307.26425.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, 09 Feb 2014 12:15:07 +0800, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
> By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
> checking transfer speed. Then we can remove the same checking in this driver.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-txx9.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Thank you.  I cannot test this by myself, but it looks good for me.

Reviewed-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
