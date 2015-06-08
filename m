From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Mon, 8 Jun 2015 18:59:27 +0100
Message-ID: <20150608175927.GO14071@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431675522.2128.13.camel@mhfsdcap03>
 <20150515092543.GY2761@sirena.org.uk>
 <1433758546.19786.16.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRcNICV7MHA2HUNl"
Cc: Leilk Liu =?utf-8?B?KOWImOejiik=?= <Leilk.Liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	HongZhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433758546.19786.16.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--QRcNICV7MHA2HUNl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 08, 2015 at 06:15:46PM +0800, Eddie Huang wrote:
> On Fri, 2015-05-15 at 17:25 +0800, Mark Brown wrote:

> > That's how a very large proportion of devices that work with DMA are
> > done - why would this be complicated?  All can_dma() does is report if
> > DMA is possible.

> In include/linux/spi/spi.h, it describes if can_dma() exists and returns
> true, dma_tx and dma_rx must be set.But Medaitek SPI controller has its
> own dma hardware, which means this dma resides in the same base address
> range with SPI controller, and only used by SPI, so we don't implement
> generic DMA driver, such that can't provide dma channel and assign to
> dmx_tx, dmx_rx parameter. We think it's strange to implement generic dma
> driver for dma that only used by specific hardware.Can we just provide
> can_dma() function and return false ? But I think it's a little odd that
> there actually has dma. So can we just skip can_dma() function let it be
> NULL ?

If it's simply the unavailbility of a struct dma_chan we must be able to
get a better solution than just open coding all the DMA mapping and
unmapping in the driver.  The only thing we actually use the channel for
is to get the device we need to use to do the mapping and unmapping,
either we need a way for devices to provide their own channels easily or
a way for SPI drivers to specify a device here instead of a channel.
The latter seems easier if a bit clunky (with having to work with both).

--QRcNICV7MHA2HUNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddf+AAoJECTWi3JdVIfQAZIH/0sUOQ+RBf1d0D9B6b2gBA6F
iDrVFDptnTYNw0zBXXO7nI2POB3QaoPGIADgh/7XznJX8pwiC0t8yeN44mu+RXmw
bxoJXfya+qHl1DEIQNSf7bd1LJawQNwaJ7Oj//x3dp5X71fQyexpZogpe/wu4TfL
rnlPKNRQLprlEBBScR3qUmhdrB1dJKXgvqKeNRpwOUUjmxXqFYZ0ssSu7fvi+HYN
EJXO/zi/IBMSDAvz4FWipI261xAJINHFdxTn9qtZfDyBLeJzREvTi3x5JYeQNcZz
QA6OZMHW5fPJI8gHZi4M6fpMtRiuIu+qeVNkIwevC0+t/+sjIURRC3f91TK5e/Q=
=sEvi
-----END PGP SIGNATURE-----

--QRcNICV7MHA2HUNl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
