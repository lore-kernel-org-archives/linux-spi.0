From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: core: Use min_t(size_t,..)
Date: Wed, 17 Feb 2016 19:23:42 +0100
Message-ID: <D694B51A-FE08-4B44-B137-77E930FE12C2@martin.sperl.org>
References: <1455730948-24938-1-git-send-email-fabio.estevam@nxp.com> <1455730948-24938-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455730948-24938-2-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 17.02.2016, at 18:42, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org> wrote:
> 
> Use min_t(size_t,..) in order to avoid the following 
> build warning on ARM64:
> 
> include/linux/kernel.h:754:17: warning: comparison of distinct pointer types lacks a cast
>  (void) (&_min1 == &_min2);  \
>                 ^
> drivers/spi/spi.c:2304:17: note: in expansion of macro 'min'
>  xfers[0].len = min(maxsize, xfer[0].len);
> 
> Suggested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Thanks, was busy with other stuff and thus could not 
create a patch myself.

Acked-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
