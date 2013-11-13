From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 13 Nov 2013 16:59:47 +0000
Message-ID: <20131113165947.GY878@sirena.org.uk>
References: <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <20131113151102.GS878@sirena.org.uk>
 <77070979-0CE4-4C76-B12E-DA94B2577172@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ubca5Sl/zyRO+Ah+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <77070979-0CE4-4C76-B12E-DA94B2577172-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ubca5Sl/zyRO+Ah+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2013 at 04:48:47PM +0100, Martin Sperl wrote:

> > Drivers can supply pre-mapped DMA buffers if they set is_dma_mapped
> > which is about as good as you get with dmaengine at the minute.  The
> > main opportunities for enhancement here are in the master interface
> > rather than the client, at least as things stand.

> This is part of my pre-requisite for making it prepareable in my case...

> Because otherwise you have (again) to walk the tree to set the rx_dma
> via dma_map_single and here the API explicitly states that between the ma=
p=20
> and unmap call the caller may NOT access the pages.

So you expect the caller to also keep the buffers mapped separately?
The restrictions on mapping are one of the concerns I have with nailing
down exactly what you're envisaging a prepared and unprepared
transaction doing (plus masters that don't actually want DMA in the
first place).

> The reason is (probably) for old-ISA devices that may only DMA map 24 bit=
=20
> addresses. So the map/unmap actually is supposed to copy data to a bounce=
=20
> buffer and back (depending on the direction given).

> Typically not an issue on ARM though, I would say...

No, it's not just for ISA - other systems can have DMA access
restrictions for example due to LPAE or other things that cause limited
addressing on some internal buses and obviously many modern systems have
IOMMUs which require things to be mapped in and out before devices can
access them without needing bounce buffers.

--Ubca5Sl/zyRO+Ah+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg7AAAAoJELSic+t+oim9h9kP/394Byh/R1BCo25JTCLZ3+O7
8c6++U+MNQUiYrChQPNV/NUMhmjOzPPXKGr3Dn7h3lEdSanfnXTYujBOYgOJwG3T
y/y8R/7vIIAeAFNu3ljZR19vDoONPjaYMYkN6UcasS0+RKT08saluaNVAYsgi6Sv
rqhi69Elzt1iCcTHrWklnnOcRHBj/Mq74ZA5eq90z6BwhwUkqIGdbb5zv+Y7p+TA
oiK3VG0eHGBMfo4jJJ95uRUe/v+yGYgEfLrgnX+6WKC85kqAwtr+XwnM4o5lyxEW
9Ce8liAQlcGksLwGM7iH4EH6Wu7glpMq+5gM43KfShfkTabZi3c67qNsJgkukBjK
Yes/hjbx0QESVi84RT0B00NTlTcQ6MqDW/rM3h8mKPKh4omlVhxztBfEj6Avwk1j
mgzRkgBVE0Vl8ENPctOmZznAlnE9bY1BuN14xs4Pdo3tSdxR7VqcyxtxRyNzVXKC
YZLe75/gdCBcxoQmVKqWt7UL8BP5f73GNq0FYe+6wCHMLSKryn6Q3sgUStuVnw3Z
oYxoGelG1lMgAn90PgMj9/SO6+V+UFN803Vrf4826SdJzZ3kwtYelRapjzq13WGr
iFgziIAqn6P6xoIkL+QJq0HudpDW1mO6fvuHMJvTmq6YdKpe9Fj5egnUYnvnL+6x
kpDAjwJaZ6ld6tfnmjCp
=WWxL
-----END PGP SIGNATURE-----

--Ubca5Sl/zyRO+Ah+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
