From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] spi: atmel: update DT bindings documentation
Date: Mon, 15 Jun 2015 16:49:35 +0100
Message-ID: <20150615154935.GT18309@sirena.org.uk>
References: <cover.1433850255.git.cyrille.pitchen@atmel.com>
 <ce7c16faafaa24f5bb711115c0eea1f8992d08c3.1433850255.git.cyrille.pitchen@atmel.com>
 <20150609172531.GM14071@sirena.org.uk>
 <5579B95F.9060307@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6axCafNXXMM8qu6Q"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5579B95F.9060307-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--6axCafNXXMM8qu6Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 06:37:51PM +0200, Cyrille Pitchen wrote:
> Le 09/06/2015 19:25, Mark Brown a =E9crit :
> > On Tue, Jun 09, 2015 at 01:53:53PM +0200, Cyrille Pitchen wrote:
> >> - add new property "atmel,fifo-size"

> > Why is this a property and not something we know from the IP version?

> Please be aware that the VERSION register can not be used to guess the
> size of FIFOs. Indeed, for a given hardware version, the SPI controller
> can be integrated on Atmel SoCs with different FIFO sizes. Also the
> "atmel,fifo-size" property is optional as older SPI controllers don't
> embed FIFO at all.

=2E..

> Finally, on a given SoC, there can be several instances of the SPI
> controller with different FIFO sizes. This explain why we'd rather use a
> dedicated DT property than use the "compatible" property.

> I hope these pieces of information will help to clarify this point.
> Of course, we are open to other suggestions.

Ugh, what a wonderfully consistent hardware design :(  Please make it
clear in the documentation what is going on here, this looks like an
obvious bug in the DT binding - a very common pattern for bugs is to do
version quirks like this as properties.

--6axCafNXXMM8qu6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfvQPAAoJECTWi3JdVIfQDywH/RbQKXr2U2+f72kbeIxz56M1
3mboyhxyFzn7whzNbyAefS1lWdIQvVCv841JHRuAgBJj8PSTwkLYFC5cOuQTe7Nh
qEm9PnEA5gk0/W5WbxixprOR9llRw538bX4ad6XmKNORnSF7q9Ch+lx0bNV50v7+
4mSu03rj7VmMgLwP6SpAA6BT9Eu707bSWMpUgavpgGWGfI7nXXlpdolYQ5PVfr04
qM3Opabni7yTUi+YSMiR4J7mSzZnUbCroqtEkg4j/c7R2oTCHYrNF2N9mj8i8vRj
q5W1yfc1cCIFFR/Yx2Twy4inrY5+ffKLR9YD3HcLGBIf68awPHGHMlVQXJBOFRE=
=aZfm
-----END PGP SIGNATURE-----

--6axCafNXXMM8qu6Q--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
