From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
Date: Wed, 10 Feb 2016 13:24:37 -0800
Message-ID: <871t8k9s2y.fsf@eliezer.anholt.net>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de> <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de> <87a8n94e3x.fsf@eliezer.anholt.net> <7621387.PU4Z2tGlUh@chaos-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7621387.PU4Z2tGlUh@chaos-desktop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org> writes:

> Am Tuesday 09 February 2016, 16:13:06 schrieb Eric Anholt:
>> stephanolbrich-Mmb7MZpHnFY@public.gmane.org writes:
>> > From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>> >=20
>> > The auxiliary spi supports only CPHA=3D0 modes as the first bit is
>> > always output to the pin before the first clock cycle. In CPHA=3D1
>> > modes the first clock edge outputs the second bit hence the slave
>> > can never read the first bit.
>> >=20
>> > Also the CPHA registers switch between clocking data in/out on
>> > rising/falling edge hence depend on the CPOL setting.
>> >=20
>> > Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>> > ---
>> >=20
>> >  drivers/spi/spi-bcm2835aux.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >=20
>> > diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux=
.c
>> > index b90aa34..169f521 100644
>> > --- a/drivers/spi/spi-bcm2835aux.c
>> > +++ b/drivers/spi/spi-bcm2835aux.c
>> > @@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct
>> > spi_master *master,>=20
>> >  	bs->cntl[1] =3D BCM2835_AUX_SPI_CNTL1_MSBF_IN;
>> >=20=20=09
>> >  	/* handle all the modes */
>> >=20
>> > -	if (spi->mode & SPI_CPOL)
>> > +	if (spi->mode & SPI_CPOL) {
>> >=20
>> >  		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPOL;
>> >=20
>> > -	if (spi->mode & SPI_CPHA)
>> > -		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
>> > -			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>> > -
>> > +		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
>> > +	} else {
>> > +		bs->cntl[0] |=3D BCM2835_AUX_SPI_CNTL0_CPHA_IN;
>> > +	}
>> >=20
>> >  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
>> >  	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
>>=20
>> (Note for other readers: A better name for CNTL0_CPHA_* would be
>> CNTL0_*_RISING).
>
> Should I rename them?=20

Up to you.  I'm happy to see the work you've done fixing the driver
here, and I don't want to pile things on.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWu6qVAAoJELXWKTbR/J7oYRIP/A8BF08l0Qh7fgo9hpnIHFmV
UY708GsIwN4Hpi209Jd61mNqpbNEVOeOH6JxhVfeRc3zEyoRuseZvol8UZnCZr3N
rZYREb63ubAW+nkCcsIO6+JbJSVSjAZWV1i4s5whApc/Muo4JVEsXFOnV1UrpJlm
YiXjaQg/VeGC6Q+4eQhMedLPRJvFMT9jdh8J+qSn9exKlzxPLN9boBNziMQcIgxy
0tHl9Xkn0BqPInKJN7UziV14KDNnFvtxmYGwkqNDUeXSGcsbFF1Lxig1K1jE+Upo
qPwQMgdI3gsxYY7KRUOUV9CMSmjB5Mj06WS29QXyCNIIwZty7iX8mTimBE1P1C7C
+Ej5aWGs3zIP50NFL6Kafb56Jwh5MBkO/u+cBXf+Ui8O55DAhEcXoZZCUSnWjnuR
ZPwHwnqY23sh9MWDdDZsA4m0ESRep/0hWCZC+Jzk3OZWsX18rQzq1QCn5PaXC+bJ
eEXN8Iny9t1WGE0Ga4TEMkNbJOXH1c8upQ0J/GMo90/y/0fc86lPH1GlmKj7tdcE
Y6q2Ru/nBDoZdUHRJmjB1JDSWCuNUEHrqi4Pts64rVSs/HSml2IEO+Y31ivLJEUi
Z2Ja2shfsvde1E5nuse5jx48Bl6aBtikRbndFCx333ZwQYRchTTV8HB681C8AZU2
WT4+Woqpco5V07VI03j+
=Nblv
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
