From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: tegra114: Convert to use master->max_speed_hz
Date: Mon, 10 Feb 2014 18:27:28 +0000
Message-ID: <20140210182728.GE13533@sirena.org.uk>
References: <1392040096.4191.1.camel@phoenix>
 <52F903EF.4030606@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52F903EF.4030606-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 09:53:03AM -0700, Stephen Warren wrote:
> On 02/10/2014 06:48 AM, Axel Lin wrote:

> I wonder ...

> > +	if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
> > +				 &master->max_speed_hz))
> > +		master->max_speed_hz = 25000000; /* 25MHz */

> ... if that DT parsing can be done in common code too?

Yes, there is in general a lot of opportunity in the SPI subsystem to
factor code out into the core.  The DT stuff (things like this and also
GPIO chip selects) is part of it.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+RoNAAoJELSic+t+oim9hAwP/Rstk5lYgfjc2MAZDQ3fK9UB
boWprsebj2YT5T7T0I81Ixhxan7JGzhfDE9TDnDuR1zk1h+nMjmU1ktMkkxsuWsI
eprnOmBgPJev9Bbopf8y/QXcRXQC/uBBwAaPrnvsTu+fF2sBjBJzGakx7ur0Ixcg
qaH87X+fxDvlrdL6rE5x1pxNuqn59hbmkQ2POC1QCyCe4m6XCr1470cycIjwfQf3
fcb5K3pf5273aKMUvh8UU6XrM6UPSCTkus7ciIw+IOl0PsAkl7uyx3gaGB4Ckhes
MDAHPnFse5tFjhkpK6vMRJ/dqioSPgFC6QH3SWtCzjBoOC9fGpwl96RjWQHAWheY
QkNK6Hw179YejninAY9gFVMMPhzzoFFKOwVfOY9Xra7oTcfoi4lFrf71wjSu4g71
utIzvKXKRonmE7grQpspycu7flOMieyX1N8c4TCKfOp8PvhOHAPp+x6KGfdw+C3l
EKOcZyKDNFsvxUFJEVZ+LeLnRpmLX5qnd6wiwb7lj/JWxp0HVe7UEW6TVSAWAVO9
l4Xe2n09N7uM/ZvXTImApMqwJuGObZQrQBgb+j3ffNzwV2R82OxYL2D/d5X9MTp4
KzXwNJ20xyVi4lRDoF1n3JwOd1srUjzEvmRWyf+MqXGm7j0sFm5g8MHz+7QqbbMy
aCztRZqfnAdTRQeCqsUq
=1XR4
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
