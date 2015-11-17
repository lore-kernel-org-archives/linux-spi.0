From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: allow transfers to set transmission speed
Date: Tue, 17 Nov 2015 16:50:54 +0100
Message-ID: <CAGNoLaPnbfKP+aQpWaNuWC7YQTe33wpezJxSv4KHSeuiaDY9TQ@mail.gmail.com>
References: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446936065-15868-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark, Maxime,

2015-11-07 23:41 GMT+01:00 Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Allow transfers to set the transmission speed, only fall back to
> board max_speed_hz if requested speed is not set or invalid.
>
> Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Just a quick follow-up: is there anything else I need to do to push
this patch along? Or do I just need to be more patient?

Best regards,

  Marcus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
