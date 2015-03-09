From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/PATCHv2 1/3] spi: dw-spi: Single Register read to clear IRQs
Date: Mon, 9 Mar 2015 18:43:55 +0000
Message-ID: <20150309184355.GA28806@sirena.org.uk>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
 <1425685594-26595-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uT8OcDz013Sgpw/5"
Cc: grant.likely@linaro.org, jkosina@suse.cz, pawel.moll@arm.com,
	robh+dt@kernel.org, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, tthayer.linux@gmail.com,
	axel.lin@ingics.com, baruch@tkos.co.il,
	andriy.shevchenko@linux.intel.com, jg1.han@samsung.com,
	galak@codeaurora.org, Andy Shevchenko <andriy.shevchenko@intel.com>
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425685594-26595-2-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uT8OcDz013Sgpw/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 05:46:32PM -0600, tthayer@opensource.altera.com wro=
te:
> From: Thor Thayer <tthayer@opensource.altera.com>
>=20
> Instead of clearing the RxU, RxO, and TxO IRQs individually with
> 3 register reads, a single read of the ICR register will do the
> same thing.

Applied, thanks.

--uT8OcDz013Sgpw/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/enrAAoJECTWi3JdVIfQFq4H/2UEa926XetfdbzNYmJMwzxK
oaTsbUOnH6kcfkSElQb/65UYRHadyg7msXcWjK4T4m8f0l5c25KZaGp5iygZNFAw
/2klUtXcVG+wd/dwCLuN+oQN6IzIDMl4gL16Jv9uUpCmZFnFqHXjwGovl63pcbW6
gnM082WDHZS4I9F7vwFmaSzq99QeViNu/8ui8XObtec15+Y15xGz6Pz3ks9W+THy
BGYsctnTPxxIs5kuh6sEnQtb/3SD3IBRgXDZ0MrbnkOyVfouub9dGlUQ+67tYbRb
+BgVUERAHRBs1MCT3TcQUftl3kmFWLa2ZbdNPCo+UY9IqZHrfz7wYS+quGcXXSQ=
=Q6eM
-----END PGP SIGNATURE-----

--uT8OcDz013Sgpw/5--
