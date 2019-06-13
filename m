From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Date: Thu, 13 Jun 2019 20:14:35 +0100
Message-ID: <20190613191435.GY5316@sirena.org.uk>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
 <20190603110832.GA2781@lahna.fi.intel.com>
 <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4988661656290101599=="
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-spi@vger.kernel.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
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


--===============4988661656290101599==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g3IWFuR7/O9KKcN6"
Content-Disposition: inline


--g3IWFuR7/O9KKcN6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 05:56:00PM +0200, Ard Biesheuvel wrote:
> On Mon, 3 Jun 2019 at 13:08, Mika Westerberg
> > On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:

> > > -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

> > Would it be simpler to differentiate here between Apple and non-Apple
> > systems? Then we don't need all that special code and the above becomes:

> >         depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
> >         status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
> >         ..

> > Probably requires a comment explaining why we do it like that, though.

> Yes, but note that both the root and the depth are different in this case.

> I'll play around with this idea, to see if it simplifies things.

Given that this works and got some testing I've applied this now, if
there's a simplification it can always be done incrementally.

--g3IWFuR7/O9KKcN6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0CoJoACgkQJNaLcl1U
h9CsSgf/ct5qv0UqPxaWfJKOm8GT3NBa0M/seyJphcRzfO/WQrlDOz8HC4iGV6AE
v3NZWqcmzuQPtu477cXwOc5NqHqzUVHOOrWk+D7Pe5/urIS37xh8wSeY9mINlwim
YZzzpPQCXVEcO8GeijfooBSsSSpuuCq6EmOowOLuO58WlY1yx0h9BvgCwWWO0Dlx
B76uCITIixiZRoWME5PuucBDTMjFp7RrtCNvVt6xjBFHCrFEIC7UKCK931AbicTM
G2tXuMYjxteIWeZ4jYLDHGu/OFzQg7bTOcdQrhU8sybBsdek+FhBYdVTukS55Hxd
MMfuw861PELtqd3OW7oxpUQpQ/AcMg==
=Gd1/
-----END PGP SIGNATURE-----

--g3IWFuR7/O9KKcN6--


--===============4988661656290101599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4988661656290101599==--
