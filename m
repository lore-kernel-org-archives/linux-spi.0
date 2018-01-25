From: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Thu, 25 Jan 2018 21:18:46 +0000
Message-ID: <5dec18c8e18845d39999ca60547fefff@svr-chch-ex1.atlnz.lc>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <CAMuHMdU-06YxWm3MPSBY5weCRCRVRQPUiabGxa-n8ikXi9D-3A@mail.gmail.com>
 <60b34619-5034-4e71-b0b2-75a62de0cf2c@cesnet.cz>
 <96ca6f6776cf4146bcfb56a884236165@svr-chch-ex1.atlnz.lc>
 <CAMuHMdUOFJS=s-8Dv-BBLayXxKqZ0kPAUednA-3NL0+AZYuq-w@mail.gmail.com>
 <20180125115741.GA21900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ben Whitten <ben.whitten-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark, Geert,=0A=
=0A=
On 26/01/18 00:57, Mark Brown wrote:=0A=
> ")=0A=
> Fcc: +sent-mail=0A=
> =0A=
> On Thu, Jan 25, 2018 at 09:51:06AM +0100, Geert Uytterhoeven wrote:=0A=
>> On Wed, Jan 24, 2018 at 10:29 PM, Chris Packham=0A=
> =0A=
>> However, Jan wrote:=0A=
>>> semi-public datahseet, it seems that the SPI hardware really insists on=
=0A=
>>> driving *some* HW CS signal whenever a SPI transaction is in progress.=
=0A=
> =0A=
>> If that is correct, it behaves like MSIOF, so you must leave one native =
chip=0A=
>> select unused. If all native chip selects are in use, one of them must b=
e=0A=
>> replaced by a GPIO chip select (which could be the same physical pin,=0A=
>> depending on pinmux capabilities).=0A=
> =0A=
> Using the same pin is the ideal thing obviously, or if not then=0A=
> something that we know isn't routed out of the SoC (which may or may not=
=0A=
> be possible with a given chip design).=0A=
> =0A=
>>>           spi-flash@0 {=0A=
>>>                  /* This is on CS0 when GPIO 17 is high */=0A=
>>>           };=0A=
>>>=0A=
>>>           spi-sram@1 {=0A=
>>>                   /* This is on CS0 when GPIO 17 is low */=0A=
>>>          };=0A=
>>> };=0A=
> =0A=
>>> I'm not sure what else I could do. I can't claim the GPIO twice. If I=
=0A=
>>> could I could probably use spi-cs-high to handle the high/low toggle.=
=0A=
> =0A=
>> So this uses GPIO17 to drive a mux to connect CS0 to either the first or=
=0A=
>> second device?=0A=
=0A=
Correct. GPIO17 directs CS0 with the addition of a logic gate.=0A=
=0A=
> Interesting, coincidentally there was someone else sending a patch for=0A=
> muxing the other day which looked like having some support for chip=0A=
> select muxing would be the most sensible implementation.  I've copied in=
=0A=
> Ben who had initially approached this with a mux for the full bus which=
=0A=
> I'm not so convincd about.=0A=
> =0A=
>> But you describe this as @0 being driven by CS0, and @1 by GPIO17, and y=
ou=0A=
>> rely on CS0 still being driven when @1 is selected, right?=0A=
>> That indeed won't work when an unused native chip select is driven when=
=0A=
>> using cs-gpio.=0A=
=0A=
Yes that's my problem.=0A=
=0A=
> =0A=
>> IMHO, this needs the mux to be described properly in DT.=0A=
> =0A=
> Yes.=0A=
=0A=
I'm more than happy to update the DT on this product. But I've no idea =0A=
what that update would look like.=0A=
=0A=
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
