From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Date: Fri, 12 Oct 2018 19:00:02 +0200
Message-ID: <20181012170002.GJ2340@sirena.org.uk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-2-lkundrak@v3.sk>
 <20181011142719.GE25351@sirena.org.uk>
 <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6iqOn7HZPWKXx18"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8cafa3f97fbe2a01ccf968b39469751b449e324b.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--d6iqOn7HZPWKXx18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 11, 2018 at 07:59:15PM +0200, Lubomir Rintel wrote:
> On Thu, 2018-10-11 at 15:27 +0100, Mark Brown wrote:

> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.

> Thanks for the response.

> I'm a little confused here. Why I chose this subject line is because I
> did this:

>   git log --no-merges Documentation/devicetree/bindings/

Try Documentation/devicetree/bindings/spi instead :)

> to figure out what's the typical subject for the DT binding changes.

> I also believed that's the right way to get Rob Herring's and Mark
> Rutland's attention. Do the device tree binding documentation typically

There *is* some debate for the DT bindings unfortunately.

> go in with the associated drivers, or via their tree ("OPEN FIRMWARE
> AND FLATTENED DEVICE TREE BINDINGS" in MAINTIANERS)?

They usually go in with the drivers.  This one isn't so bad since it
does mention SPI, it's a worse problem when that's not present at all.

--d6iqOn7HZPWKXx18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvA0wgACgkQJNaLcl1U
h9C+/wf/SHmOue+GuQ4l/70jaDVkiGXd2VViu1AvPbMXSLSjt+FF+6Tuag1eyP2v
4RcuNedih8M3DD3vSEtJPT9vUj5H8pvxuBM1aZno+axfPv1dXDnPAck8+pJ7PfrF
jtnnZVxBcSIC/QX1DrmkMzvP+T38bQ2hA4wMSVOkH6t+/PkoS3hDUBp+CbqNRMPA
OOliuTtDUaPJt1QombMTDjAe9o+Tf93YE1QxaXBOy1Wj+m/MERloSws19bxDt+22
hDQxEQq0xgpNY+GN45hlkMvTlgKmPelc7gvLyGeMOtYbw33NgVD7G3aOT5NM3gH9
bxf76NSvtFG/O864dHnvw4mKxq+vjA==
=O9td
-----END PGP SIGNATURE-----

--d6iqOn7HZPWKXx18--
