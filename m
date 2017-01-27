From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
Date: Fri, 27 Jan 2017 13:36:21 +0000
Message-ID: <20170127133621.bifp64y2cdljld65@sirena.org.uk>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
 <0548db75-042b-4bef-02db-767ea9ccd7e4@arm.com>
 <CAGS+omDexcrnWL6v4bAQ3K2QSHKcwCs-WRCC+BUbGbXgVYbK9w@mail.gmail.com>
 <CAE_wzQ8ChZtLait3WWin1nyRY5CQCzs8VHTeAcP8y2DqSGmb7Q@mail.gmail.com>
 <CAGS+omC-LnTx9Qt4Cv+7u-Oh=4syZy_mA-FqF8bUzN0DQmgAig@mail.gmail.com>
 <20170126170747.r6gegu3buqeedp54@sirena.org.uk>
 <CAE_wzQ-an3v_32E+JFzTQMKXf=J6BVGf56QZKL+YCV=mZk6-LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xpnaonzme5pcj7bd"
Cc: Daniel Kurtz <djkurtz@chromium.org>,
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
To: Dmitry Torokhov <dtor@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAE_wzQ-an3v_32E+JFzTQMKXf=J6BVGf56QZKL+YCV=mZk6-LA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xpnaonzme5pcj7bd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2017 at 09:26:13AM -0800, Dmitry Torokhov wrote:

> OTOH the full buffer used by cros ec *is* DMA-safe (allocated with
> kmalloc), it is that cors ec uses it at offset while transferring data
> piece by piece. Do we want to support this?

I'm not sure the complexity is worth it as a general feature, I worry
about the cost of worrying about cutting the transaction up to include a
PIO portion.  That said that's just a gut feeling, if there were a
sufficiently simple/nice implementation it'd definitely avoid bugs.

To me part of DMA safety is the alignment restrictions.

--xpnaonzme5pcj7bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliLTNQACgkQJNaLcl1U
h9Dr3Qf/VVrvMPsVYCD1XkQSruZBR0RrSl+0En4QGNHcUcx6wJB/z+5Gc6uui06k
h9ByYlkXgkgECxT31BNphLJQ39ElrFgd5Cmxncx0uOIEZ+nwqmK3ai3xMde8sqwq
fbb+bMyXWPQAlCKpnuB6B5cHHtcXcL1GJFDhxCDzhZMOrNpsO4irMrdb+bjEun1l
Kzjmnmpe7zXpt7ZWdKLhLkAevrIjAkUZHQLwFY23VMEO6KANuzQilAHJmeGBF6mm
0oU3gaGCIIds26oCkO4IKxLurVTIZ1bu1E1DEXl0DoYZUx/1N4HkLWZ+vPCNtZ3D
bQ6K/wZWe4U183GQByLlZF5tp2zNSA==
=JNGo
-----END PGP SIGNATURE-----

--xpnaonzme5pcj7bd--
