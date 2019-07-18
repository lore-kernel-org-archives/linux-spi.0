From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4][V2] drivers: spi: core: Add optional delay between
 cs_change transfers
Date: Thu, 18 Jul 2019 13:50:08 +0100
Message-ID: <20190718125008.GD5761@sirena.org.uk>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
 <20190717115109.15168-2-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Cc: linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Michael Hennerich <michael.hennerich@analog.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190717115109.15168-2-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2019 at 02:51:06PM +0300, Alexandru Ardelean wrote:
> Some devices like the ADIS16460 IMU require a stall period between
> transfers, i.e. between when the CS is de-asserted and re-asserted. The
> default value of 10us is not enough. This change makes the delay
> configurable for when the next CS change goes active.

To repeat my previous feedback:

| This looks like cs_change_delay.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0wav8ACgkQJNaLcl1U
h9APhQf/QOouOeq0OOWIhFy4+/g0D4HdPXY0lzPOPRqIa3No7BWtewQIntQ7uARy
/6nZrCA4lT9IuLtQY9TtxBtY3GyY1hLyWXnibxUsD0vZqS7cBjvVdYYv9/FTdDEK
VquUng/K54Vp6Ku0GCfh9EXhEs05w/L4B1cWa1r7FD6gbF5llweQ6A/JP68B2Jzl
mAj3fEjb7brceyU08UiJsfDCIehvVc3vpu5wCyFFj0FzGhJ+IfJdAmFn7C6EmotF
CM8deV1NaeQB0iUkCSVgTj+pBG4UZ0hj0CGju8xXxE6/f/+1BgBp6EpNZj1Tptzg
XIBZ7Xf1k9oTXGZ+05q/wXtv2P9N+w==
=liAJ
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
