From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: imx: wait_for_completion_timeout(..) for PIO
 transfers
Date: Fri, 1 Jul 2016 17:01:34 +0200
Message-ID: <20160701150134.GR6247@sirena.org.uk>
References: <20160621185100.GD28202@sirena.org.uk>
 <1467376378-21535-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dx1O6sYEs5STvSrm"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467376378-21535-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Dx1O6sYEs5STvSrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 01, 2016 at 02:32:58PM +0200, Christian Gmeiner wrote:
> In some rare cases I see the following 'task blocked' information. It
> looks like the PIO transfer has some problems and never succeeds. Make
> use of wait_for_completion_timeout(..) to detect this case and
> return -ETIMEDOUT.
>=20
> v2: remove backtrace from commit message

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

If you're including an inter-version changelog please keep it after the
--- as covered in SubmittingPatches.

--Dx1O6sYEs5STvSrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdoXFAAoJECTWi3JdVIfQOvsH/219SqsHkFQzGAw71MQIiVKA
cub1r1NZ0PheNPCvCakbdJCKslbad1fnxbIY++lnKh7b1bb839LXdk16MYn37Ufs
/lZ8OaGWS8smd6TBocR2LKDKj80OWqUvhunlctvWfHmceellioiWfdlWb3TSKy6/
EoXwlQaWh1gOIDby4nH13PvBtuXQgXcN1dZCRniiYEY1iCSbYP203qqC/mx08Sfc
LKx2/7ukJzpMvU+zkOCfd+oVwMYz7ckPEHxuGcIZkiEVs8lFfwc0FsSI+lH9viNt
ipQNcGfK4ejLl0ktlKn7b2mJjojA8ul8CbyFQIv0+CBn/5jM2NQVnxKor3/YZPA=
=Mo2/
-----END PGP SIGNATURE-----

--Dx1O6sYEs5STvSrm--
