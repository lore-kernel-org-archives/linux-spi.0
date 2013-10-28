From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] i2c: Use stable dev_name for ACPI enumerated I2C slaves
Date: Mon, 28 Oct 2013 09:10:01 -0700
Message-ID: <20131028161001.GB13643@sirena.org.uk>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
 <98785510.yWYAtabkbj@vostro.rjw.lan>
 <526A726F.1030407@linux.intel.com>
 <2889412.bEKBLJtgSW@vostro.rjw.lan>
 <526E636D.3070005@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <526E636D.3070005@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 03:15:25PM +0200, Jarkko Nikula wrote:

> One possible thing to do is to let structure definitions to be
> available for non-ACPI builds. Then compiler won't fail on structure
> access which will be anyway optimized away by later compiler stages.

You could also have inline accessor functions which can be stubbed out
when not needed.

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSboxWAAoJELSic+t+oim9pXUQAI5P5ya2dgyxtn0txqAnDsQb
CkW5YVgj59iCWUseYSgZsceO+EpJGuVmNLc+aL1ksCghMMjiOljLmkRzVdFw9Aya
JZw3H3i4irieReNUr00rWfLBIoz8MawzBFmAhwY1ukGqWwvMhO1naIgGgCoTmHGC
QVHkEJblnjtmD2T480pAkEZSY17t9n0ZuVOIOaXYCcu7AXfET8NNDtL8NVY/ovJj
fbw8eIVr/u1dBqzk8vEEC05Wwi3L27c6ss2qjoFyQeJB5s4tBh7BIJsC5oYJ3KWr
YYwAf4Sqcbz08z/ryUfOZNwIGSiO4kT1ipx6+2tigclDgvDDAnp9jpEYoPYfyQt1
Zhuu2am6oo3DJQ/qt4ZjLCkbEbBPbImT74h8cAybZs+z4kUyfKTekvAp4ok8QWjv
SkM2XUHF5C1fJPY/SqEcQrl6FybbRsV+8hNmfogeC7Y5KP8Ah+u5J/DzEUYy+gjP
uO2pHhgPY0g/rcKoxyEfO6uxvWZBmpYPVtk3IBLESa9jz6W0uQjnOhJPZeCxCuoK
ddZoZFP3s2Ld9BV7hLJue47BAIm5dyBfI7w5DR8ED9AhcUhpjz/wa63v82ayb6p3
Y30ad5FZaE5ZyvMmXDy+kdIbA7aDDFpqxe170bnjx7SdU+48nN++LwxM/c6iCMy+
FJFP82sE3Bwxk9QD3Cwr
=H4BM
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
