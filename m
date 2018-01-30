From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a =?iso-8859-1?Q?GPIO_CS?=
Date: Tue, 30 Jan 2018 17:09:44 +0100
Message-ID: <3988555e-0439-4cff-a91c-bb947fae6b1e@cesnet.cz>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
 <1517274816.25398.136.camel@impinj.com>
 <368d1a46-8fc8-466d-b292-8ab8eaf11f4b@cesnet.cz>
 <20180130155409.GD10525@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180130155409.GD10525-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On =C3=BAter=C3=BD 30. ledna 2018 16:54:09 CET, Mark Brown wrote:
> You can't physically design working hardware for a system with this
> limitation that doesn't have a free chip select somehow - if the
> hardware requires that it controls an internal chip select line then
> using a GPIO chip select is going to require that there's some internal
> chip select line that's getting controlled so you need one that's not
> connected to an actual device that can be used for this purpose.

Hi Mark,
yes, I understand that. Sorry if I confused things by trying to explain why=20=

a modulo-algorithm won't work.

I have an unused CS lane. It's just that the spi-orion driver currently=20
hardcodes HW CS#0, and that one is not free on my board.

The latest version of my patch [1] finds the first *GPIO* CS number. As you=20=

pointed out, this allocation means that a HW CS signal with the same number=20=

is definitely not connected to any other slave's CS. My patch therefore=20
drives this "unused" HW CS whenever a GPIO CS is needed. This is similar to=20=

what e.g. spi-sh-msiof.c is doing now.

Should I perhaps improve the patch description? I'm open to all comments=20
here.

I see that it might be a bit confusing that I also changed spi-orion.c so=20
that it claims/requests/registers/allocates the GPIO for CS. Without that=20
patch , spi-orion is different from other SPI masters; I have to manually=20
create a gpio-hog for my CS GPIO. I'll be happy to rework my changes into=20
two separate patches.

>> Also, the spi-orion driver currently hard-codes that each and=20
>> every model is
>> supposed to have exactly eight HW CS pins. That's not true for my SoC
>> (Marvell Armada 388, the Solidrun Clearfog Base board); the=20
>> 88F6828 CPU only
>> has four SPI CS signals.
>
>> What my patch does is simply picking the *first* unused CS and going with
>> that one because that looks like the easiest and also safest option.
>
> I would expect that you want to have this selected by the board designer
> (unless there's something convenient like a chip select present in the
> controller but not routed out of the IP you can guarantee will never be
> used).  That will avoid issues if for example the DT is still not
> complete.

That's the approach that I used in my first version of this patch [2], but=20=

Geert suggested to follow some other SPI master's code and implement=20
autodiscovery. I don't really care. Which approach is better from your=20
point of view?

I understand the preference to specify the "fake" HW CS manually. My board=20=

has a flash at CS#0, and it is marked as disabled in a default DT. But=20
perhaps that's a special case. Your call, anyway.

With kind regards,
Jan

[1] https://patchwork.kernel.org/patch/10187175/
[2] https://patchwork.kernel.org/patch/10182583/
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
