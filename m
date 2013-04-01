From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers: spi: Use PTR_RET function
Date: Mon, 1 Apr 2013 14:33:12 +0100
Message-ID: <20130401133312.GQ18636@opensource.wolfsonmicro.com>
References: <1363252051-29362-1-git-send-email-gheorghiuandru@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nWEzmRaGLXxZdI3i"
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363252051-29362-1-git-send-email-gheorghiuandru@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nWEzmRaGLXxZdI3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2013 at 11:07:31AM +0200, Alexandru Gheorghiu wrote:
> Replaced calls to IS_ERR and PTR_ERR with PTR_RET function.
> Patch found using coccinelle.

Applied, but please always use subject lines appropraite for the
subsystem.

--nWEzmRaGLXxZdI3i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWYySAAoJELSic+t+oim9DhAQAIhs2enh9gLG/VkhJEoheX3b
7VQOPrlB0KPpafJUF2AnTNngZ3AFQqYhXnLxd1oLa90UbOBzrIXbZw+OYL5clS44
SviTEykJ5XyantswBVvxJUUn6RNT1yRwCln4F54JvleNrVUORwB15FHi/cM7/pBC
6/rr2dJfxnFv0w3iSPGvP+bcCTbPmDFCtuCFSEQUqp+od5VoexhyC+HAPmjYZiWb
6t5kFjUsqAHxMvmNRmNWYLW21xEeoSOFRaKwss6cobNSgZKSaxQPrlOQ5k8rbnOx
CJ9fJsjiZRKW+XnUXZrBWsUhwzIhu/ULyTWemTC+8HAlyuYVVQ6Uvg4wzqx8IEpg
zNF23E/BaywlkmulnlpB/OIVsgmIwRbQg0mIkr0Q9wsPvnTXH5LDwT8RNPUqKlx2
akj1s+vXMV9yyWfJ43RkGaO6HnzRVPG6cgMcsIFY0TKiK9Y8VtaMwdQOM5Gxswb8
lDl0goJdmdqV8A7QDTJHRKfSESK1TMXu9gMVxTZNanpkuUA7sPMxsZmqAqRmI3N1
+RhN8sjNoeIAAD4kUKVEVi6cp7eXrd3Y+1T+1goGtu/J/fUmEeF35M2cz2kTcp1r
eblzPL5NuWyJhEu3SJX2I2BETMEf5d0BKabik+PwQgYJtY0yZxTuhoaNJxr5UqiN
8aX6V4KedXzWbd7iCCiS
=KTjf
-----END PGP SIGNATURE-----

--nWEzmRaGLXxZdI3i--
