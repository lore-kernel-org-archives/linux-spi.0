From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Thu, 27 Jul 2017 21:01:59 +0000
Message-ID: <98ee93f9883744f685b082aeb600a582@svr-chch-ex1.atlnz.lc>
References: <20170724095327.18602-1-mnhu@prevas.dk>
 <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
 <20170724120148.avqvi53wkdgctsir@sirena.org.uk>
 <e668b7529837444085b9df3a563c3fe3@svr-chch-ex1.atlnz.lc>
 <DBFEECA3-E21E-4DC5-B6B9-D1B12AD48E7A@prevas.dk>
 <3027e39333a24fa7a4ce540d96b0e6f3@svr-chch-ex1.atlnz.lc>
 <CAHp75VepKV1MyGqur7Nq-R+TA_cDdD7BuE4HtpgYCdSRBxg92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <martin.hundeboll-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        "Jarkko Nikula" <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 27/07/17 21:47, Andy Shevchenko wrote:=0A=
> On Tue, Jul 25, 2017 at 12:44 AM, Chris Packham=0A=
> <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:=0A=
>> On 25/07/17 09:28, Martin Hundeb=F8ll wrote:=0A=
>>>> My patchset kind of stalled. I can do a refresh if there's interest.=
=0A=
>>>> But I really do need some help from people with access to hardware (I =
can=0A=
>>>> cover spi-orion and spi-fsl-espi but that's about it). After the=0A=
>>>> initial RFC series I posted in May I found that iMX platforms use the =
integer=0A=
>>>> cs_gpio field for both native chipselects and gpio based ones (values =
<=0A=
>>>> 0 indicate native CS) so again I'd be coding blind trying to=0A=
>>>> disentangle that.=0A=
>>   >=0A=
>>> My submission was more or less a fly-by patch, but I'd be happy to=0A=
>>> test/debug patches on spi-imx if you CC me on the series.=0A=
>>=0A=
>> Thanks for the offer. Now I just need to get a few round tuits.=0A=
> =0A=
> Can you please, resend the latest you have with Cc'ing me?=0A=
> =0A=
>>> Any other drivers with special gpio-cs handling?=0A=
>>   >=0A=
>>=0A=
>> Based on a quick grep spi-{atmel,davinci,ep93xx,gpio,imx,mt65xx,stm32}=
=0A=
>> all do stuff with cs_gpios outside of the spi core. I think at least=0A=
>> some of those a trivially handled if we let the core code do the gpio=0A=
>> management.=0A=
> =0A=
> I have got ep93xx board from Mika to test, so, I can perhaps perform=0A=
> tests later, after I got pxa2xx working.=0A=
> =0A=
=0A=
Sure I'll rebase the series against linux-next#master I notice there is =0A=
a rename of some variables in areas I'm touching.=0A=
=0A=
Should come through shortly.=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
