From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Mon, 27 Jun 2016 21:32:33 +0100
Message-ID: <20160627203233.GH17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2016 at 09:40:38PM +0200, Michal Suchanek wrote:

> No. It's for buses that have some inherent identification. It's not for

> 1) generate random compatible and stick it in device tree

Don't generate a random compatible, generate one that accurately
describes your hardware.

> also AFAIK new_id is not automagic and not all buses have it.

Yes, this is the bit I've been trying to prompt you to implement rather
than going off doing something broken.

> So it would have to be implemented on SPI. How? On PCI new_id is a PCI
> id. What is it on SPI? ACPI PnP id? DT compatible? How do you tell?

Those sound like sensible ideas.

> And why when the bus does not even have IDs?

Identifiers are just a useful way of describing what the hardware is,
the fact that some of them can be read back from hardware isn't terribly
important here.

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcY1fAAoJECTWi3JdVIfQVwwH/R0gzaz5ziW0io9PbO9fDJi6
9VPVg/P/RNaNjz6Y5+c28MTI0JtprQmJZ2GPugK2lEGRibl75XtVxAZYzf9o+hW7
oS67NrmKCxuOr+GGlKpqVgCaUebZfroBUHzJ9eJTSGvVWhMyFJ5g/fKZfRMSaUfv
Vle9Il1lWMDIEsPjSGvmFyIIfou3mKg8vF0gzqnE92+3E7HVddtm6/zw8uDUuXdD
iG6bkYxEEKeDTcVQzfGE6P8GJ4AzyfwHD1xMuXdHUiQW1D2D6L7CsLL4/oRrEBG6
gS56AL+3hYstDXKVfu7piUy1s6gIJ0HqiM5q8/VJGUdzReK5kmudFha819j1DsU=
=gFST
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
