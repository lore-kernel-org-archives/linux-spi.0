From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/4] spi: core: Add spi_transfer_is_last() helper
Date: Mon, 24 Nov 2014 18:53:49 +0000
Message-ID: <20141124185349.GC7712@sirena.org.uk>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
 <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CV9g7MldeTA+KTr7"
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>
To: Beniamino Galvani <b.galvani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CV9g7MldeTA+KTr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 22, 2014 at 04:21:39PM +0100, Beniamino Galvani wrote:
> This adds the function spi_transfer_is_last() which can be used by
> drivers to know whether a given transfer is the last one in the
> current message.

Applied, thanks.

--CV9g7MldeTA+KTr7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc369AAoJECTWi3JdVIfQWdgH/0bi+oKJ+L9Zc44KLmesnlRK
lRc9yLd5oIcuOm6sEuw7wEP8wfbhO12s3UNOtLSYYjB92bqA1HkzLtoLkJLohOLr
VpqOxRiBMlZwkgGw3uI/01YJACpC/+ckaB8lBd6mfixf2HyNL6pmwJosbhziz+Xl
qkIJS35i55YWoMHjYBEf5h2UKIK8Qn8NZa66vahRT588X8iuLkImvz4AD7mfHK+p
qrqmFP0VfFlG0lvlPaUeSn1ANkJbl4NsBZwtkfgiqFS0iv1kBebLAtnxQdIXkO+Q
lJA/neQ16z+Cg284GoHFZn6VgzbXxAztxizLHgeeEZeGkPy5XRU1AogV8oFYeAQ=
=Gi7Z
-----END PGP SIGNATURE-----

--CV9g7MldeTA+KTr7--
