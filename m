From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Date: Thu, 27 Feb 2020 16:44:25 +0000
Message-ID: <20200227164425.GF4062@sirena.org.uk>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
 <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Cc: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > It's what we do for other properties, and if this is anything like the
> > other things adding extra wiring you can't assume that the ability to
> > use the feature for TX implies RX.

> Double Transfer Rate uses the same wire.

But is it still on either the TX or RX signals?

> But as you sample at both the rising and the falling edges of the clock, this
> makes the cpha setting meaningless for such transfers, I think ;-)

Might affect what the first bit is possibly?

> However, as the future may bring us QDR, perhaps this should not be a
> boolean flag, but an integer value?
> Cfr. spi-tx-bus-width vs. the original spi-tx-dual/spi-tx-quad proposal.

> What would be a good name (as we only need one)? spi-data-phases?

Sounds reasonable, apart from the increasingly vague connection with
something that's recognizably SPI :P

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X8egACgkQJNaLcl1U
h9BzNQf+NjXmaGigWO8AYKixlBbcKDms48SbjmC3B/TKWN72uzEK1Ir+m0zbDH/k
3rRhBD0UEIitRKr7B3yHGk5dJY0A3yZuSqsmXm6EW05qo65DwU2595xG4Q7lAk35
enegdQQEG9axlL02UaRgms5zlb7znVK/DqAqzjLB6NUv4AjBs8OJVK2RCLwXhvx3
c1W2kmWHZ5i9EXY21cCmQytqMlkJnOnHfYLoafYvVeqLFS1ddty4GNFsXdY+F14Z
EpXoakYtdKqZyX5SFRw6ymAZUU/O6qPiyv6ipnpOfu/pFazvJ+NByzx8FDy6bUEt
uOZ2YaN/cmD3HqhSb6dp4iTXWLLzzQ==
=jCkC
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
