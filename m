From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] spi: spi-fsl-dspi: Remove usage of devm_kzalloc
Date: Tue, 27 Jan 2015 19:52:34 +0000
Message-ID: <20150127195234.GP21293@sirena.org.uk>
References: <1422356244-15629-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V2D0VtBIapj4C4hL"
Cc: mark.rutland@arm.com, stefan@agner.ch, shawn.guo@linaro.org,
	robh+dt@kernel.org, pawel.moll@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux@arm.linux.org.uk, B44548@freescale.com,
	Li.Xiubo@freescale.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422356244-15629-4-git-send-email-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--V2D0VtBIapj4C4hL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2015 at 04:27:20PM +0530, Bhuvanchandra DV wrote:
> devm_* API was supposed to be used only in probe function call.
> Memory is allocated at 'probe' and free automatically at 'remove'.

Applied, thanks.  Please don't dump entire backtraces into your commit
logs - they're far too big and not very helpful, they can obscure real
content in the message.  Explain in words what the problem is and if a
backtrace helps illustrate that edit it down to only relevant portions
rather than blindly including the entire thing.

--V2D0VtBIapj4C4hL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx+yBAAoJECTWi3JdVIfQ1dIH/RazSTyXAf0/KYwBdLpXRnaI
Srtfx2q39mTxoHeUzBlxK1ViJ3C+FieTDHNH6n7W603G7hmGJ5qvdhv4pjmK4Z7+
xJ6M6O20SZCyn8V2XwwK+YrD1yaYxaBiwKq3B5TLjxg54wDqdCWTLXFKwVZ6DeCQ
DODlHU73Dn79xp4fIMRs6uXyshadx1bp2gNVfdAu4FXp7vXi1CZESBXcII2sVzb4
CT0LdhKmIsqbuwSB/NxIHb1QxcLS6dWBXoES1bdlXLBjCzwKlUxdnSY7sJIp5Qf2
2T7gRnGhatMe5R3NPwGMHZeRGLDw0Cz+vtwm9rPSpeVIl6PvYh6s/bNc5/5emqc=
=91Ri
-----END PGP SIGNATURE-----

--V2D0VtBIapj4C4hL--
