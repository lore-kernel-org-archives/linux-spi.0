From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
Date: Sat, 7 Dec 2013 10:46:28 +0100
Message-ID: <20131207104628.47187617@crub>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
	<1385851897-23475-9-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385851897-23475-9-git-send-email-gsi-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 30 Nov 2013 23:51:28 +0100
Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org> wrote:

> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the 'ipg' clock item for register access as well
> 
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
> ---
>  drivers/spi/spi-mpc512x-psc.c |   26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

applied to next. Thanks!

Anatolij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
