From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
Date: Mon, 8 Sep 2014 12:35:47 +0100
Message-ID: <20140908113547.GJ4015@sirena.org.uk>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
 <20140904170630.GL29327@sirena.org.uk>
 <CACRpkdZEoBan=Lqr1T-iY41U9NfMA_MCLX3LA=juw7X4pmRvSQ@mail.gmail.com>
 <CAE0=X_3QO5p26M=FS7joKS3zD6LAM_moFutHNcyE1-CjauL3Rw@mail.gmail.com>
 <20140906135308.GC2601@sirena.org.uk>
 <CAE0=X_2q1Z+pGuh6OY9Si5jbrF9HkczNFUqUgK_8xBekNvMeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Anders Berg <anders.berg@avagotech.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE0=X_2q1Z+pGuh6OY9Si5jbrF9HkczNFUqUgK_8xBekNvMeyQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 01:02:32PM +0200, Anders Berg wrote:
> On Sat, Sep 6, 2014 at 3:53 PM, Mark Brown <broonie@kernel.org> wrote:

> > Would it not be more straightforward to just register it as a platform
> > device in this case, or use a separate OF ID in the DT?  We appear to
> > specify a compatible string when registering AMBA devices even if we are
> > capable of identifying using the ID registers.

> I'll drop this gpio patch for now and submit a patch on the pl022
> driver instead. I read the arm,primecell binding and learned that
> there is a property (arm,primecell-periphid) that can be used to
> override the HW PrimeCell ID. Seems like something to use here, right?

Possibly, though if there's no hardware ID to override to that might not
be the best option.  You could always define a property that's specific
to the pl022 driver flagging that it's got these extra chip selects though.

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDZSTAAoJECTWi3JdVIfQ/AsH/iHCP5Aalikko8/T0dqeY94z
fNwr+78Oo/IlKhNOnt9/gySYurhzeVi04FMpGQ4eoVmbaC+K5yAwBw+aBbOyC7HF
pYqvO7uVR9pMab685pJTpiIsN0l7u8Kgkubc9Q+4oc8P/zYtWI83ou7ZsdN+oeM9
kk5myErUMVKCuDCSuJikhtmQjIEPZa6aSFnsWnGGnU8xB0PEGeRx/v2uLv/d0WcL
yFe4Mvwvyl2sAgpn2YiI+5xlPMW9J99hVte0WM99j1W5nt3nnl6uF/vX+UYt8Lp0
wphT5YptZ/vJYwMz+pNTX6cLjbv/zwGLxHTnC2OUPIdjVegwRQJiiGKRuPg5bcw=
=Nc6W
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
