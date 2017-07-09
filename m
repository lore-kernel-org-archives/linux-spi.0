From: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
Date: Sun, 9 Jul 2017 12:30:40 +0200
Message-ID: <70d88e65-5dd1-f218-dc39-e553a1b6acb5@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
 <1677d448-4cdd-363f-34a6-152c61a06c0e@web.de>
 <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="U4Fp4iD6xdqtgsIuITPcrafqinSDF6QEo"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U4Fp4iD6xdqtgsIuITPcrafqinSDF6QEo
Content-Type: multipart/mixed; boundary="t5kek70B9h6xnJFREtaqLxWBsfw65ce9A";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang
 <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Message-ID: <70d88e65-5dd1-f218-dc39-e553a1b6acb5-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
References: <90b3e14d-0077-9a25-9d90-ab340577af57-S0/GAf8tV78@public.gmane.org>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <1677d448-4cdd-363f-34a6-152c61a06c0e-S0/GAf8tV78@public.gmane.org>
 <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAHp75VeSeHuXGmQeGr2Kq3+TOD8uHoKjd0EYLRkJVogOxcLJ2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--t5kek70B9h6xnJFREtaqLxWBsfw65ce9A
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-07-09 11:55, Andy Shevchenko wrote:
> On Sun, Jul 9, 2017 at 12:30 PM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
>> On 2017-07-08 23:48, Andy Shevchenko wrote:
>>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote=
:
>>>> From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> Avoid hogging chip select GPIOs just because they are listed for the=

>>>> master. They might be mulitplexed and, if no slave device is attache=
d,
>>>> used for different purposes. Moreover, this strategy avoids having t=
o
>>>> allocate a cs_gpiods structure.
>>>>
>>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>>> Arduino-compatible connector and multiplexed between SPI, GPIO and P=
WM
>>>> usage.
>>>
>>> Can we first switch the driver to use GPIO descriptors instead of
>>> plain integers?
>>
>> -ENOPARSE
>=20
> In code you are trying to modify there is a mix of plain integers and
> GPIO descriptors (and two APIs).
> Can we just convert it to use GPIO descriptors API?

That wasn't helpful either for someone not doing gpio development the
whole day. I suppose you wanted to suggest the conversion of
chip_data::chip_cs to struct gpio_desc * and the consistent usage of
gpiod_*, instead of gpio_*. That's not necessarily a precondition, but
it's a reasonable cleanup.

Jan


--t5kek70B9h6xnJFREtaqLxWBsfw65ce9A--

--U4Fp4iD6xdqtgsIuITPcrafqinSDF6QEo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlliBdQACgkQitSsb3rl5xT4QQCgkjR/tZJFmflxUpv4YkYUSpCe
UVEAoNYymNN8HAItPH8nhweE9wRGYx2U
=tMDs
-----END PGP SIGNATURE-----

--U4Fp4iD6xdqtgsIuITPcrafqinSDF6QEo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
