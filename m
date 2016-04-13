From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: spi driver and two chip select
Date: Wed, 13 Apr 2016 05:57:47 +0100
Message-ID: <20160413045747.GE14664@sirena.org.uk>
References: <CAF+MRt=ZJP2fssLHRUoR9T9EPfWEPN1LC0CLxZ0CgJQy01S3Rw@mail.gmail.com>
 <CAMuHMdWtHYNLcbX65HzuV6fyPENMR75XrVQ8RkW=y_T=hN44+g@mail.gmail.com>
 <CAF+MRtkyjeu6baWXX-hJathGjAkwz+REExzUBNWtJCROv5KrtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF+MRtkyjeu6baWXX-hJathGjAkwz+REExzUBNWtJCROv5KrtA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 01:56:27PM +0000, Micka wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> Do you know a way to fix that ? Idea ? How can I prevent the problem ?

The driver should store settings in driver data (probably using the
device controller_data) in setup() and only write them to the hardware
only when it starts to actually interact with the device.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDdHKAAoJECTWi3JdVIfQCKYH/2495jvx09VGb6VR8yt4Dcho
lDoNFZVAaE1cwSUiD5bLP8XXa9d5zJ9scKLwu3x3+jMpudw61CaNqVJpSIqN4cyw
b6uW09IIGjzYkoCM01LGVFea4jxb72HtYKwyr6CypD9OjjeIv5wBGLvHHhcLMPXN
Va5ML4EjwYCPNfzR2otzuoknWvVu7r09Ud7dc+Kx4dozn1HwLK+QKO1Kik95qA1p
EjWqapbIJVbsw0jlDSitbGX+Uurv5kIEIlGAjq9uf7ylCxcS01UGSk3upEfs+VJp
MO5arVYHkH0JoStZr4EY4s6DVDiKU3wK/N3aOWKuAe5U1h3NDI59i9+2pVaHnmU=
=nw31
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
