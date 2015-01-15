From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 2/2] spi: orion: Add multiple chip select support to
 spi-orion
Date: Thu, 15 Jan 2015 11:22:13 +0000
Message-ID: <20150115112213.GT3043@sirena.org.uk>
References: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com>
 <1421032440-15335-3-git-send-email-ken.wilson@opengear.com>
 <20150114200626.GN3043@sirena.org.uk>
 <54B712C0.5010808@opengear.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TJ9V72hR/LoebVea"
Cc: thomas.petazzoni@free-electrons.com, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	ezequiel.garcia@free-electrons.com, gerg@uclinux.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Ken Wilson <ken.wilson@opengear.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54B712C0.5010808@opengear.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TJ9V72hR/LoebVea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 15, 2015 at 11:07:12AM +1000, Ken Wilson wrote:

> I agree that we could support any sane chip select for a slave, since the
> slave addresses do need
> to be explicitly defined. I'm happy with whatever your preference is.

Just accepting anything seems easier both for users and in
implementation.

--TJ9V72hR/LoebVea
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUt6LkAAoJECTWi3JdVIfQboMH/2FrwA8VEDSQZzlbas58eEws
vD1EgggndHLeSSniFHUblzCjn6CGldTpIHlFi7OUrsoaHkASWhEtDyCfrTG+AUec
zVIA1rHqYSOXZXFIZynP9QM7a6P43Fh/WaVN0YkUb0rSnxC4CsJx4KxILgiVdaSm
bY6rh1oc/tQU/FghZvJiTIHGbhviuNLcjvrvUvydLVZDX5xQkb0QerumMFD8MVcu
6Mnpd1wNfcz7YIcL7LoDxJ4KTp6Op1g9sQVcqHJSpSFfQ99rRCEycytOWDbulL9j
LPpgFY3RecxnOQGdWW4BxvZbCds4GV3aHPE8IjAr4l5+Xiez2gbUg6pj4Ar0n2I=
=pf3A
-----END PGP SIGNATURE-----

--TJ9V72hR/LoebVea--
