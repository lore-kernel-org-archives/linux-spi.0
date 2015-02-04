From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: img-spfi: same edge bit set to double spfi speeds
Date: Tue, 3 Feb 2015 22:10:15 -0800
Message-ID: <CAL1qeaEkdYz+pm-YwNA5g_XmjaST8sgCZruhEgfaVy+yjM+Ucw@mail.gmail.com>
References: <1422985565-14163-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422985565-14163-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Sifan,

On Tue, Feb 3, 2015 at 9:46 AM, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:
> Setting the same edge bit is required for operating at full bitrate
> programmed into the SPFI control register. Without this bit set the
> max operating bitrate supported would be half the maximum bitrate
> supported by the img-spfi block.
> It's safe to set this bit for all transactions.
>
> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

> @@ -435,6 +436,9 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
>                 val |= SPFI_CONTROL_CONTINUE;
>         spfi_writel(spfi, val, SPFI_CONTROL);
>
> +       /* Double the transfer speed by setting Same Edge. */

I'm not sure a comment here is totally necessary, but if you do want
one, I don't think "Double the transfer speed" is the best way to put
this.  Something explaining what the SE bit does and that failing to
set it results in us operating at half the specified bitrate would be
more useful.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
