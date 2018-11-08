From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 3/4] ARM: dts: r8a77470: Add QSPI support
Date: Thu, 8 Nov 2018 10:31:12 +0000
Message-ID: <TY1PR01MB1770AD277B0A1C5DF1776F60C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1541075705-1333-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <20181102114946.5tqk2lyisaey475w@verge.net.au>
 <TY1PR01MB1770FA3764370E7AEA5D30C6C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <CAMuHMdX=L9d=1dq24WErcjYLv987=yKL2K7hxnS7hhsZpbKEBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Mark Brown <broonie@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Simon Horman <horms@verge.net.au>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Biju Das <biju.das@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdX=L9d=1dq24WErcjYLv987=yKL2K7hxnS7hhsZpbKEBA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello Geert,

Thank you for your feedback!

> Subject: Re: [PATCH 3/4] ARM: dts: r8a77470: Add QSPI support
>
> Hi Fabrizio,
>
> On Thu, Nov 8, 2018 at 11:22 AM Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > > From: Simon Horman <horms@verge.net.au>
> > > Sent: 02 November 2018 11:50
> > > Subject: Re: [PATCH 3/4] ARM: dts: r8a77470: Add QSPI support
> > >
> > > On Thu, Nov 01, 2018 at 12:35:04PM +0000, Fabrizio Castro wrote:
> > > > Add QSPI[01] support to the RZ/G1C SoC specific device tree.
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > ---
> > > >  arch/arm/boot/dts/r8a77470.dtsi | 34 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 34 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
> > > > index e6407e5..04a8877 100644
> > > > --- a/arch/arm/boot/dts/r8a77470.dtsi
> > > > +++ b/arch/arm/boot/dts/r8a77470.dtsi
> > > > @@ -20,6 +20,8 @@
> > > >  i2c2 = &i2c2;
> > > >  i2c3 = &i2c3;
> > > >  i2c4 = &i2c4;
> > > > +spi0 = &qspi0;
> > > > +spi1 = &qspi1;
> > > >  };
> > >
> > > Geert can comment but I believe we are moving away from using aliases
> > > in this way and that it would be best if the above hunk was dropped
> > > from this patch.
> > >
> > > https://patchwork.kernel.org/patch/10644159/
> >
> > Geert, what do you want me to do here?
>
> Please drop the aliases. Thanks!

Will do, will send a new version without the additional aliases.
My understanding is that your personal preference is to only leave debug console and ethernet,
shall I also  get rid of what was already upstreamed for RZ/G related boards that is not in line
with the new policy?

Thanks,
Fab

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
