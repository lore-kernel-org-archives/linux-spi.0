From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] spi: s3c64xx: Added provision for dedicated cs pin
Date: Thu, 20 Jun 2013 12:21:08 +0100
Message-ID: <20130620112107.GD27646@sirena.org.uk>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
 <1369032694-13183-3-git-send-email-ks.giri@samsung.com>
 <20130619182354.GD1403@sirena.org.uk>
 <CAKrE-KciiPe5Zx7ggxzh=x0xY0xGDhX+=Lt7aL-EgkxinO214w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	grant.likely@secretlab.ca
To: Girish KS <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKrE-KciiPe5Zx7ggxzh=x0xY0xGDhX+=Lt7aL-EgkxinO214w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 02:52:07PM +0530, Girish KS wrote:

> Reversing the default assignment for "sdd->cs_gpio" and the following
> "if condition" shall handle both dt and non-dt case. Will do it and
> resubmit only this patch in the series.

You'll need to resend patch 3 as well, I stopped due to this one not
working.

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwuWgAAoJELSic+t+oim9WE4P/Rp6PLtmemEVABQhcaRZevq3
X8mM1ShwSCPqD7AZ1bQ/hwnkG+sDbi/yPf3pbGbKc3upIFaLki7WQeT34BaVFFny
OuCAxJrC4g1DIN3o1oH2+TDg3adTGjUXZY8NbB0HWYNWR9mv2n/ZgwG83JBd3t6J
4/P+qSZgf+kC3QgwVsq0GE1vQ02E6E3DbN6SdTGBpc9mxyV7zABqiSqQXpBdyN5i
fCDkqMYcDDUAS+jLXWbKTaAcfFvbWuCQcNxa4WbmDO+uG60FPk1bCskFCLs82sjr
dSEulc1MuqZldzJGqv5xaWZ2tNjIwpqKcs2FCWiZOoe+R4f8xQ/wOCsdd8rVPLfB
mNYzNAiDBJ/GwdkoVEewvF5slsCc0e18c3piVM/GOK36nmfzSXMHo49V6i87ifDx
UI+U1HagHB6YR6sKzn3sM9uFRYBYpcTvHr06Yoq9tSn3qpJdoSlTEy75cxzaGEDE
/PWTVvASWizsAMjzsC6j7DNqiH+cNACN98XdaaNMH2VrIn1gz5v+jfj71murNslP
9OyIWkYF1EHBY2nFA2DrP7SeewZLH4wQdJWA26U3FFWfvD9XbzuR/2iYVuQaE/Vs
aPsU6RTxbugLN/b8riLOxJJPKtOQV5AUmIZxymiM95p6IyzeEPN4BAlA4wOUEf9W
8bW94M7eEEhcwd0U5D84
=dLBS
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
