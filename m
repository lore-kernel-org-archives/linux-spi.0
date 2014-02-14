From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c24xx: Convert to let spi core validate
 bits_per_word
Date: Fri, 14 Feb 2014 18:09:21 +0000
Message-ID: <20140214180921.GF4451@sirena.org.uk>
References: <1392381496.31961.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392381496.31961.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 08:38:16PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/lvIAAoJELSic+t+oim9CpcP/jCZhFEOis8emNTY142k3XAz
TNcD+QcwMHkcu1b2rBxrCzWfj81Dw0VznOmmKedVB4uTGqoYDRFuTEZ9zoGDJjRx
tVhepCvZrWMbTOxarEif/p5j1YUNJ9Mv3oe9qI+PdmNL9Xh4Kj8I1tNXzdUytmfj
Conps7LSW6zI4fkyyHyQH69VU700pQhEjWWDMvz3GYzE4rGYABiOC6rgOABRvquh
rtkNgt8tC0l3SwpPmiCuI723G9VddDAFUFbH2JimxQa2chCHai7qwoafUPbILrcH
miqZPU7bosdJa7TRXDvXbUwCY++BnV/Dt4IE2HW03/RPNKam08yqF0O1HkgE2YvY
iCfsifrx30kRGHT0Pee4vvl3ZqoGzBAXzidCkUfDkA6ZKnQ712+P7ozbRZOzZUSA
ecdtaY3OSSOurPcGiOvILghhpwUyZoTN3sXLHO2ZE7dZsWdYJDrrkxtok5q+Pcia
rMyvGzQ7yetCHvNpacm6hyGoDWCfROqXxo6cALGga4YAJxbx9O8DllCvFzTO9CTh
koaSgmoqzcbb4LfrNcyV4qNjTohLjtgWmI6Id+sQ7L6thDACwQVFmLb1C3UfOwOr
k8ULBVTa0hrA4Wv/Z+EIi9eg9Hr9J/cONT+bziBCMAaAyo6LetN4Iau0vXi5DJwQ
GsLNF5Myf9s6TaIkt0Pk
=ZuEJ
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
