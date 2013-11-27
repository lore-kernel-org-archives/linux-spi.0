From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: sh-msiof: Fix warnings due to improper casts
Date: Wed, 27 Nov 2013 15:49:25 +0000
Message-ID: <20131127154925.GA14725@sirena.org.uk>
References: <1385547486-13802-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NRg0qHkDgHfQnopc"
Cc: linux-sh@vger.kernel.org, linux-spi@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385547486-13802-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NRg0qHkDgHfQnopc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 11:18:06AM +0100, Laurent Pinchart wrote:
> Cast pointers to uintptr_t instead of unsigned int. This fixes warnings
> on platforms where pointers have a different size than int.

Applied, thanks.

--NRg0qHkDgHfQnopc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlhSCAAoJELSic+t+oim9PzQP/jglt41bJnnNUUgfZe+WWAMf
rDluLN2nH4IluqwDDS17aT20yxUmwCkVFAlC4ZyICh2FOXo571HEpiUiWa2SChTm
a1d/FCAi66JPkN5cZHTSOLI2Mu1rBr3BXZEBuEpmMNMwDsfxKf0W9wO67NrJwDgX
pC8IGF0FT3W0+wQElGtXCAO+cGHCevgAHHkDr7SD+5fUzEv5OhY0GhbUrUhR6ui0
K8uWK2DbMtpnG1CTiJaGhPv8c4WMWVKu4voPSrrptXavwIMCGVR3axvuXG4DFKOR
vIpNpr0RCGjN9G44oy/zVB4I7w0Lm+Xz/zcZ5iEkYeVBACxhWlTvkrBtC32156R3
nq90MLeWFhlmKuHN0/5I0pv5vY1wS3v/PDP5I8gxnQrFdbcVA5r64BKNRnxVUU2c
pmRAcg174VzXrzGSz+ofvhqUcktSscZ1DGNzkJ+5+41LPad09jKB9CYsbNjfiS5G
xNEJqZlOsrGtQSn97KnLW9O86JvOe2Q1cT8uZoqNp7js6MAzgZRxiQun4BrbyI+G
bS5rP4opzTh6XNncpIdoQOntqLru9mhPWTlMi1ufGtNXLiVmOB1Nji2QZEqaTvNB
iFqB4bRB1R3RIHQwKhSsKzu769/wiP91kaniKwfpU3jPtl+HzIBBj7dQxSQ5JGb4
V1xlqvW3dsVBM8iirwuv
=t5Gu
-----END PGP SIGNATURE-----

--NRg0qHkDgHfQnopc--
