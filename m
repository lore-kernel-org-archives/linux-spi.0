From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add missing check for polling mode
Date: Thu, 27 Jun 2013 12:15:18 +0100
Message-ID: <20130627111518.GX27646@sirena.org.uk>
References: <1372316213-30671-1-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGqVP2YgkFRp/g3j"
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Girish K S <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1372316213-30671-1-git-send-email-ks.giri@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--zGqVP2YgkFRp/g3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2013 at 12:26:53PM +0530, Girish K S wrote:
> After the patch "spi/s3c64xx: Fix non-dmaengine usage"
> with commit id 563b444e33810f3120838620c990480304e24e63
> submitted by Mark Brown, the spi device detection in polling
> mode breaks. This revealed the missing check for polling during
> dma prepare. This patch adds the missing check.

Applied with a fixed commit message - since the dmaengine stuff was
already in mainline at the time that polling mode was added the isse was
that the patch hadn't been tested with current mainline code.

--zGqVP2YgkFRp/g3j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzB7DAAoJELSic+t+oim9QcIP/21pNCpKuiZJLbdpuNi9kFqY
O2LbgrAU7YR2hAQcPF/N+h00vHV0SoBCw/ADdKzVp8md0vz7I/UC4CLlufUlETQH
0HnxsZBuhLcVtawJS4u1dH9pI+m2sqksRM8RPKLHygKog69MGoNgxm9mMnZ/LXMR
DgxTmNEbVtTqj9eXBa/Bkeby89Yc1c7LQcQ32Of3rwTUnSdPYHDL+zO6y6bVexrF
49ao1nglwM74XhdWMVUwBEWI67pvkX0y7uOhTojYNTjIXJDCgV4qtF6sWQfAkyX+
3RRQdZp9FGbeLkEFtnFTb88wQ+EoZSiVKzCyHqhGTceC5kgjEF4mMUixnPI25F6w
uz85T6YH10eAF2yfnkA61eJre+xpf2cjg3lhCuQKiJz75crEBqpW+Xp1Kuo0Tm+E
93KC7fMXEqGNLHUuMgHqvYFwUi+WHO3FkpQkNRDx0rg8ryLubogbKTPabkVXF7W1
ihWxrHSqA5s9A/GEOj0Jy6k9qQZu/LQ5JhAY01CVRk9jxHB+yWaQyYSpP971q0uF
fIyZ8/kDPXOlJU/6yqkdCMtghqg4DzTb8Kpm3DEJSCXhUTi4gmy19JBJHVY4392r
0HUSjxf8V1JWIjOYDUD7DblCs0qmvSrCtfSLxvsX3hEHQX+tzUDsDIzygWN7iTaO
xmg4ayny1T1r/fLIj9yv
=IZx+
-----END PGP SIGNATURE-----

--zGqVP2YgkFRp/g3j--
