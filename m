From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: add bits_per_word_mask check
	in spi_setup
Date: Fri, 28 Jun 2013 11:40:47 +0100
Message-ID: <20130628104047.GB27646@sirena.org.uk>
References: <1372287286-12682-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130627113522.GZ27646@sirena.org.uk>
	<CAHG8p1DeSojQ-kn=GZTFpaepUTDCme7NA+=Vani3zK1QePDCzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3129787904781381832=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <CAHG8p1DeSojQ-kn=GZTFpaepUTDCme7NA+=Vani3zK1QePDCzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============3129787904781381832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uGfvy/wIzDEoxfv"
Content-Disposition: inline


--3uGfvy/wIzDEoxfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2013 at 10:51:44AM +0800, Scott Jiang wrote:

> > Thinking about this a bit it might reject a valid transfer - it only
> > checks the setting in the SPI device, not the setting in the transfer.

> But the API description said that this call would fail if the protocol
> driver specifies an option
> that the underlying controller or its driver does not support. It's
> strange if I request 9 bits per
> word in setup successfully while calling it in transfer fail.

Yes, it's a bit odd (and I'd never expect a failure to actually trigger
here that wasn't going to be repeated in the actual transfer) but it
seems more robust.

--3uGfvy/wIzDEoxfv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRzWgrAAoJELSic+t+oim94IAQAI9bzH5ztqEvji809xUj0kFZ
2DWsLO//m2DDJl6SPYoNbc++9dN3QemoL8+T+VR8++YU+Og5iXMm/plcyoavK8e3
mJpugoRX1eAnv/B8HGqF8t1gRRfZSOI6nQJUPNvOFu7HUNX5Ovv+3j+sb25g/6tU
/uvI3q5Z5VVkjMtQRgjWIO0siMTuq3mUG4PkKVs+k3Zev1A5HAj2abmDRThM/f0L
mTbjyAJ+hngc/Bk6PunTnBVyMzKUlnCEjp8dp81KQcBAFs0fwOvv8mNfMnXHaEJI
G4STwNmVWvs7+HBuPk7DvtVB8WnQxHItA3QImS2feGXqb3U6OyCvE2GRdjQeS1Oi
mSYsx1H4k9Gaki0+PZhF98X+4gqooryBVGAGFitoIEX5SrULHaPFHzKKcAHP6W3A
Aqn6Pd2eyfYDf1gEo2JY9mymHFy15i4hEEfI8xsc/hsXIXYftf5E9ioPi1y+y4tN
zRiuodiehEgNfqc7iwIzsX7IaxV8Wyd2uLUy48uBc0aRcfXTUMf6idwOoNSZa6vP
rktjCCtAzg8TS8CtvPLXKMD9KRDG7ZxDc4Z8tDoEDZirGqvSAzc3+WSBjQHUDKH+
TBusO2XFYuDUfwFzRiXShYCIwbz5ZbF4VTgBnD3N4+8ZvL5yX958BBYDhZFlXgoc
lWwVnVI4JP8VbcLJ72pg
=6xRV
-----END PGP SIGNATURE-----

--3uGfvy/wIzDEoxfv--

--===============3129787904781381832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============3129787904781381832==--
