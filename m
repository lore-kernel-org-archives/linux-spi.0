From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Thu, 27 Jul 2017 12:47:30 +0300
Message-ID: <CAHp75VepKV1MyGqur7Nq-R+TA_cDdD7BuE4HtpgYCdSRBxg92A@mail.gmail.com>
References: <20170724095327.18602-1-mnhu@prevas.dk> <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
 <20170724120148.avqvi53wkdgctsir@sirena.org.uk> <e668b7529837444085b9df3a563c3fe3@svr-chch-ex1.atlnz.lc>
 <DBFEECA3-E21E-4DC5-B6B9-D1B12AD48E7A@prevas.dk> <3027e39333a24fa7a4ce540d96b0e6f3@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin.hundeboll-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3027e39333a24fa7a4ce540d96b0e6f3-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jul 25, 2017 at 12:44 AM, Chris Packham
<Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> On 25/07/17 09:28, Martin Hundeb=C3=B8ll wrote:
>>> My patchset kind of stalled. I can do a refresh if there's interest.
>>> But I really do need some help from people with access to hardware (I c=
an
>>> cover spi-orion and spi-fsl-espi but that's about it). After the
>>> initial RFC series I posted in May I found that iMX platforms use the i=
nteger
>>> cs_gpio field for both native chipselects and gpio based ones (values <
>>> 0 indicate native CS) so again I'd be coding blind trying to
>>> disentangle that.
>  >
>> My submission was more or less a fly-by patch, but I'd be happy to
>> test/debug patches on spi-imx if you CC me on the series.
>
> Thanks for the offer. Now I just need to get a few round tuits.

Can you please, resend the latest you have with Cc'ing me?

>> Any other drivers with special gpio-cs handling?
>  >
>
> Based on a quick grep spi-{atmel,davinci,ep93xx,gpio,imx,mt65xx,stm32}
> all do stuff with cs_gpios outside of the spi core. I think at least
> some of those a trivially handled if we let the core code do the gpio
> management.

I have got ep93xx board from Mika to test, so, I can perhaps perform
tests later, after I got pxa2xx working.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
