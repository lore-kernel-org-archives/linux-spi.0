From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: orion: fix incorrect handling of cell-index DT
 property
Date: Mon, 28 Jul 2014 22:30:53 +0100
Message-ID: <20140728213053.GH17528@sirena.org.uk>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gcRizOIrS73O/qKd"
Cc: linux-spi@vger.kernel.org, Shadi Ammouri <shadi@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	stable@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--gcRizOIrS73O/qKd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 27, 2014 at 11:53:19PM +0200, Thomas Petazzoni wrote:
> In commit f814f9ac5a81 ("spi/orion: add device tree binding"), Device
> Tree support was added to the spi-orion driver. However, this commit
> reads the "cell-index" property, without taking into account the fact
> that DT properties are big-endian encoded.

Applied, thanks.

--gcRizOIrS73O/qKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1sEKAAoJELSic+t+oim9048P/3DS7x2U4ZgJfhZhx11FflEd
0a3k3YGof0Njd9iKYvOPz+yfKXqoRIdu/9opwww3xpbJ0DmYm+OjwPDkXt5KDHpJ
sSP5a1QRss+x/cM6TfPLIHDw3ZBSDSwMkrJqKN0oGsG4wojwCSccBiqJ4HstdC0e
93AQolTYkJqQJsSY1SVKjVimHeCCNbhO56GWr2zLbeQDlA7SiRLtgu+NOlNKarRE
S2vsudPXqYRhzJeilxrI5R2AeFtmbxT8VbM6oDKjQRV4S5LGV0NOb5ROY2YmLOMy
E4A7ue4d0ZvaS5o3cXgYggUGqdXGkK7KSZ/jL3/db2eG6uvOupB8V/GH+fke+g/D
q0OJlicCSAlCtp0IA77+qKSSUraelISAaGnSLvpZf6LNEFve/FCC1I3YprrCFK7V
j1N83h+g6i1PqxwswW/JhnWc/S+KOhr4C9V27AgTqGO1JGAs4qYHC1mehwIIEy6j
uFWMhFdUFniBnTg6unkME23va7DHkg80YqG/8LS3wQMVkYMQZpnJJg9WbLIUyDAC
/NLa4pJ6KEfg3chSFuEh6C+6fNZ759x4EgKCQYzs6XK6WKQ6rHwvO8QL6ygVZSEC
EQCtodzpraag6KGPkSKfhpvrDm3Qvn5eVBCwRW1+S1ehfkmGntD4pRO5ujIghH0S
D72kXRBC+S1Phx4axCrx
=S6IS
-----END PGP SIGNATURE-----

--gcRizOIrS73O/qKd--
