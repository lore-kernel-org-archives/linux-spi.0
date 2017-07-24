From: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
Date: Mon, 24 Jul 2017 12:53:20 +0200
Message-ID: <59066818-a284-4da0-d05f-d2503aeee44b@web.de>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nAHgsvSQHG1M5act0tgD290U5p0kWm3Wo"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nAHgsvSQHG1M5act0tgD290U5p0kWm3Wo
Content-Type: multipart/mixed; boundary="TantnTjuAlqjaPBxiXXbq9vQvRkLT6vkr";
 protected-headers="v1"
From: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang
 <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Message-ID: <59066818-a284-4da0-d05f-d2503aeee44b-S0/GAf8tV78@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is
 created
References: <90b3e14d-0077-9a25-9d90-ab340577af57-S0/GAf8tV78@public.gmane.org>
 <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--TantnTjuAlqjaPBxiXXbq9vQvRkLT6vkr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2017-07-24 12:44, Andy Shevchenko wrote:
> +Cc: Mika
>=20
> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
>> From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
>>
>> Avoid hogging chip select GPIOs just because they are listed for the
>> master. They might be mulitplexed and, if no slave device is attached,=

>> used for different purposes. Moreover, this strategy avoids having to
>> allocate a cs_gpiods structure.
>>
>> Tested on the IOT2000 where the second SPI bus is connected to an
>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM=

>> usage.
>>
>=20
> This breaks all systems which are using _DSD.

Err, can you elaborate? Worked fine here with _DSD on the IOT2000.

>=20
> While I'm looking for fix, I get feeling that the approach itself is no=
t right,
>=20
> So, for now I would vote for immediate revert and then rethink what we
> can do here.

I'm fine with reverting because the patch wasn't clean anyway (mixed old
and new GPIO API) - aside from whatever you found in addition. I had an
update pending but, as you are looking into this anyway, I'm sure your
patches will be more holistic.

Thanks,
Jan


--TantnTjuAlqjaPBxiXXbq9vQvRkLT6vkr--

--nAHgsvSQHG1M5act0tgD290U5p0kWm3Wo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll10aMACgkQitSsb3rl5xSCbQCgzfJBEWMrQjhpiCIVnToj4qJt
bBkAn1GRp4kP7pFVYk2wYPDzP5/y2uo3
=Liww
-----END PGP SIGNATURE-----

--nAHgsvSQHG1M5act0tgD290U5p0kWm3Wo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
