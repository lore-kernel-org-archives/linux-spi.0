From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Date: Wed, 14 Jan 2015 09:36:41 +0100
Message-ID: <CAMuHMdWet3AWrHMzygNOaEKMM8qzXUZ5ub_mcAWiHh_SQLoXeA@mail.gmail.com>
References: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Iwamatsu-san,

On Wed, Jan 14, 2015 at 8:25 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> sh-msiof of frequency dividing does not perform the calculation, driver have
> to manage setting value in the table. It is not possible to set frequency
> dividing value close to the actual data in this way. This changes from
> frequency dividing of table management to setting by calculation.
> This driver is able to set a value close to the actual data.

Thanks for your patch!

> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 96a5fc0..58b1bfe 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -241,42 +241,37 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
>
>  static struct {
>         unsigned short div;
> -       unsigned short scr;
> -} const sh_msiof_spi_clk_table[] = {
> -       { 1,    SCR_BRPS( 1) | SCR_BRDV_DIV_1 },
> -       { 2,    SCR_BRPS( 1) | SCR_BRDV_DIV_2 },
> -       { 4,    SCR_BRPS( 1) | SCR_BRDV_DIV_4 },
> -       { 8,    SCR_BRPS( 1) | SCR_BRDV_DIV_8 },
> -       { 16,   SCR_BRPS( 1) | SCR_BRDV_DIV_16 },
> -       { 32,   SCR_BRPS( 1) | SCR_BRDV_DIV_32 },
> -       { 64,   SCR_BRPS(32) | SCR_BRDV_DIV_2 },
> -       { 128,  SCR_BRPS(32) | SCR_BRDV_DIV_4 },
> -       { 256,  SCR_BRPS(32) | SCR_BRDV_DIV_8 },
> -       { 512,  SCR_BRPS(32) | SCR_BRDV_DIV_16 },
> -       { 1024, SCR_BRPS(32) | SCR_BRDV_DIV_32 },
> +       unsigned short brdv;
> +} const sh_msiof_spi_div_table[] = {
> +       { 1,    SCR_BRDV_DIV_1 },
> +       { 2,    SCR_BRDV_DIV_2 },
> +       { 4,    SCR_BRDV_DIV_4 },
> +       { 8,    SCR_BRDV_DIV_8 },
> +       { 16,   SCR_BRDV_DIV_16 },
> +       { 32,   SCR_BRDV_DIV_32 },
>  };
>
>  static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
>                                       unsigned long parent_rate, u32 spi_hz)
>  {
>         unsigned long div = 1024;
> +       unsigned long brps, scr;

"u32", as these are (parts of) 32-bit register values.

>         size_t k;
>
>         if (!WARN_ON(!spi_hz || !parent_rate))
>                 div = DIV_ROUND_UP(parent_rate, spi_hz);
>
> -       /* TODO: make more fine grained */
> -
> -       for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_clk_table); k++) {
> -               if (sh_msiof_spi_clk_table[k].div >= div)
> -                       break;
> +       for (k = 0; k < ARRAY_SIZE(sh_msiof_spi_div_table); k++) {
> +               brps = DIV_ROUND_UP(div, sh_msiof_spi_div_table[k].div);
> +               if (brps > 32) /* max of brsv is 32 */

max of brdv

> +                       continue;
> +               break;

Having a conditional "continue" followed by a "break" looks strange.

        if (brps <= 32) /* max of brdv is 32 */
                break

>         }

"brps" may be larger than 32 after the loop.
In the old code, the min_t() below handled that case.

> -       k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
> -
> -       sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
> +       scr = sh_msiof_spi_div_table[k].brdv | (brps -1) << 8;

"scr = sh_msiof_spi_div_table[k].brdv | SCR_BRPS(i);" would avoid the need
for "- 1" and the hardcoded shift.

> +       sh_msiof_write(p, TSCR, scr);
>         if (!(p->chipdata->master_flags & SPI_MASTER_MUST_TX))
> -               sh_msiof_write(p, RSCR, sh_msiof_spi_clk_table[k].scr);
> +               sh_msiof_write(p, RSCR, scr);
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
