From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 1/6] spi: Extend the core to ease integration of SPI
 memory controllers
Date: Tue, 6 Feb 2018 12:06:50 +0000
Message-ID: <20180206120650.GE5681@sirena.org.uk>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-2-boris.brezillon@bootlin.com>
 <20180206104330.35ffb946@smile-e5570>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Cc: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180206104330.35ffb946@smile-e5570>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, 2018 at 10:43:30AM +0100, Maxime Chevallier wrote:

> As a user, what prevented me from using spi_flash_read is that it
> bypasses the message queue. I have a setup that uses spi_async and I
> have to make sure everything goes in the right order, so I ended up
> using spi_write_then_read instead.

> Is there a way to make so that the message that uses exec_op are issued
> in the correct order regarding messages that are already queued ?

> Maybe we could extend spi_message or spi_transfer to store all
> this opcode/dummy/addr information, so that we would use the standard
> interfaces spi_sync / spi_async, and make this mechanism of exec_op
> transparent from the user ?

Or have the flash read flush out the queue perhaps, might be simpler.
Pushing the memory mapped read operations through the queue does seem to
defeat some of the purpose of having them though I can see it might be
needed, I think the current applications were read only or at least read
mostly.

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp5mloACgkQJNaLcl1U
h9CnTQf/RgIMXDTKX+XvD0iWFt3K/k6hK5BJXNz8tPGFTW0qmm3pFETDPS/xD+m7
nQrmFksa+BP991QIziVJxiavdJC0wuTpz9Zvjt6v6ioPmwOKMoGziv1AnE1ZwkzJ
U3Rbb5uZao00QaH8MEffbUUK8MZ6g80TXQzUMlJEqZzUSiOx6Vkfu8HGve3X0OxH
+WQmTKHNz/S2VY00X4m5Gjlju2szBIo97EQ/X//XzX8AY+GGsI3JU5sSGaACvpqn
3G+hwFsEtuYhU3+HLjuIBmhoz3nqn2ZWGfTakRHHBg8XFIb95YZjdqlXIypzLfv8
ThAkJe4X54RaVLPo+oTxuBXQDdsR/w==
=+CE3
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
