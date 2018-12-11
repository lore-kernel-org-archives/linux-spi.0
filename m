From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Date: Tue, 11 Dec 2018 11:56:01 +0000
Message-ID: <20181211115601.GB6686@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7694963425899343601=="
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============7694963425899343601==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:13:00AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Dec 11, 2018 at 01:14:28AM +0000, Mark Brown wrote:

> > It looked like there was an unanswered question about if patch 2 was
> > needed or not?  Marek?

> I cannot find an unanswered question. There is a workaround that Marek
> introduced in 6fd8b8503a0dcf66510314dc054745087ae89f94 that might not be
> needed any more with my patch 2. So it's the other way round: If Marek's
> problem is fixed by patch 2, my patch is the better one. I have problems
> with SCK changing polarity when CS is already asserted in the presence
> of Marek's change. After my change they are gone. Even if this
> workaround is superflous now, it doesn't hurt and IMHO the question if
> it is needed or not should not delay my fix.

That was the unanswered question.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPpdAACgkQJNaLcl1U
h9AW2wf/epfY5+fNfX7inQ4diih/d8xpOviNzpNb71+mgdpdynVe0TmXF6Lcn3me
sw4EI2zIxKds7J1Of2r3US7XO3J9kt+DqJ3uT5tlvUuFJVqk/MnMfVbZWG2OeccX
MRm5Ovg+0tE00wmHNiP6lNWJuMK9VBGyjkznwzjttaKqzfGOCqIGR5+paFD0JX20
Z1ikU9kgdFdk8E/K1WzAvy9okixqJke4BsPzAKwT5qWDuF2H6+TeTMdOA/LDds8r
PyshDXwDDtfL2clIW3z0lvkGJXCsHOHESW+2/2/N+5OGWm89JdNR0gO1Buvw3H/U
scoD/2+21EZQoYwFyAxDmfPYEFiR8Q==
=cae1
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


--===============7694963425899343601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7694963425899343601==--
