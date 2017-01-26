From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
Date: Thu, 26 Jan 2017 17:07:47 +0000
Message-ID: <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
 <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
 <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aev5t2xdz35fhdu2"
Cc: Dmitry Torokhov <dtor@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel@lists.infradead.org>
To: Daniel Kurtz <djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--aev5t2xdz35fhdu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 12:52:15AM +0800, Daniel Kurtz wrote:
> On Fri, Jan 27, 2017 at 12:35 AM, Dmitry Torokhov <dtor@chromium.org> wrote:

> > Nobody doing DMA likes unaligned buffers. In fact, memory used for DMA
> > must be cacheline aligned, or you going to have trouble. What
> > component supplies unaligned buffers to SPI core for transfers?

> cros-ec-spi

That needs fixing then - I keep thinking we should add a warning to the
core for this, especially now we do DMA mapping in the core.

--aev5t2xdz35fhdu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliKLOIACgkQJNaLcl1U
h9Ck5gf+LlXdyi6HmCQ2tog1zmOgEzLfK55ZrJpuzkaPwxziBVwkB5UxnFmNhvEH
fboWmTFrpP2WFckSc8y5CjRRjle+UBZNBNv/i226kaln05E/7dHqFhg7P7GlCvIq
Kxi9IZ1j5QUsL0hIU9Vh5Phf5lHETFCfZjZuBNnJ4EHNtBS+PBD2wPsYv8tP1toB
61WNJ6a1l7FGi0P26KCAoUc03RYpAMX/NPqvOO82v7ToAb5YC8jlVGRSv6Vr1ivd
Kfr5t4uF9LKzauofyNQaXO8BDxYkwEK0zmNdHg8npG+CvDvvp+U8SQ+h/lv32vMC
6pYu0+2TDn1JlsbCotv3LNpZTI4jdA==
=MQdZ
-----END PGP SIGNATURE-----

--aev5t2xdz35fhdu2--
