From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Sun, 26 Apr 2015 17:47:28 +0200
Message-ID: <20150426154728.GK5627@lukather>
References: <20150426103257.GJ22845@sirena.org.uk>
 <CAOMqctR235uF+7kNGsLEGfrrAOQAYmw0pWgk6t8fZHNT7XsRuw@mail.gmail.com>
 <20150426110144.GK22845@sirena.org.uk>
 <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <CAOMqctRbYoNG2c-5atBP3QvMKbEhOrAgxzK1QskA5k2TgHraFQ@mail.gmail.com>
 <20150426143359.GI5627@lukather>
 <553CF8F2.6070204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVcIhgQsEzAXu06J"
Cc: Michal Suchanek <hramrach@gmail.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	Mark Brown <broonie@kernel.org>,
	linux-sunxi <linux-sunxi@googlegroups.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi <linux-spi@vger.kernel.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <553CF8F2.6070204@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EVcIhgQsEzAXu06J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2015 at 04:40:50PM +0200, Hans de Goede wrote:
> Hi,
>=20
> I've a feeling everyone in this thread is ignoring the
> raspberry pi use-case. Where the board is specifically
> designed for educational purposes and used with lots of
> peripherals which are usually programmed from userspace
> using e.g. python bindings for i2c-dev or spidev, for
> such a setup we really want spidev to be loaded on the
> spibus by default and we really do not have a proper
> compatible for a child device.

I'm not sure we're ignoring it, it just is the exact same use case
than the whole spidev use case: people want to write SPI userspace
drivers, the rpi really is not special here, except maybe for its user
space code base, but it really boils down to the same issue.

> And no having to use per device devicetree overlays
> for this is not the answer, this needs to be really
> really easy. With pre device-tree kernels this just
> works, we should be able to match that ease of use
> with devicetree.

We do agree on that. We repeatedly told that the DT was not a good
solution, overlays or not, and this is exactly one of the reasons.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--EVcIhgQsEzAXu06J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVPQiQAAoJEBx+YmzsjxAgEocP/1sLuA6qbpc5AkcmuUtLt+dn
d9+DoP8cGTuePIWqQ75UAew+11uZ0g6VioANlxfRmUTXQO5xFgHqCIJDenhgnde4
PCAq0UlgD1QqSCB7U/NR6Lcaa26twDahHhciow4OOerQKR7P8S8vGfXwDeMypenm
LKPh+iafnjvLgZOe/B44abv2KbGFIqtb/KgtsUkuYlYlFxSEOoHWLoFwadf/FKmb
W6xzRtjGGfjiLSn2feQWhuyb5zMN9bE2qdSGDVJexT03agA1kQrO8hHq08+6fN8c
+CIjzl/dKh9Rbvk8mX5qcyuDKw41HewEzhQ8D3/+zx18qgIwhGyefgDla6SwHJce
bMH6VXp36MQvIgRSIy+ze7qhxfjVh1DETmZYEd0BPPyTkgSeYIB/aqiUJFk0WLht
IjeoDqwwI1ZZemq0d6/jI+Y0gzIBOzEAjH/0szSvZKg947JRyBdmVebjGFCk7bu8
r7YbVEAjtN2B9AzPyQnZU82tY1SN5gEbmwbSHuFV7lNIoYfgc+9MWAbUaHbom4B3
7U2nlziQ6gDoHmkj5qTYVY36nY0QUKvS/O3wYuj3l0wabIz/4levKVV6M3jv46Tn
GEIuuEV9mdxuvAu3xwcPPEonUzex58qBpqcdj45erxR7warqilItpwHiAlQmg4kA
CMYaTI71wzrHBZ8OKc3P
=Jlfm
-----END PGP SIGNATURE-----

--EVcIhgQsEzAXu06J--
