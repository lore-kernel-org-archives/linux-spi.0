From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
Date: Tue, 24 Jan 2017 15:48:10 +0000
Message-ID: <20170124154810.ikbxaptvtg5wamzj@sirena.org.uk>
References: <20170124132519.13271-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mcsshc5kysm7bzpr"
Cc: Leilk Liu <leilk.liu@mediatek.com>, dtor@chromium.org,
        groeck@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>
To: Daniel Kurtz <djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124132519.13271-1-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--mcsshc5kysm7bzpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 09:25:19PM +0800, Daniel Kurtz wrote:

> The master_spi device is not a platform, rather it is created
> in spi_alloc_device(), and its dma_ops are never set.

Which is good because it's not a physical device and doesn't do DMA.

> Alternatively, perhaps we should be using master->dev.parent to dma map bufs
> in the "no dma channel case".

Yes, exactly.

--mcsshc5kysm7bzpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliHdzkACgkQJNaLcl1U
h9DYFgf/RAP7LNat/ZiStAf6zAsauNnrsFdxwXxpji/rbrLtVViNwU+KkaS9Mwsd
7gZzX8aY8aQXLvd7R2AucRgwXck+s7AnHB6s5o+ZP2Enxk7s1KxyjxV3f1O5dQBq
FP74m+3QwtavhxSt7+9K6DytbnCOLRV4+w1KX3NEKvwyqZMIujhFpZor2oX/yhwU
n1BsXSVrVpIdpBDhq0s/sWBx3YPuE+ukOKQLQmp8A61rW73lloVMpD9ePh5MrhFk
biBI1ca1YGZMcaESZFsfywNLo9NxiFpeXQ10nrP6aqnHWa/sO4SqoQDM9/f7k2b1
xDGgo5WvKyVmeHLTbnCwGZ9X4sxBpQ==
=miIC
-----END PGP SIGNATURE-----

--mcsshc5kysm7bzpr--
