From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-sci: fix use-after-free in sh_sci_spi_remove()
Date: Mon, 16 Jun 2014 18:06:14 +0200
Message-ID: <CAMuHMdWVEsn7=Z69xMFb-HZxUbc4iDtUnY7mp1i_tn9k1X_JsA@mail.gmail.com>
References: <1402929569-14500-1-git-send-email-j@bitron.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>
To: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402929569-14500-1-git-send-email-j@bitron.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 16, 2014 at 4:39 PM, J=C3=BCrg Billeter <j@bitron.ch> wrote=
:
> setbits() uses sp->membase.
>
> Signed-off-by: J=C3=BCrg Billeter <j@bitron.ch>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  drivers/spi/spi-sh-sci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-sci.c b/drivers/spi/spi-sh-sci.c
> index 1f56ef6..b83dd73 100644
> --- a/drivers/spi/spi-sh-sci.c
> +++ b/drivers/spi/spi-sh-sci.c
> @@ -175,9 +175,9 @@ static int sh_sci_spi_remove(struct platform_devi=
ce *dev)
>  {
>         struct sh_sci_spi *sp =3D platform_get_drvdata(dev);
>
> -       iounmap(sp->membase);
> -       setbits(sp, PIN_INIT, 0);
>         spi_bitbang_stop(&sp->bitbang);
> +       setbits(sp, PIN_INIT, 0);
> +       iounmap(sp->membase);
>         spi_master_put(sp->bitbang.master);
>         return 0;
>  }
> --
> 2.0.0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
