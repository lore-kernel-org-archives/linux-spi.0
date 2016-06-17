From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: do not fail if the CS line is not connected
Date: Fri, 17 Jun 2016 13:28:03 +0100
Message-ID: <20160617122803.GN26099@sirena.org.uk>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
 <20160617113622.GA10760@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160617113622.GA10760-A05emIGRluN/OPZsa/fw/Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 08:36:22PM +0900, Andi Shyti wrote:

> > > In this case do not fail and defer to the SPI device drivers the
> > > responsibility to check whether the num-cs is '0'.

> > A SPI controller always has one chip seelct, it may not be controllable
> > but it's at least logically present.

> This is true, but there are cases where the CS is not connected
> and this case needs to be treated separately to allow the device
> to work.

In what way?  It is just as easy for a device with no physical chip
select to have a logical chip select of 0 that it does nothing with as
it is for that device to handle any other number.

> This is the case of:

> ./drivers/spi/spi-mpc52xx-psc.c:391: master->num_chipselect = 255;
> ./drivers/spi/spi-oc-tiny.c:256:        master->num_chipselect = 255;

> ./drivers/spi/spi-pxa2xx-pci.c:64:              .num_chipselect = -1,
> ./drivers/spi/spi-bcm2835aux.c:436:     master->num_chipselect = -1;

These need fixing.

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+zFAAoJECTWi3JdVIfQakEH/iVX1C7bDNxvwfKfmQ9Uq6SE
isu3+MXuK1/57RmhP/T4rzfiGsig0onzrV6Rcimk5VnyjN5Y2kEd96Uv1OkkOAOB
UAIiywT0MhboRAni0KSuUGn8f6E57jIMUbpVhBbNR1PYCenya6zG+UsF8KZ/nQIS
oANRe6ryHlYbRg4y9EFbMsEZwQzRZ2To40dwikiO2jGSNPliRQHp3oxzlhqDb3+M
S2a0Kq3GFXDQXXgDvDocP/y2iAq+kw4V4refbX29xWTiBA1a/LogJvYf9MtL2PAb
N2NjKQknIU5xSzcPCpbimU02qLIn2Q/DPnAwI3VYrag8c3Ln9kr3zEBZLq8dmrE=
=78J/
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
