From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] spi: omap2-mcspi: Switch driver to use
 transfer_one
Date: Fri, 8 May 2015 17:59:46 +0100
Message-ID: <20150508165946.GC2761@sirena.org.uk>
References: <1431041814-24757-1-git-send-email-mwelling@ieee.org>
 <1431041814-24757-2-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431041814-24757-2-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 07, 2015 at 06:36:53PM -0500, Michael Welling wrote:
> Switches from transfer_one_message to transfer_one to prepare driver for
> use of GPIO chip selects.

Applied, thanks.

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVTOuBAAoJECTWi3JdVIfQ9BYH/RnBi/RFtW4moHGpIUukvd5U
/CEYXwS6QAmMjPOjxl6KoOvUaOVGToFBzzklbPoDgSUSMvjsdIQPaRNG0b/b7SJP
RAoxJqItHrfT6V5x8rvsrcqd1gHrJnGw1dvqy6W+e5prT215FWXrWNpRZi4aR6fN
efanbUVW/urnszydGWew3OlLNZ50edqdCnc2laSRgCO/Exjo9VBNyp+ap9l+MbHB
i7XgQjRtw50LkM8ZQsm47TO8i3fuiDKV3HkbuwBudMANExRAXLchbUHeSxYJ/cAo
yDTfFgWKHB80FLC7xz1XuBxi1s2uIH/PgENFbmorj8BfTfblDygJDo7zOI0zNsg=
=vRRU
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
