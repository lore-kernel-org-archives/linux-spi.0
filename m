From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Tue, 31 Mar 2015 13:24:28 +0100
Message-ID: <20150331122428.GM2869@sirena.org.uk>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <20150308190012.GV28806@sirena.org.uk>
 <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
 <20150327175318.GG1743@sirena.org.uk>
 <1bd88fda-314c-496a-ba8b-e9292f9c411b@BY2FFO11FD023.protection.gbl>
 <20150331054714.GA2869@sirena.org.uk>
 <74214fc9-e5e4-42db-bd85-51ed02975388@BN1AFFO11FD026.protection.gbl>
 <20150331111651.GL2869@sirena.org.uk>
 <98b110d7-f875-4bd5-98de-47641ac2134c@BN1AFFO11FD026.protection.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XUw4UNa+KU4wN46K"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <98b110d7-f875-4bd5-98de-47641ac2134c-reflc3kr++MPoeFrVf1fn+hlVc3/7hDbVaz/vdPVXQ4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XUw4UNa+KU4wN46K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2015 at 01:25:07PM +0200, Michal Simek wrote:
> On 03/31/2015 01:16 PM, Mark Brown wrote:

> > Well, there's a lot of existing users to check and clean up some of
> > which currently rely on it which will take time to deal with.  Removing
> > it while some drivers rely on using it isn't ideal.

> We have spi-cadence driver in the kernel which uses num-cs and also
> is-decoded-cs and we can change it but the question still remains how
> to do it better.

Like I say just don't use num-cs, use a property which describes the
hardware.

--XUw4UNa+KU4wN46K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGpH7AAoJECTWi3JdVIfQYkMH/iE6jT+ZbTTN4/yL9gC0uByx
RqyjpKTck64ZSVttUnkAooHTP240H22hdT8dOpozAttnOwi3FXCsxttSsyYr0FBX
o+ckXjm/FhS8q87YeT4RqiR2uYnhSmESHgnS1fUwkTCjVIqx+EMwZEQEAjTN5UNG
W6giQroTkyjXKmmnv1N3TXrxsSNXwFtvKODVSQvcVkebVtcTQw2IQ27ZYZNEzzyh
mVq7rUKChzSH4Wpv1ABnRdCmdl3MzmnYXC0pov0J9e1jvkzkNVG30HdhjGUFfOv3
B41vXOs1f/JYEQlfub5Ty+EpfyK3idYrdpppR5qjykgMnX7LAgB4k4VxXuVGnlk=
=pSmE
-----END PGP SIGNATURE-----

--XUw4UNa+KU4wN46K--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
