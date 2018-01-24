From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Allow specifying which HW CS to use with a
 GPIO CS
Date: Wed, 24 Jan 2018 16:19:41 +0200
Message-ID: <CAHp75VdB2e8Qwr7+LT3jT6HB2rSiSJ3TrMdBqVZYqO=KE6QBmg@mail.gmail.com>
References: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a1884719d4381cc3254408229cf5d9f94d4f2995.1516744108.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 23, 2018 at 9:56 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:
>
> Commit b28b9149b37f added support for using an additional GPIO pin for
> Chip Select. According to that commit and to my understanding of a
> semi-public datahseet, it seems that the SPI hardware really insists on
> driving *some* HW CS signal whenever a SPI transaction is in progress.
>
> The old code effectively forced the HW CS pin to be CS0. That means that
> there could not be anything connected to the real CS0 signal when one
> uses a GPIO CS. That assumption does not hold on e.g. Solidrun Clearfog
> where some SOM models have a built-in SPI flash on SPI1, CS0.
Like Geert said I also highly recommend to use existing properties.

Better if you, in the meantime, can switch the driver to use GPIO
descriptors, while core still use legacy numbers.
It would make life easier in the future to switch SPI core to GPIO
descriptors completely.

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
