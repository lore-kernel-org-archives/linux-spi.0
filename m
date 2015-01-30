From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Fri, 30 Jan 2015 13:30:33 +0100
Message-ID: <20150130123033.GC26617@finisterre.sirena.org.uk>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
 <1422533049999.91114@toradex.com>
 <20150129121320.GI21293@sirena.org.uk>
 <1422536382672.21760@toradex.com>
 <1a28f3439386e1132ae0f3ab80666305@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Cc: "BhuvanChandra.DV" <bhuvanchandra.dv@toradex.com>,
	Li.Xiubo@freescale.com, mark.rutland@arm.com, shawn.guo@linaro.org,
	robh+dt@kernel.org, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, B44548@freescale.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a28f3439386e1132ae0f3ab80666305@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2015 at 07:10:31PM +0100, Stefan Agner wrote:

> It would be interesting to know what the authors original motivation
> implementing this feature was. Reading the email of the original
> patchset indicates that there are platforms where only TCF is supported:

> <quote>
> For adopting of different platform, either of them is a way of DSPI
> transfer data.
> </quote>

> However, I don't know which platform that would be. Also, it seems that
> Chao Fu's email is not valid anymore.=20

It's not clear to me if the above means that this is due to hardware
differences or due to tuning for the platform.

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUy3loAAoJECTWi3JdVIfQT0AH/ivYInkslNKtgOjFvD1qExRK
PNLhOEsELIWSYyVdihg8Oam8IJMbYRUw8dqeTjib5mVC5fcZjBpe0XZ4wb3JTUJU
IFoXoByRpNRg3hH8I2XxAO8W4wtU9YEZmYxc5M83ozFi351nhlgvJU+QK9Z8eL3z
i4R2SRRlMukjXyHMmWNs6w9amf/GLBrfG5EX7WFdiId/8wou4LBE0HS7QUHuxNur
Ok89ifvtntzDfzVlMN5A9PCDXp5F3SznLTpKCIcVMi+fvjF2TyFKQ+6vvu1T/rFB
6pmemhZZqu+9E+D5ZcJ3VFuh7Yt1R0cfIaPCuMos5Lt/+mLYpvIyD/DjdL1AtxM=
=tQfU
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
