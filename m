From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Wed, 9 Jan 2019 19:49:37 +0100
Message-ID: <CAMuHMdUPsN-VMhbttVK19gL_nPdaCTHHC7Dn3ajPoVhMqDJf_w@mail.gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw> <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sergei,

On Wed, Jan 9, 2019 at 7:47 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/08/2019 07:16 AM, Mason Yang wrote:
> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>
>    You now need to add:
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -544,6 +544,12 @@ config SPI_RSPI
> >       help
> >         SPI driver for Renesas RSPI and QSPI blocks.
> >
> > +config SPI_RENESAS_RPC_IF
>
>    Since the driver is called without -IF suffix, I wouldn't use it in the
> Kconfig name either, the following is enough:
>
> > +     tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
> > +     depends on ARCH_RENESAS || COMPILE_TEST
>
>    Judging on the compilation error reported by the 0-day bot about readq(),
> we now need to depend on 64BIT or something...

IIRC, this hardware block is also used on RZ/A, which is 32-bit.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
