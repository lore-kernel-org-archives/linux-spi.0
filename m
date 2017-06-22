From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: Use Apple device properties in absence of ACPI
 resources
Date: Thu, 22 Jun 2017 10:28:06 +0100
Message-ID: <20170622092806.pyj7ganyeoerqr6k@sirena.org.uk>
References: <cover.1498044532.git.lukas@wunner.de>
 <19c49c0351e452bff28199abcc6b3a11ec6949b2.1498044532.git.lukas@wunner.de>
 <20170622081048.GT629@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgfllhks6wa67wbo"
Cc: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622081048.GT629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mgfllhks6wa67wbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 11:10:48AM +0300, Mika Westerberg wrote:
> On Wed, Jun 21, 2017 at 08:05:53PM +0200, Lukas Wunner wrote:
> > MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> > for SPI slaves, causing device initialization to fail.  Most of the
> > information that would normally be conveyed via _CRS is available

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--mgfllhks6wa67wbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllLjaYACgkQJNaLcl1U
h9AQlAf+IlSeHe4CghYYCAz4ddy3LdcrnOiAcnDX752a4/8VlcVp4jQdizVpk9kX
NjAWenIxP9pZ/nX8hHy1MItF3SwkWL1EXixHcpwk4ACjv14PhzbKtxMAO3TjIrbX
9LfXxsb3maZgTPDGE7m56cD2HRl7Ke+ttgMi9N8efxI+UFlE+598jOsYOGMbIFDx
dWcRq5YmA7D/VL4xF/omajXFdPeSKf2S+/5Oj5oaYz9zWrrdJE23wWW1OwRvAaK/
i7JftEgb2PVIhwVTjVpVpMLSsPHjJzPeqeGUMKNi/KA173oxsFDC/SDyi0aOQKwt
JVGfQ1q/GGMm5VwC2z+TL16G4HGdKw==
=09sr
-----END PGP SIGNATURE-----

--mgfllhks6wa67wbo--
