From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Fri, 8 Mar 2019 10:14:51 +0100
Message-ID: <CAMuHMdVjgWNw4fnzJV=Qxs6zyNiBPubJUL-4WDOy26N4TkQ4gQ@mail.gmail.com>
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw> <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sergei,

On Thu, Mar 7, 2019 at 6:50 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/28/2019 09:49 AM, Mason Yang wrote:
> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> > new file mode 100644
> > index 0000000..ea12017
> > --- /dev/null
> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,804 @@
> [...]
> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> > +{
> > +     //
> > +     // NOTE: The 0x260 are undocumented bits, but they must be set.
> > +     //      RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> > +     //      0x0 : the delay is biggest,
> > +     //      0x1 : the delay is 2nd biggest,
> > +     //      On H3 ES1.x, the value should be 0, while on others,
> > +     //      the value should be 6.
> > +     //
> > +     regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> > +                               RPC_PHYCNT_STRTIM(6) | 0x260);
> > +
> > +     //
> > +     // NOTE: The 0x1511144 are undocumented bits, but they must be set
> > +     //       for RPC_PHYOFFSET1.
> > +     //       The 0x31 are undocumented bits, but they must be set
> > +     //       for RPC_PHYOFFSET2.
> > +     //
> > +     regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
> > +                  0x1511144);
> > +     regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> > +                  RPC_PHYOFFSET2_OCTTMG(4));
> > +     regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> > +                  RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> > +     regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> > +                  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> > +                  RPC_CMNCR_BSZ(0));
> > +}
>
>    We clearly need runtime PM get/put() calls around this code. Otherwise,
> we're dependant on U-Boot leaving the clocks enabled...

Even that would be futile, as the common clock framework disables all
unused clocks at late boot time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
