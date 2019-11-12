From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Tue, 12 Nov 2019 19:15:47 +0000
Message-ID: <20191112191547.GK5195@sirena.co.uk>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com>
 <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191112190328.GA199853@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 11:03:28AM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 12, 2019 at 12:03:07PM +0000, Mark Brown wrote:
> > On Mon, Nov 11, 2019 at 09:54:10PM -0800, Dmitry Torokhov wrote:

> > > +      interrupts:
> > > +        items:
> > > +          - description: main interrupt (attention) line.
> > > +          - description: dedicated wakeup interrupt.
> > > +        minItems: 1 # The wakeup interrupt is optional.

> > > +      interrupt-names:
> > > +        items:
> > > +          - const: irq
> > > +          - const: wakeup
> > > +        minItems: 1

> > How will this interact with a SPI device that defines interrupts at the
> > device level, possibly more than one of them?  Especially if the device
> > has its own idea what the interrupts should be called.

> My understanding that individual drivers should be able to override
> whatever the default behavior core has configured, and the device can
> establish their own mapping. We have this in I2C and I believe this
> works well.

> Is the concern about the device tree scheme or SPI core handling?

Both really.

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3LBOMACgkQJNaLcl1U
h9CnHwf9Htk5j6XICHic0T7w226CHXw6GyCY2GGe/lT9tLxvwZ3EzGstAu+8+G48
OG6Pn1Q23bQOevOGt8/oQ+f00yv+RXIipY4bgKIByUBUYSgP5ZWN7VzRVoa/ve4B
HoDoae5kWda/AEC5TRzKadcKcXbO3X/pM+QijqtzDOWLRavWvJ77pjPPZy+4Rzfq
Cii5vzHLiI9Xtn1COJfBPQPZHAPgwy13gN68XkQKt81F6NcuDI/i6ZbdvwWIOqPu
d2AW56WXVQ6o7aPCOP0yWqjILrGXVaJkwB5aM1Br4ukvKJQPiR4JxP4bPETrV4Aj
sBDrQVqj+Kx7vGo2uXDA6cVVy9ELXA==
=pW4A
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
