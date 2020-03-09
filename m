From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: Re: [PATCH 6/6] arm64: dts: ls1028a-rdb: Add a spidev node for the
 mikroBUS
Date: Mon, 09 Mar 2020 19:58:04 +0100
Message-ID: <0700435a8355c9a53049d571d41da222@walle.cc>
References: <20200309145624.10026-1-olteanv@gmail.com>
 <20200309145624.10026-7-olteanv@gmail.com>
 <f213388d924b63d0fe265a2d731647be@walle.cc>
 <CA+h21hqOhM9+k9cKXoA8coYpxNFWpgD+FjETeB6uWLbsfrx0uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+h21hqOhM9+k9cKXoA8coYpxNFWpgD+FjETeB6uWLbsfrx0uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Am 2020-03-09 19:50, schrieb Vladimir Oltean:
> On Mon, 9 Mar 2020 at 20:35, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org> wrote:
>> 
>> Am 2020-03-09 15:56, schrieb Vladimir Oltean:
>> > From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
>> >
>> > For debugging, it is useful to have access to the DSPI controller
>> > signals. On the reference design board, these are exported to either
>> > the
>> > mikroBUS1 or mikroBUS2 connector (according to the CPLD register
>> > BRDCFG3[SPI3]).
>> >
>> > Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
>> > ---
>> >  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > index bb7ba3bcbe56..43f403b30dae 100644
>> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
>> > @@ -83,6 +83,20 @@
>> >       };
>> >  };
>> >
>> > +&dspi2 {
>> > +     bus-num = <2>;
>> > +     status = "okay";
>> > +
>> > +     /* mikroBUS1 */
>> > +     spidev@0 {
>> > +             compatible = "spidev";
>> 
>> As far as I know this throws a warning at boot that you
>> shouldn't use the compatible = "spidev", doesn't it?
>> 
>> /*
>>   * spidev should never be referenced in DT without a specific
>>   * compatible string, it is a Linux implementation thing
>>   * rather than a description of the hardware.
>>   */
>> 
> 
> If this is supposed to mean that the "spidev" string is less
> adequate/expressive than "rohm,dh2228fv", then ok, I'll use that.

TBH I don't care, its your board ;) But I suppose that there is no
Rohm DH2228FV on the (pluggable) mikroBUS board. I just noticed
that compatible string. Don't shoot the messenger ;)

-michael

> 
>> -michael
>> 
>> > +             reg = <0>;
>> > +             spi-max-frequency = <20000000>;
>> > +             fsl,spi-cs-sck-delay = <100>;
>> > +             fsl,spi-sck-cs-delay = <100>;
>> > +     };
>> > +};
>> > +
>> >  &esdhc {
>> >       sd-uhs-sdr104;
>> >       sd-uhs-sdr50;
