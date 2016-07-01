From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 11:36:13 +0200
Message-ID: <20160701093613.GF6247@sirena.org.uk>
References: <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk>
 <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk>
 <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk>
 <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk>
 <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <5774E07D.1060706@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XSfi1pJWPNAvuBPy"
Cc: Michal Suchanek <hramrach@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Dan O'Donovan <dan@emutex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5774E07D.1060706@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--XSfi1pJWPNAvuBPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2016 at 10:03:57AM +0100, Dan O'Donovan wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> In case its relevant, I'd like add to this point by emphasising that
> there is an increasing number of "maker" boards available, such as UP,

We know.

> which expose an open SPI bus interface on a pin header with the
> intention that a primary use of that SPI interface is decided at
> application level.  'spidev' is the adopted method for making that SPI
> interface accessible to those applications, and those boards do
> typically ship with Linux kernel that either (i) use

It's not the case that these boards (even when used with flying wires)
universally want or use spidev, people will want to use existing drivers
for devices that have them, and equally there are a bunch of non-maker
applications for spidev.  It's not like there is a special kind of
silicon that only makers use here.

> Anyway, I would love to see a solution integrated for this, whatever
> the appropriate solution may be.

There's a bunch of work going on to make overlays easier to use with
connectors which will hopefully help a lot here.  The other big bit that
seems to be missing is automating the process of going from schematic
capture for the modules to DTs so that people can design something and
get the bits needed for the software as trivially as possible.

--XSfi1pJWPNAvuBPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdjmMAAoJECTWi3JdVIfQuLAIAICF/27slEepqCC/v/6IQSqQ
XUi32ETqsMwvawaDSen/WfroEtFHahPl+sz8c2onC7+MoZ4K/RbKW/+JuLqKeXp4
UaVVVK07D0NRwNkf+KkT1GJObTtdOkE0v8QyFA4GAg/KDMe15qBBJBtHZ76D9trr
WhiglUYuzTth77NTEF2lNs1chGy6ogCAQjuPXQeg5UIn0BDl9Y9dT1vsO9kEeoC2
z70jQFPhJ/0Jo+qtzGtAVWK7U9kYZo7XVI6Pry7e65bV9gfl2YErGb2UL70Erxxh
a7R29lC1AWyPIWFNHZkw/SfnDRP5FTRsTKqSSD+xgOdxXn9i31w99KGQfVRJ/W0=
=2JeA
-----END PGP SIGNATURE-----

--XSfi1pJWPNAvuBPy--
