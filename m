From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 10/20] Documentation: devicetree: spi: add
 spi-lsbyte-first propery
Date: Mon, 8 Apr 2019 13:27:12 +0700
Message-ID: <20190408062712.GI2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:09PM -0700, Sowjanya Komatineni wrote:
> spi-lsbyte-first optional property allows SPI slaves to choose byte
> order of little endian for transfers.

Why make this a DT property - surely it's either a fixed property of the
relevant devices if they are LSB first (in which case we should know we
can use it from the device) or it's something that the driver for the
device can just vary at runtime?

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6b8ACgkQJNaLcl1U
h9CIKggAg+pGXgMOqakZ8c/g8PSsF9z9x/vbR2jo4tv/AmNxenu+gDCF78d4wBgB
a/2l8JORQi+knOxzUq0O7HhN8sR+lz7W45qVrc5jNLSAFPVRPSaBu9o3jxkHh5Sd
WlI4mX7d18KbnoGgJlXSU7j2FXmVrYQQgco6u259vht9zFqQCxLqUd8Gv2RwzLFL
3fiUpsU3BBp7EOE3YlMijX6Jqw76cpwmhmQP9joGwGnsUZexvBTkPen8+GSHqEtK
jBHKF0PSCcHGyvdVGJsd5g92ga3oIPrs0DaW4z/+yXTRKNkkZJTz9rX4rkHnU5ku
UmftTb8lLZibuRH4x8YdJsgLx5KvqA==
=Wt2d
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
