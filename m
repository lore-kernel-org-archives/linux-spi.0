From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] spi: rspi: Remove obsolete rspi-rz platform_device_id entry
Date: Wed, 24 Jun 2015 10:01:23 +0200
Message-ID: <CAMuHMdWfttuYc6zDiWgzG=SoFWKw7Ghkx3pREmM1vQiANus_bg@mail.gmail.com>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 23, 2015 at 3:02 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since commit 05104c266ae9a167 ("ARM: shmobile: r7s72100: genmai: Remove
> legacy board file"), r7s72100 is only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/spi/spi-rspi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index f9189a0c8cec81f2..56216b205e0f2c34 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1295,7 +1295,6 @@ error1:
>
>  static const struct platform_device_id spi_driver_ids[] = {
>         { "rspi",       (kernel_ulong_t)&rspi_ops },
> -       { "rspi-rz",    (kernel_ulong_t)&rspi_rz_ops },
>         { "qspi",       (kernel_ulong_t)&qspi_ops },
>         {},
>  };

rspi_rz_ops is still used for DT matching, but rspi_of_match[] is protected
by #ifdef CONFIG_OF, so this may lead to compiler warnings.

Please drop this one, will fix.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
