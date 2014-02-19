From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: Provide core support for full duplex devices
Date: Wed, 19 Feb 2014 23:13:10 +0900
Message-ID: <20140219141310.GB2669@sirena.org.uk>
References: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA@mail.gmail.com>
 <CAMuHMdWkPxp2U=Xz=wWu70RPxj+4GGCyifdPv=xL=47cz_upBw@mail.gmail.com>
 <20140219130407.GR2669@sirena.org.uk>
 <CAMuHMdWRd075tEDfvtWfkQ-7dECT0y14qxQpbyKMs5v3GDYRAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zmgb5/Qq281vq2QH"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWRd075tEDfvtWfkQ-7dECT0y14qxQpbyKMs5v3GDYRAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zmgb5/Qq281vq2QH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 02:32:28PM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 19, 2014 at 2:04 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > This is a particularly thoughtless hardware design it has to be said.

> Do you mean the fact that you need to transmit dummy data on this particular
> hardware, or that you need to know the direction for Dual/Quad transfers,
> and don't need dummy data for the latter?

The combination of the two, clearly the hardware can actually cope with
an empty transmit FIFO.

> > That's readily fixable for DMA capable drivers, we can just repeatedly
> > transfer the same page (or whatever).  PIO drivers have big problems

> So let's hope all DMA-capable hardware has scatter/gather support, or an
> IOMMU ;-)

You can emulate scatter/gather well enough for most SPI controllers
anyway.

--zmgb5/Qq281vq2QH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBLvyAAoJELSic+t+oim9cGQP/jz9L16P7jw9IbQrzfutJh2P
y55rMKn0sOl+qWg7Q02J1E4havaxOdEgQcfsLj1F5MWM+OfQ7ni2xJnq+fubW6/t
rwxfSjar55Pw00eRGO67nz+42wsE2/C5ZdtuZlH7t+jxOAYrr2MEGx2SqYclfKD/
HaNPuVcPYL3r/HdHZM/D3k2dqc/inIUwdDxkHYBfMkFTM2qHAbFRf4VyGiXbuyDw
bOk3M9PMetNIWOQRcgXmxYIt8ubqBCVnyvrTRH9ahvIjDkyZnpOYbHzYetBITAgS
/NdZfVF5F8jr5X4lk6PwZB2vmYJn1CBR+FmQlbaUsjZiscq1FDyqdUkKauWpVAXF
hFHNiXxvLaHJUy5TDOQfhI2gBvuc7nVu/msNUmBNfv/ES5jJS+8eOI2p44++s8yo
8RVmLzP6SrcgbmUgCJutNy55ORYq7woJ4+HqiHPdcZobJHW9NsVgYeShPZKm6oMS
HHoMRpUpf3V8Co6rHHrRD5wXwE2CXJwe90OZiM2q9umgqfHLn5ANk6BA8a0Wfl9J
ed2j+zrONUTsUTk5LEH4q85FXUQBUjkI/ZcrskDUP26CkZbVBaG+yGuyIELZyzYl
7OURBZoUfZsR2tNvCaTrlwD5y7yuTNS1D/n0a+0UMZQlcXPxpU4ZLIAW8Nf2u2Je
7GpqYYJyQW2zRQdkzSw3
=lL0Y
-----END PGP SIGNATURE-----

--zmgb5/Qq281vq2QH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
