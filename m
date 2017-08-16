From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Applied "spi: Pick spi bus number from Linux idr or spi alias" to
 the spi tree
Date: Wed, 16 Aug 2017 18:48:07 +0200
Message-ID: <CAMuHMdX0Z8prbMivN5pC+-PycDSEx1tzkjGpRKK4=3RC5aYegQ@mail.gmail.com>
References: <E1di0ly-0003WF-HD@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1di0ly-0003WF-HD@debutante>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 16, 2017 at 6:02 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> The patch
>
>    spi: Pick spi bus number from Linux idr or spi alias
>
> has been applied to the spi tree at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.

Oops, so bad commit messages are cast in stone...

> From 9b61e302210eba55768962f2f11e96bb508c2408 Mon Sep 17 00:00:00 2001
> From: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Date: Thu, 3 Aug 2017 10:05:57 +0530
> Subject: [PATCH] spi: Pick spi bus number from Linux idr or spi alias
>
> Modify existing code, for automatically picking the spi bus number based
> on Linux idr scheme as mentioned in FIXME.

FIXME?

> This patch does the following:
> (a) Remove the now unnecessary code which was allocating bus numbers using
>     ATOMIC_INIT and atomic_dec_return macros.
> (b) If we have an alias, pick the bus number from alias ID
> (c) Convert to linux idr interface
>
> Signed-off-by: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Tested-by: Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
