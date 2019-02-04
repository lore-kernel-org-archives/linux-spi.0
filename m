From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Date: Mon, 4 Feb 2019 14:12:00 +0100
Message-ID: <20190204141200.05802849@jawa>
References: <20180927150709.17010-1-lukma@denx.de>
        <20190109082644.14941-1-lukma@denx.de>
        <20190204113001.77d59570@jawa>
        <20190204105737.GE23441@sirena.org.uk>
        <20190204135242.7112d48c@jawa>
        <20190204130356.GF23441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8KVRnqLykGiF8cTbKnYNiRq"; protocol="application/pgp-signature"
Cc: Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204130356.GF23441@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/8KVRnqLykGiF8cTbKnYNiRq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Feb 04, 2019 at 01:52:42PM +0100, Lukasz Majewski wrote:
> > > On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote: =20
>=20
> > > You've been sending ARM: patches to me (the SPI maintainer) and
> > > one of the DT maintainers.  =20
>=20
> ...
>=20
> > Moreover, I've CC'ed developers (Esben, Andrey, Martin) involved in
> > the changes for previous work done in this file/driver. =20
>=20
> > And those changes are solely related to SPI work in this driver, no
> > ARM Vybrid. =20
>=20
> If they're SPI patches they should have a changelog that looks like a
> SPI patch which means that it should start with "spi" (see other
> patches on the list or git log for examples).  When your patch
> subject lines start with ARM: that means they are for arch/arm - I
> don't 100% know but I suspect I've just not got far enough into the
> mails to notice that they're for SPI, people do send a lot of patches
> that just happen to mention buses to maintainers for those buses.  In
> general you should try to make sure that the subject line for your
> patch matches the style used in the relevant subsystem.

I see. Thanks for the detailed explanation.

>=20
> > What else shall I do? =20
>=20
> You'll need to resend the patch, preferrably with a suitable subject
> line.

I will resend the patch with more suitable subject, no problem.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8KVRnqLykGiF8cTbKnYNiRq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxYOiAACgkQAR8vZIA0
zr1MUwgA1g32KfI4g0bWQvIMTLGQl+Jp5F79SQbORRROkIuthN+bsLuSKHB1vBTy
psXYERmEDkKzXnDseu8bPGOJnWX/X+xAjJVJWofNs45CfWVfekdD6/9SEKizi5NZ
pdalPfUr+91F4RFt05INqh2ZjuH1pGyCfVqvszo3z7DrUAEyon3ADaeedAHVA8Aq
4woJ+Rnhz40nnqErV8T2rM75jt1UGpJ8/GoX4d5wJYIuR4bnNp3T08A3BWBM4bc1
5Em7TpzxsGeGL+oYTxG3FvBrY4J1l9tQtY+Ewzkf80Wj9N+EK5hUW43L2h6KwIDK
aJql+tP6AV37pL1iMcXAHDAS40N9Ug==
=1VQe
-----END PGP SIGNATURE-----

--Sig_/8KVRnqLykGiF8cTbKnYNiRq--
