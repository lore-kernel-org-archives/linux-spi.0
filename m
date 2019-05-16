From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: spi: Add YAML schemas for the
 generic SPI options
Date: Thu, 16 May 2019 10:27:22 +0200
Message-ID: <20190516082722.wcv2kmg4b5lqhszi@flea>
References: <1acc9ff7f59064b74cc319b7812479bcd842a897.1557386749.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqLRWSWk7cV=pYi1fbYsLJFUxE1fMo6Bm2FC99oPtS-88w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2519322183430374619=="
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-spi <linux-spi@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqLRWSWk7cV=pYi1fbYsLJFUxE1fMo6Bm2FC99oPtS-88w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============2519322183430374619==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l2jinyemzygueieg"
Content-Disposition: inline


--l2jinyemzygueieg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 10, 2019 at 11:05:48AM -0500, Rob Herring wrote:
> > +description: |
> > +  SPI busses can be described with a node for the SPI controller device
> > +  and a set of child nodes for each SPI slave on the bus. The system SPI
> > +  controller may be described for use in SPI master mode or in SPI slave mode,
> > +  but not for both at the same time.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^spi(@.*)$"
>
> Doing some testing with spi-gpio schema I'm writing, this needs to be
> "^spi(@.*)*$" so that just 'spi' is allowed.

I guess "^spi(@.*)+$" would be enough then?

> However, that's not enough for handling multiple instances of
> spi-gpio. So maybe we need "^spi(@.*|-[0-9a-f])*$" to allow spi-1,
> spi-2, etc. Really, we need to decide the larger issue of how we
> handle multiple instances when there's no address space.

That works for me, I'll change it.

> Also, this schema will be applied to any matching node name as it is
> used for automatic selection if compatible schema is not present. If
> we want to prevent that and only apply it when explicitly included,
> then we need to add a 'select: false'. Without it, we get more
> coverage, but it could slow things down and we'll get double printing
> of errors.

I guess we can change that later if it becomes too slow and / or
confusing?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--l2jinyemzygueieg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0e6gAKCRDj7w1vZxhR
xZD0AQDElc8nw58kmcEtzisrHDw0kwYpGMDedspqGUAaatx23gEA+etEsJlvv+2n
byABh15Bk0eVWPg8bNsQLSXD9sx2FQ4=
=Xl7S
-----END PGP SIGNATURE-----

--l2jinyemzygueieg--


--===============2519322183430374619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2519322183430374619==--
