From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the
 DSPI controllers
Date: Mon, 9 Mar 2020 21:59:32 +0200
Message-ID: <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com> <20200309145624.10026-6-olteanv@gmail.com>
 <83af52172a3cabd662de1ed9574e4247@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Esben Haabendal <eha-/iRVSOupHO4@public.gmane.org>,
        angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        "Gustavo A. R. Silva" <gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>,
        Wei Chen <weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mohamed Hosny <mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        peng.ma-3arQi8VN3Tc@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <83af52172a3cabd662de1ed9574e4247-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 9 Mar 2020 at 21:06, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>
> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
> > From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> >
> > LS1028A has a functional connection to the eDMA module. Even if the
> > spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the
> > slots
> > in the DMAMUX for connecting the eDMA channels to the 3 DSPI
> > controllers.
> >
> > Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 515e0a1b934f..18155273a46e 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -298,6 +298,8 @@
> >                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> >                       clock-names = "dspi";
> >                       clocks = <&clockgen 4 1>;
> > +                     dmas = <&edma0 0 62>, <&edma0 0 60>;
> > +                     dma-names = "tx", "rx";
>
> minor nit. Other nodes specified the dma channels as
>
> dma-names = "tx", "rx";
> dmas = <&edma0 0 62>,
>         <&edma0 0 60>;
>
> -michael
>

Does it matter?

Regards,
-Vladimir
