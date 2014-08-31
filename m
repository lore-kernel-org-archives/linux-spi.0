From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [GIT PULL] SPI fixes for v3.17
Date: Sun, 31 Aug 2014 14:39:40 +0200
Message-ID: <CAMuHMdU4G2ntmn-=+TJG9PNE7ZHfvh0XhvMFBx3hZso69FnpLg@mail.gmail.com>
References: <20140831122045.GD29327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140831122045.GD29327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Sun, Aug 31, 2014 at 2:20 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
>
>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3.17-rc3
>
> for you to fetch changes up to 360b2eaeb563896ab95db45eb7d1b83c9a04c292:

> Geert Uytterhoeven (2):
>       spi: sh-msiof: Fix leaking of unused DMA descriptors

I think you forgot this one, which fixes a stupid but critical typo in
the above:

commit 7a9f957b395fc08edc47620c01e8bb5b798caddb
Author: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Date:   Thu Aug 7 14:07:43 2014 +0200

    spi: sh-msiof: Fix transmit-only DMA transfers

    Fix tx/rx mixup, which broke transmit-only transfers.

    Introduced by commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
    ("spi: sh-msiof: Fix leaking of unused DMA descriptors").

    Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
    Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
    Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
    Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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
