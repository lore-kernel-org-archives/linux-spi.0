From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] devicetree: Add devicetree bindings documentation
 for Cadence SPI
Date: Thu, 3 Apr 2014 22:34:46 +0100
Message-ID: <20140403213446.GB14763@sirena.org.uk>
References: <1396523431-14519-1-git-send-email-harinik@xilinx.com>
 <1396523431-14519-2-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+5G7L20VUoXZHCOn"
Cc: grant.likely@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
To: Harini Katakam <harinik@xilinx.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396523431-14519-2-git-send-email-harinik@xilinx.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+5G7L20VUoXZHCOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 03, 2014 at 04:40:31PM +0530, Harini Katakam wrote:

> +Optional properties:
> +- num-cs		: Number of chip selects used.

How does this translate to the hardware?

> +		num-cs = /bits/ 16 <4>;

What's going on with the /bits/ - is this something that's required for
the property?

--+5G7L20VUoXZHCOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPdPzAAoJELSic+t+oim9KnYP/Rzk/u+pigxRjG58cnSR48vx
/2n6KSV0gtpWFHbxc1h2nkqVq20IkiR1TFWInBWBMkpaP8LFul946CxW5mrBwT8u
XyxS5PQnbhuG5gpctoKb5k1HSdRttPf1IjQI0jaONrXgXR5HurIjAuFaHP7nlpAi
DWgAL3ockmK5eJ+MkuQHCV+cBQFIJM9jDu6GsXm4zn8uzu7Hw4avN7aNMu6c7X4O
aYaVmO1Aco2KA9P1Mj0Mbeoynx5/fP8ld/PICnKBxeqW8FKs3KLnOfkq4MJOcQU6
81iaGlgJ0bC7CGCBrJsC86X3AwxC3le65b1XqM1OB1tpBvxd09VW3Hx1yyX54ldI
WQSdcD1R6Shk9/hoKO4oPBFxyP67WyPmfrZn6LaI1AalGu0+UL4FZvoHRSlzra4/
NseS5mB/0I0jv7lCAcjK7MT/E3NpQAhqADOOsYqrkhr5kVV4z270bYWOS34vtSHf
MJTvG/+Zj/6ldYhmZ+rvVZrKCktoKTRoOwi26bBA6WfW3sTvSJ9cKScLap2l/fwa
ITAtG1OtbObqUITgxmpT2gbIfTj3/9fpXjgtzECgjQLv2nj7EfcSvh5hnogAlk3x
xwGEnBbPK29bQhWzC21okRxStAWnZ3s1K1inqB3o11w83DJkV4dwQFvV6NHsyHJ6
WrGH9NvSkAZ9X1tVv6GL
=/mqC
-----END PGP SIGNATURE-----

--+5G7L20VUoXZHCOn--
