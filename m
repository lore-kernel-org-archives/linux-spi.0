From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Thu, 16 Jan 2014 19:46:51 +0000
Message-ID: <20140116194651.GO17314@sirena.org.uk>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
 <20140116122704.GD2617@katana>
 <1389877509.3010.15.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5PFZVUeDPxlnBcQp"
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org, gregkh@linuxfoundation.org,
	rafael.j.wysocki@intel.com, grant.likely@linaro.org,
	jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com,
	grant.likely@secretlab.ca
To: Zhang Rui <rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389877509.3010.15.camel@rzhang1-mobl4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--5PFZVUeDPxlnBcQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 09:05:09PM +0800, Zhang Rui wrote:
> On Thu, 2014-01-16 at 13:27 +0100, Wolfram Sang wrote:

> > I wonder why we don't have/need that with CONFIG_OF? Because probably
> > nobody is using modules with i2c devices there?

> This seems a gap to me but I'm not 100% sure.
> I saw Grant Likely introduced the OF style MODALIAS to platform bus, and
> OF style registration/binding to i2c bus, maybe he has an answer for
> this.

This is needed for ACPI because we rewrite the device names to give us
stable names.  With OF for I2C and SPI nothing bus specific is done that=20
affects this stuff so the default behaviour works.

--5PFZVUeDPxlnBcQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2DcoAAoJELSic+t+oim9a7MQAIfTIeEbTBAP+JAbDykZ/5Nq
r6m4YR+9uoNfiHUXoFHhA+dUH0VGQVERrgsHdIJGX0l4QJSRA3900enuXYsh9aFh
TFPXZiI7UjxvRQ0EQbJX3et9ZqcDAU64ND5uq6N1H8XqhNSFAyt4k04sLB58/RrR
1b8aKsxX4yP1bY8/BiErC5Tv7g8oiTS/i50NZvIwvbs6uKV7RbHv3RAxSELyW5XF
ue6RJtGSyLm2iGv8GAMRwsgoqjrvhRELlwIaBPb+UfF30OKizNSFV/OmqTfez3D7
fgUrysxi/gChplEzr5WtVCvdpSkEvTAJ5ybSSapZgKQYNJErhuCZrKk3o8k+/n46
WefsH6jsUl3LtgTRzE/0DWUVSz8InJm8dn/o2+XJOD3yx0bBhbf/Q8NcqmVJGh9Q
iznQfEHqIuGVzyCg88P2mSPEebyKmcB6uV5qYV1/zPEYl90a/f9f08mtsDztKHqh
/ehutIRIqimWevZCtGHecEx0U76PV5tFo0ffeSO72pe86EkZzJoRfu3P01cZjkLn
At0tq6jCsLNOAnHnTouHKwjDt03+EfSU2re5/pOpaJDmLTukumLZVPc6T7J0zGVx
L1j/t6hZgFY8YcDRQfVH4t/zqmzsfBMTFZoQcv1qGLG4+27I8Az6he81S9PbQy/k
8DmX47Q+eSQA7b+LflGe
=BRrz
-----END PGP SIGNATURE-----

--5PFZVUeDPxlnBcQp--
