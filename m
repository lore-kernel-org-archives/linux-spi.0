From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Tue, 10 Mar 2015 11:06:38 +0000
Message-ID: <20150310110638.GD28806@sirena.org.uk>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
 <20150307105948.GD28806@sirena.org.uk>
 <1425889415.2440.10.camel@mm-sol.com>
 <20150309182841.GW28806@sirena.org.uk>
 <1425975056.2440.24.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jm4NjHtWXfjOIegD"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425975056.2440.24.camel-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Jm4NjHtWXfjOIegD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 10:10:56AM +0200, Ivan T. Ivanov wrote:
> On Mon, 2015-03-09 at 18:28 +0000, Mark Brown wrote:

> > > About the API usage, point taken. GPIO requesting part is more import=
ant
> > > in this case. pinctrl core did not request pins and wrong DT configur=
ation
> > > could lead to surprises without any warnings or errors.

> > That doesn't answer my concern at all.

> I am not sure that I am following you.=20

> I can not use spi_master::cs_gpios, which is populated by=20
> of_spi_register_master(), because spi_register_master()=20
> populate SPI devices and they could issue setup method.

I'm sorry but I can't parse the above.  What does "they could issue
setup method" mean and why is it a problem?

> Requesting GPIO's in core framework is also not a easy
> option because of arguments here[1].

We should really fix that though.

--Jm4NjHtWXfjOIegD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/tA9AAoJECTWi3JdVIfQY+0H/1Q2KzHpIrD75lH/krD1TF2i
cvzpY3BlNSFDsI8hX7cPEG1UxxfzUfpPElH/KQ2pJNEITuXX9AFwPnmxmDRbe8zc
7UESjKKZjdEzRxp+NmB57U8FyGF9wrSaiY62lRRWoSjWXA6tE+QeaKIKE8KLwoIg
U9vyPTHzqcLaL4yrs1nlLnc67kaUOV4i/DagzdVZ60EHv59Mg4nIp+BTUBjnPkjC
Fje2o/R7DjTfaWEE8uIrlYFS8NN/dUGfYZ+IPadvV5ex0sUWInge5fyvdnCiBk1h
oa8LHqm+wmjJjnqBJldj6joHjqqdLur/RenlffdOHGvs1aMvemhJWLiWHwBYUh0=
=Cb0p
-----END PGP SIGNATURE-----

--Jm4NjHtWXfjOIegD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
