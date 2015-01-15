From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] spi: sh-msiof: Update calculation of frequency dividing
Date: Thu, 15 Jan 2015 15:21:12 +0100
Message-ID: <CAMuHMdWwXGaMYpuPJ2_429kc65D0p26dOL-wz7GpWxQAqdJpwQ@mail.gmail.com>
References: <1421286613-8240-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421286613-8240-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Iwamatsu-san,

Thanks for the update!

On Thu, Jan 15, 2015 at 2:50 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> @@ -804,7 +803,9 @@ static int sh_msiof_transfer_one(struct spi_master *master,
>         int ret;
>
>         /* setup clocks (clock already enabled in chipselect()) */
> -       sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
> +       ret = sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
> +       if (ret)
> +               return ret;

I think this can be handled by the core, if we fill in spi_master.min_speed_hz.

BTW, you should also CC Mark Brown when sending SPI patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
