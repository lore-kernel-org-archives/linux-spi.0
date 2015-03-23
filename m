From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Mon, 23 Mar 2015 11:50:42 -0700
Message-ID: <20150323185042.GL14954@sirena.org.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qgd2S+2VS1hsWwXW"
Cc: linux-spi@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qgd2S+2VS1hsWwXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 05:50:27PM +0000, Ian Abbott wrote:

> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: <stable@vger.kernel.org> # 4.0+

This doesn't apply against Linus' tree as far as I can tell - if you
think this needs to go to stable please send a version that applies
against that.

--Qgd2S+2VS1hsWwXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEGCCAAoJECTWi3JdVIfQtWoH/04X7RAnscSz6x0OoSfZKDd7
5RcNzsSBW8XUz2I5QEw/kms9b61YJSvBPwPx+3T7D5oXnCXdXC51DisPbTQ6kY9o
iHd7ntyPt7536CbmkZQUHURUtqWFaj4oj2KowNbVpEUGVyTWoflYQ3VHkRnzz141
t9/tUu3c9SCgUQKPKdzcca7eZ4ZUlI2as8OtQk5jxlOWMJnyQr0SGptrNzo/T/5p
xCW9fZxs67EquKPW/9YEmbZOwj28iZzSZzjMxjB8Tbih4hWd46ywAGtcLr7zSbPI
r2yZyeL1SG0sqCufb6TKHCT3Z4d4w2jDoC9RXChWK+C5Yw7wm6ovgCxlVEQ5S54=
=07vN
-----END PGP SIGNATURE-----

--Qgd2S+2VS1hsWwXW--
