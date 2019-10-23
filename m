From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Date: Wed, 23 Oct 2019 16:11:21 +0100
Message-ID: <20191023151121.GC5723@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
To: Luhua Xu <luhua.xu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 08:38:42AM -0400, Luhua Xu wrote:
> From: "luhua.xu" <luhua.xu@mediatek.com>

> Use runtime PM to power spi when set_cs
> As set_cs may be called from interrupt context,
> set runtime PM IRQ safe for spi.

Why might we be trying to set the chip select state while the device is
runtime idle?  It seems like whatever is trying to set the chip select
should be dealing with this, not the chip select operation itself since
that's unlikely to be happening in isolation.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wbZgACgkQJNaLcl1U
h9ATSQf+OUsqd9lrmv01u0bHiJLMN7oKTLAH9rbukbP246Gj/NJZHv9XEa4/EIG+
PrOIpiUSATTLRjt0aOjWURk0NVAazV0jwYPnXYRkH/kfMQB9Ix7DL9N3fL8munYX
zQm8Ec+DPhLw9B+g+lqoJe22GgsC+68vBXMTUNrFSvOT+yiuuI3452HBWEhGugX/
BGZm/N7Vw25js2S62hMg0PTy0GRbjjdX1GNBhofOefbVBuFcZsVbcfkKNNDFgxUs
Ye6/kVYIiHbQWTjsuiVGhshWe7AM3/MpzohQBr+csZUSxJjEI+TLAYzBMVjE4tc/
tVV/VzlC14zM1pODYKEoGhOsluhPJQ==
=eE5N
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
