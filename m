From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
Date: Thu, 30 Jul 2015 11:52:33 +0100
Message-ID: <20150730105233.GO11162@sirena.org.uk>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
 <20150729140046.GB11082@sirena.org.uk>
 <CAOMqctTZVET=U=2o65HpWSm4W660XZtYYbBND2k4u9CnfjfMhQ@mail.gmail.com>
 <20150729171613.GI11162@sirena.org.uk>
 <CAOMqctQzh69RCQu8pK1EuuYkrZsh6mg34+YWJFzSvimcK3B0rA@mail.gmail.com>
 <20150729184043.GL11162@sirena.org.uk>
 <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9VrpJA1Ggqg13J4y"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Padmavathi Venna <padma.kvr-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQTc-8_rU6URCPHXno-OqH6wf_rHY4mW+Sf-epNhCwhFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--9VrpJA1Ggqg13J4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2015 at 10:24:37AM +0200, Michal Suchanek wrote:

> So my suggestion is to

> 1) search of ofpart subnode in mtd node. If present read address and
> reg from it and search partitions as subnodes of the ofpart node. In
> this case unknown nodes can cause error.

> 2) failing that issue a warning and try to parse ofpart partitions
> from the mtd node itself. In this case unknown nodes cannot cause
> error for compatibility with other drivers including the already
> exisitn s3c64xx controller-data node.

> The parser code can be the same for both cases and only operate on
> different node with a flag to reject unknown subnodes or not.

That seems reasonable to me.

--9VrpJA1Ggqg13J4y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVugHxAAoJECTWi3JdVIfQdZwIAIVmxlDqQRuMpGGZjMcMZoD6
2BQ+6Sj04M6QWBFYkqvm3Dp6xMHJ9r0nre0HSmUcztLmYPtsnv+scgPOiO523am8
mv5BJcmVGejsSbwYEf1rxHM2bGeD9MUmmfr9BrQsr19RmaO6K3G9lSKa8znCfRsx
FiKKMWdpl97JVdAvES0KC4rbpnGUpUtNNLeuzI1+17l8bzcv0NmwuG/wf2zfLjku
q9FF2UNSExyz/7uQezKiwG9HlmPQkE7wxVUNleYQM1VWwsBgtjgTU5ncj5lZ6RY0
zML7Y/sWu93tWX5cBAV5cB49sxzE7erz0e2pV330cHSnPIda/eHyoZ8b7c9iQFw=
=/zjp
-----END PGP SIGNATURE-----

--9VrpJA1Ggqg13J4y--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
