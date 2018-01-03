From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Wed, 3 Jan 2018 14:32:26 +0000
Message-ID: <20180103143226.GI5603@sirena.org.uk>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <20180103113805.GD5603@sirena.org.uk>
 <004d3017-5477-ec42-c78a-aba0ca0621bc@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Cc: Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004d3017-5477-ec42-c78a-aba0ca0621bc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 10:28:22PM +0800, Wang, Haiyue wrote:

> Should send to like this ? Because I add patch for Aspeed chip:

> ./scripts/get_maintainer.pl drivers/misc/aspeed-lpc-snoop.c
> Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC
> DRIVERS)
> linux-kernel@vger.kernel.org (open list)

So it's not actually doing anything at all with the SPI subsystem?  I
lacked any context for the discussion having been copied in part way
through.  If it is a SPI controller it ought to have been in
drivers/spi.

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpM6XoACgkQJNaLcl1U
h9Ct3Qf+O71i9tBjz0c2Zhz4Gw7Aa+40SQBYumF+RV8uqizKiKtHeTZGKGUKSItG
UEOOhiiSyq48OF0ZYxjZtiNEPdaE+mjugA5oBIK8xazSnYpWEGiSm1nvwqc/dHA0
IUumPA1B2PujMCHe1ukkRWoBmUtkxd6st8y4E4QtVVaumNZUIoE2YVHhdgCMepQI
Kvw7rVR/XcCt7qGBaCPIom0QXo6MdKpOPaePnwEEfLZfLW8xcBNjXYDWeIvJGICA
oVrXyyofCWc0p46Gjn2B0Xkv1SEgx1qod5j6jvGlSvtRKe1el18dtLXgCCiIpWze
+oiNwXV936c7671swana8Nh0wKNqOQ==
=n0NX
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--
