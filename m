From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Fri, 7 Feb 2014 17:52:34 +0000
Message-ID: <20140207175234.GJ1757@sirena.org.uk>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
 <1391766753.27491.60.camel@iivanov-dev>
 <20140207173207.GA19974@qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
	Gilad Avidov <gavidov@codeaurora.org>,
	Kiran Gunda <kgunda@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>
To: Andy Gross <agross@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140207173207.GA19974@qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 11:32:07AM -0600, Andy Gross wrote:
> On Fri, Feb 07, 2014 at 11:52:33AM +0200, Ivan T. Ivanov wrote:

To repeat what I said in my earlier e-mail please delete irrelevant
context from your mails so any new content you are including is
discoverable.

> > Did you see any particular issue with the implementation=20
> > or this is just because this platform didn't have support=20
> > for power management? =20

> The platform doesn't have support for PM right now.  So it's probably bet=
ter to
> remove all this and revisit later when it is in place.

No, runtime PM does not require any platform support at all and is good
practice - look at what the driver is doing with it, it's useful as-is.

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9R1fAAoJELSic+t+oim9OmUP/iHNbNDHKHr6AV3Pv+4I4l+e
MM8ISSMCTNSU6FLtema15sFFco2ECZSDwB6zuirSA91/gUu/GrOsaKrQbsx8ejLI
gJUadbM06VqrqP0Tu0dBLkth/pD0qP9a5+nxI2dDnU1MiaIOL3WLhReHX4kyYStG
7NZeLSSxwwtA78Y3jvotoLutkzy9FHgNAypEK5Muf9QKd+Wbxeo1uys7Ic8l49em
Tyyyk+yJHhr20UqXUHaSSZxlxWJCYErlKOI42Xy0ZmZd1cGKUiNC1OOViOwJ7K8U
DmhFbN5+jrrkCqjtXfTi2cshMsGqZ4XqMvfipsHMTBGRLrRuTo4iEKmcITpU7hIr
LMQSjmOlC62fi+SE8DfjKF/istWFVFaVXMa63BzmNl9nQIdkQFHpxeWx+Cy5xiT8
xfOPDArdcxy10M6FpUt8VrwO1EebR9FhY2Y8gG1nJQYOx1Wf19ivkM2WchJXZhym
NVX6A9lR104lEiShxkZxz8aLVzc6Cf+j+kUQRFwWnLM8j74f3w4mbRsuNhL8Uq6X
7lq/qs7hy4LUL/H8S9/5ywA+8JY1eYCEPDbrtCg++TCHkf/9ntWLIlrs0grfWNHf
VrS0Q98ypFegOhoKgi0Wa2tHJxBxJYERQ0+KJuE3SNse7yg+4I6CWL/z1QIw7V+0
8WH2WpLnCYr4R9v33bui
=pgCV
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
