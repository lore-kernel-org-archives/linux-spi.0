From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
Date: Wed, 29 Jul 2015 18:16:13 +0100
Message-ID: <20150729171613.GI11162@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0CMEPKoZzmdAWWDb"
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Padmavathi Venna <padma.kvr@gmail.com>,
	Boris BREZILLON <boris.brezillon@free-electrons.com>,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	MTD Maling List <linux-mtd@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0CMEPKoZzmdAWWDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 06:19:24PM +0200, Michal Suchanek wrote:
> On 29 July 2015 at 16:00, Mark Brown <broonie@kernel.org> wrote:

> > I can't tell from this commit message what the issue you're trying to
> > fix is, sorry.  Nodes without compatible strings are entirely normal and
> > don't need compatible strings.  It sounds like a bug in whatever other
> > driver is becoming confused.

> The driver that gets confused is ofpart.

> The two-line patch to allow it to just ignore controller-data has been
> rejected on the basis that s3c64xx should use a compatible string
> because ofpart monopolizes all nodes without compatible which are
> children of a mtd device. Devicetrees containing such nodes that are
> not partitions are presumably invalid and should be rejected when
> ofpart is compiled into the kernel.

That seems like an extremely limited binding, the normal thing here
would be to create a specifically named node to contain the collection
of subnodes like many PMICs do for their regulators.  As a fix I'd
suggest just silently ignoring nodes it can't understand, or printing a
warning if that's a serious issue.

> >> +     if (!of_get_property(data_np, "compatible", NULL) ||
> >> +         strcmp(of_get_property(data_np, "compatible", NULL),
> >> +                "samsung,s3c-controller-data"))
> >> +             dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");

> > This will break all existing users which is not acceptable for
> > mainline, we need to preserve compatibility with existing device trees.

> It will not break anything. It will just spam dmesg.

I'm confused - if all this change does is to spam dmesg then what's the
point?

--0CMEPKoZzmdAWWDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVuQpZAAoJECTWi3JdVIfQ68kH/jsyNe1U8G5G/KoBfbkvD+oC
EEFlCmhxLQbMefRVdRLta7rZYvV72X7YMld3h3ppCQQ62f6Gf3ejCPDaEXYJZbr7
U91T+wyx5pLviUP+D3HVFYdG9RgRogs8LPgwQsHc2yPpO99vzglduW1/lT4btyPK
QMeIyZcq+T3f/vIgXCGGrE7l+2vVnGPiyLLXq4AcCA6zEPYupZYNWuIMj4JylUB2
ZbDnAIjYwX4kSYF9y27jN0ihMsHqPd7mxRhiaGb+Rg7Ow6riSH7Xhz0d/kNAVQmc
3cUr/P/N4cNsx9K5Qp8/4t+eQYru/OMra1r/t40BXkWQKYilZ6svTkskbGIYLw4=
=IPtn
-----END PGP SIGNATURE-----

--0CMEPKoZzmdAWWDb--
