From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the
 DSPI controllers
Date: Mon, 09 Mar 2020 21:17:42 +0100
Message-ID: <3b25c8b5fc9c433715e1fa99bc515822@walle.cc>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-6-olteanv@gmail.com>
 <83af52172a3cabd662de1ed9574e4247@walle.cc>
 <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+h21hp2MxLqLJL9AnufmW_-OQFdiY7p4Db97G3eTr_MUkH4TA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-09 20:59, schrieb Vladimir Oltean:
> On Mon, 9 Mar 2020 at 21:06, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> > From: Vladimir Oltean <vladimir.oltean@nxp.com>
>> >
>> > LS1028A has a functional connection to the eDMA module. Even if the
>> > spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the
>> > slots
>> > in the DMAMUX for connecting the eDMA channels to the 3 DSPI
>> > controllers.
>> >
>> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > index 515e0a1b934f..18155273a46e 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
>> > @@ -298,6 +298,8 @@
>> >                       interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> >                       clock-names = "dspi";
>> >                       clocks = <&clockgen 4 1>;
>> > +                     dmas = <&edma0 0 62>, <&edma0 0 60>;
>> > +                     dma-names = "tx", "rx";
>> 
>> minor nit. Other nodes specified the dma channels as
>> 
>> dma-names = "tx", "rx";
>> dmas = <&edma0 0 62>,
>>         <&edma0 0 60>;
>> 
>> -michael
>> 
> 
> Does it matter?

No, therefore "minor nit". Its just formatted other then everything else 
in the file.

-michael
