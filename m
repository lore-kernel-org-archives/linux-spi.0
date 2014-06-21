From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 2/3] spi: qup: Fix order of spi_register_master
Date: Sat, 21 Jun 2014 11:12:04 +0100
Message-ID: <20140621101204.GD5099@sirena.org.uk>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-3-git-send-email-agross@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDBW1LQyX6Jh6/q5"
Cc: linux-spi@vger.kernel.org, Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	"Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402601652-24641-3-git-send-email-agross@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fDBW1LQyX6Jh6/q5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 12, 2014 at 02:34:11PM -0500, Andy Gross wrote:
> This patch moves the devm_spi_register_master below the initialization of the
> runtime_pm.  If done in the wrong order, the spi_register_master fails if any
> probed slave devices issue SPI transactions.

Applied, thanks.

--fDBW1LQyX6Jh6/q5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpVpwAAoJELSic+t+oim9AfYP/20qOOZfppUVQCoZ4EEt3HDJ
hm3cLC6Dd/uuG8h62yMSw/J1L734ccwVbzkosazEd3BXtfD2Q0PzaSRlS56taOf+
Oj2omVv45Nz/QdJkTsxiuDLJ3j6+cCFBWUjZC/0CArvAmgcbTCAefHWwHAt5vCdC
ntETuY7kmlnCHpecG5IdUfoaGJ1deaPLz9/KPhDv2HeJKM62/Id4pR2aKHOC+iOW
khb6ZabBX8BWPk/k6fL/plWcnaMwGyLGkL6iV/ZJ6rMnmph+g7ryxFDwBX9zjVPw
vjwFjkq9EjWXDYkXesFKAhZv57UuZl+6CdOMlz7TcdtfHtbhGsqFDgMzWyrjlHk4
UHoWPoo3fV3p7aWVTg3Ym+lmLvQyWi3FtubNOaNeGMGkuyZzZLLgkNDgR5Af08AR
Y6H21MwSu+7zTswDixigTEF3B1Um/qYysn91WPkAfVSnQCkAPhwOpxuhBNyDT9MM
2ZgzKFjnw/XyTKpLhziA+BitndnHeSJNWajlqaWbQbmhGLgFMWi383G2yB17ZLDg
mYShigpqH3WdaOLu3HAqLh4t+FqNdU/rrgIVtlxTMRgU2h/4J4lKGeHXqUDn2Cyu
6bn7dYSTWMggHrZ94DAfa21tUueZT7xWpJgu2DD12NtfEyuzQYFs/DYTSIBp6jRl
gHwpyLf+sUJs5gADi20w
=oOz9
-----END PGP SIGNATURE-----

--fDBW1LQyX6Jh6/q5--
