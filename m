From: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <martin.hundeboll-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 23:26:35 +0200
Message-ID: <DBFEECA3-E21E-4DC5-B6B9-D1B12AD48E7A@prevas.dk>
References: <20170724095327.18602-1-mnhu@prevas.dk> <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com> <20170724120148.avqvi53wkdgctsir@sirena.org.uk> <e668b7529837444085b9df3a563c3fe3@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: =?ISO-8859-1?Q?Martin_Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e668b7529837444085b9df3a563c3fe3-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On July 24, 2017 11:16:17 PM GMT+02:00, Chris Packham <Chris=2EPackham@all=
iedtelesis=2Eco=2Enz> wrote:
>On 25/07/17 00:42, Mark Brown wrote:
>> On Mon, Jul 24, 2017 at 01:49:14PM +0300, Andy Shevchenko wrote:
>>> On Mon, Jul 24, 2017 at 12:53 PM, Martin Hundeb=C3=B8ll <mnhu@prevas=
=2Edk>
>wrote:
>>>> Some gpio controllers requires lines to be configured as outputs to
>make
>>>> subsequent calls to `gpio_set_value()` have any effect=2E
>>=20
>>>> Add a call to `gpio_request_one()` for configured gpio chip-selects
>to
>>>> make it work on (at least) mvebu gpio controllers=2E
>>=20
>>> More and more hacks around plain GPIO integers=2E=2E=2E :-(
>>=20
>>> Perhaps we need to discuss how to convert SPI core to use GPIO
>>> descriptors everywhere=2E
>>=20
>> The best way would be to test the work that Chris Packham submitted
>in
>> May to do this, it'll need a refresh now and it ought to get some
>> testing on ep93xx but sadly nobody working on ep93xx has responded -
>I
>> think at this point I'd probably just apply and let people test
>-next=2E
>>=20
>
>My patchset kind of stalled=2E I can do a refresh if there's interest=2E
>But=20
>I really do need some help from people with access to hardware (I can=20
>cover spi-orion and spi-fsl-espi but that's about it)=2E After the
>initial=20
>RFC series I posted in May I found that iMX platforms use the integer=20
>cs_gpio field for both native chipselects and gpio based ones (values <
>
>0 indicate native CS) so again I'd be coding blind trying to
>disentangle=20
>that=2E

My submission was more or less a fly-by patch, but I'd be happy to test/de=
bug patches on spi-imx if you CC me on the series=2E

Any other drivers with special gpio-cs handling?

// Martin

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
