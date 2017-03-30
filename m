From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Applied "spi: dynamycally allocated message initialization" to
 the spi tree
Date: Thu, 30 Mar 2017 11:19:45 +0200
Message-ID: <CAMuHMdXztYJrR=-XE42w3UBwXD4mO+hhuk0hOJY7VtQaFk5Vcg@mail.gmail.com>
References: <20170328074929.GA3196@ingrassia.epigenesys.com> <E1ctBNK-0007Tr-Qx@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1ctBNK-0007Tr-Qx@debutante>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 29, 2017 at 1:02 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> The patch
>
>    spi: dynamycally allocated message initialization

Shouldn't this contain the keyword "fix":

    spi: Fix dynamically allocated message initialization

Else it looks like an innocent change.

And a Fixes-tag would be nice, too.

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

Ugh...

> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From ed77d6bcafd75d247cf3c6ad685aa221cda1b8ba Mon Sep 17 00:00:00 2001
> From: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
> Date: Tue, 28 Mar 2017 09:49:29 +0200
> Subject: [PATCH] spi: dynamycally allocated message initialization
>
> Invoke the proper function while initializing
> a dynamically allocated spi_message to avoid
> NULL pointer dereference during resources deallocation.
>
> Signed-off-by: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
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
