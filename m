From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 21:16:17 +0000
Message-ID: <e668b7529837444085b9df3a563c3fe3@svr-chch-ex1.atlnz.lc>
References: <20170724095327.18602-1-mnhu@prevas.dk>
 <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
 <20170724120148.avqvi53wkdgctsir@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 25/07/17 00:42, Mark Brown wrote:=0A=
> On Mon, Jul 24, 2017 at 01:49:14PM +0300, Andy Shevchenko wrote:=0A=
>> On Mon, Jul 24, 2017 at 12:53 PM, Martin Hundeb=F8ll <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org> wr=
ote:=0A=
>>> Some gpio controllers requires lines to be configured as outputs to mak=
e=0A=
>>> subsequent calls to `gpio_set_value()` have any effect.=0A=
> =0A=
>>> Add a call to `gpio_request_one()` for configured gpio chip-selects to=
=0A=
>>> make it work on (at least) mvebu gpio controllers.=0A=
> =0A=
>> More and more hacks around plain GPIO integers... :-(=0A=
> =0A=
>> Perhaps we need to discuss how to convert SPI core to use GPIO=0A=
>> descriptors everywhere.=0A=
> =0A=
> The best way would be to test the work that Chris Packham submitted in=0A=
> May to do this, it'll need a refresh now and it ought to get some=0A=
> testing on ep93xx but sadly nobody working on ep93xx has responded - I=0A=
> think at this point I'd probably just apply and let people test -next.=0A=
> =0A=
=0A=
My patchset kind of stalled. I can do a refresh if there's interest. But =
=0A=
I really do need some help from people with access to hardware (I can =0A=
cover spi-orion and spi-fsl-espi but that's about it). After the initial =
=0A=
RFC series I posted in May I found that iMX platforms use the integer =0A=
cs_gpio field for both native chipselects and gpio based ones (values < =0A=
0 indicate native CS) so again I'd be coding blind trying to disentangle =
=0A=
that.=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
