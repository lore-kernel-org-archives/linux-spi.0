From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
Date: Wed, 27 May 2015 19:39:08 +0100
Message-ID: <20150527183908.GN21577@sirena.org.uk>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
 <20150526120853.GB28523@lunn.ch>
 <556464F8.1020707@free-electrons.com>
 <20150527174547.GI21577@sirena.org.uk>
 <55660343.9060200@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cJGOKTRR6tUZnRC6"
Cc: Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55660343.9060200@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cJGOKTRR6tUZnRC6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 07:47:47PM +0200, Gregory CLEMENT wrote:
> On 27/05/2015 19:45, Mark Brown wrote:

> > I fixed it up locally (in general it's easier to just send the patch
> > though).

> Thanks! And next time I will send a v2 then if it is easier for you.

I'd say it's just easier in general - "can you please either fix this up
locally or apply this patch" means that whatever the answer is it can be
acted on immediately.

--cJGOKTRR6tUZnRC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZg9MAAoJECTWi3JdVIfQKVwH/39m3qgNUulvxJy/o8waXCbZ
ZGMJXxbAJuX6pfsS7LE8Qrti9Sf896qboJuh/L6at6Kq97EKaVaKHFuXvb5cybg3
fqfeF4MwaS8ZHr+Z7QOxeOw4ZL5CfNppYYBaJO9RjaT1kzOGoafmEXaJSIpMGnSW
9zZRjtFwUWAembdNUPpALq4VqgKDDLDREguZNU2CY1w6ykkPUilFAYC55LDfQvMT
Yg+UVVVJi8uuMc2kUh54++ecraMuqCjPwkLDAqddDcIebFixHIZjOrqm4Lk/8ioe
7ywRcQyZKYmq87nfbGSe7fhRuAgsFVREFmly8w07DWXUt85pD7y/+hmHhqn9Phc=
=jwq2
-----END PGP SIGNATURE-----

--cJGOKTRR6tUZnRC6--
