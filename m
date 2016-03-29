From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Tue, 29 Mar 2016 12:52:30 -0700
Message-ID: <20160329195230.GK2350@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <29105031.S6XB0bXn2i@wuerfel> <20160329164758.GQ2350@sirena.org.uk>
 <21028994.N5ajfyoUoV@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3867999635056615662=="
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Gregory CLEMENT <gregory.clement@free-electrons.com>,
 Stefan Roese <sr@denx.de>, linux-arm-kernel@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <21028994.N5ajfyoUoV@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3867999635056615662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8tIZwPmdq+hd82jQ"
Content-Disposition: inline


--8tIZwPmdq+hd82jQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 09:49:09PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 09:47:58 Mark Brown wrote:

> > Well, in the cases where we have one device on the bus then it's not a
> > big deal since we can check what the last thing we set was.  The direct
> > access stuff is going to have trouble if we have multiple devices on the
> > bus since we try to mix it with non-MMIO access we run the risk of
> > conflicting simultaneous use unless we continue to route everything
> > through the SPI subsystem (like we do with the current flash read
> > support).

> Maybe we can avoid that if we enforce at the driver level that we
> use the same mode for all slaves? The way I read the manual, I think
> that's how it is intended at least.

Well, we currently don't have any XIP or whatever support at all, it's
still only in the SPI operations so it's academic - that'd be a future
issue if we did start doing things that accessed the memory map outside
of the SPI flow.

> Also, as mentioned we don't have any machine with more than one SPI
> slave so far, so we don't really need to overengineer it and can
> go for the simplest implementation in the SPI master driver.

For me the simplest thing seems like just using one window for all the
devices, it seems more likely to deliver useful results without the
system integrator having to think about how to configure this for
optimisation.

--8tIZwPmdq+hd82jQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+tz9AAoJECTWi3JdVIfQWwwH/iZCsADehXxyQCiXIiykrwcs
tck/GQerXgIWTlcSDZKShaYrAZhqHN1voutZjRMkOYQzzecF/pC6k3rxmOWVDAlI
LpR0rGP3nOBZmBWKSFp8+deDZVvXpf9p6uU4Iz/hCcKMNOu2Fb3Q4nxkqhYEKqQf
gstABXywWnRLCZrvmgM0PUym5R2EKNt42wXBn4l5ZcFpAFJfhtPo4F50tx2/xbuR
OvImR+ysOfNFMg8qV/8pbh4bP8Xw4d3N7TD8hc70FRi6p91a0vPrMTw73BAAIvIh
BJUMNQXJ+qdliyi/W6IPofCfOjWGO3qN7HvRvXudU0HbCuat1n0mhpEW2V3g2VE=
=kPET
-----END PGP SIGNATURE-----

--8tIZwPmdq+hd82jQ--


--===============3867999635056615662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3867999635056615662==--
