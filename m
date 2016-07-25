From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Mon, 25 Jul 2016 17:20:01 +0100
Message-ID: <20160725162001.GE11806@sirena.org.uk>
References: <cover.1469174814.git.jglauber@cavium.com>
 <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
 <20160724210452.GB6345@sirena.org.uk>
 <20160725155122.GA2710@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160725155122.GA2710@hardcore>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 25, 2016 at 05:51:22PM +0200, Jan Glauber wrote:
> On Sun, Jul 24, 2016 at 10:04:52PM +0100, Mark Brown wrote:
> > On Sat, Jul 23, 2016 at 12:42:55PM +0200, Jan Glauber wrote:

> > > +#define PCI_DEVICE_ID_THUNDERX_SPI      0xa00b

> > > +static const struct pci_device_id thunderx_spi_pci_id_table[] = {
> > > +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDERX_SPI) },
> > > +	{ 0, }
> > > +};

> > The define for the device ID doesn't seem to be adding much here.

> I find it more readable instead of PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa00b),
> or did I miss your point?

No, that's my point - I find myself wondering why there's a define half
way down the file and what else is looking at the define other than the
location a few lines below.

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXljwwAAoJECTWi3JdVIfQ71sH/0MFxLdDOXfeZ8xc94sQlP9y
VBIW6LaouRhbxv+MruqikFNRj1FeNXK4Qv7ZH7hFQseJrC+WDEnVueWRe+EOmprf
4X/nF/UXhKZ6SWVHln31ZpyGPi9msPJYBsYa9JHtl16v/hXuvFygWTmGu6qs7RFg
SX5Wlpb+genqBacPrmaA/5BdapKT/CKvjyYO89o8hBEVJ58aD4vR/bNkHAcaOmwU
d50rvC4HRYM8+6JxQH7uf4H5dI6kybzK+TMOXis76xg+tofkjTiYDDBpGNtzD1UD
tVwJbAZCY/QK0Y230/ZUWUh1EFYu+5l0/vOC25VooP+A9+ClhyhhFa67U+OvSrw=
=9Gaw
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
