From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
Date: Thu, 6 Dec 2018 10:12:11 +0100
Message-ID: <CAMuHMdWspyRq_K2Vd6Xk2tqft-oUoMvVhj-zKS-fuhv_edXb8Q@mail.gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com> <OF0ED3C578.141B72CA-ON4825835A.0025CA62-4825835A.002A7BDF@mxic.com.tw>
 <84e3c55b-687e-28f6-0a7c-1c48c822ef05@gmail.com> <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFC9FB54F8.34B3A8B7-ON4825835B.00267480-4825835B.0029455C@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Thu, Dec 6, 2018 at 8:31 AM <masonccyang@mxic.com.tw> wrote:
> > >> Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller driver
> > >>
> > >> On 12/03/2018 10:18 AM, Mason Yang wrote:
> > >> > Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> > >> >
> > >> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

> > >> > +   xfercnt = xferpos;
> > >> > +   rpc->xferlen = xfer[--xferpos].len;
> > >> > +   rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
> > >>
> > >> Is the cast needed ?
> > >
> > > yes!
> >
> > Why ?
>
> Get a compiler warning due to tx_bug is void *, as Geert replied.
>
> Using get_unaligned(), patched code would be
> ---------------------------------------------------------------
>  rpc->cmd = RPC_SMCMR_CMD(get_unaligned((u8 *)xfer[0].tx_buf));
> ----------------------------------------------------------------

Using get_unaligned(0 is a bit strange for accessing a single byte quantity.
Please keep the normal pointer dereference (including the cast).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
