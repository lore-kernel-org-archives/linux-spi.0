From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Convert to use master->max_speed_hz
Date: Thu, 27 Mar 2014 13:29:51 +0000
Message-ID: <20140327132951.GP30768@sirena.org.uk>
References: <1395848658.11134.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395848658.11134.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 11:44:18PM +0800, Axel Lin wrote:
> Set highest transfer speed to master->max_speed_hz and then we can remove
> hw->max_speed.

Applied, thanks.

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNCfMAAoJELSic+t+oim9AIoP/iuXjcTC+mE++sl6tmFhrnhX
Mjs+UkYmCx5p3kT/mOr37DCKW4b8D6jp2Xp9AFVxcFNSj7uSne03L6JNAm0ke+pX
eFXkVO2qmKHC8T8OiwKMl7LN9pdCIOLTdk4sxOzFp8/M2w5qVJAzuarTu6wa2Hao
49g5rJTuQdJ0OWsIrwYy572yapcTjAeWTnEJIJVpN2uffOiyKbZ8e6/PkVC6COth
CRNI24X5YsGrhYd4oLNskQD4bh/ymVTpcM3QP80uRzYOBe0RZlOkekLSVplBrI+Q
dND7fcbnFExHqxh/qtMCh6cRPMN+Z+GzIvfAMf7wymNnQZenjmI1TYTT4amJgIyI
jtbfw4hQ+fHYyIPVl2gBcOelORJgxtP4t5GhfMGfQHZd2rkQSbNxQq9ai+KYDQJZ
tfG3uzdYG9KVxx7cFUwsgRoH6rralwreD+s7iDXNC/exgBPJhiyMjJV8afR22Wjj
U5Fs4eWPdCihG/g5cJYHURvQ1iHv5eutEKaimHCmWdQDxEtxtCMnLL52qTByPWOH
aygcPLPXo0xzr2jK85Y+JFq08jLanqT1GTGscisdYYU8iwq0GU/h+IwmXnIeR68m
cf+j4X8k3FuUlkB1pQer9txCMDiU6T47Z6sN1tkincYB6FFYSX0AulHqGGd56a2t
ZUGBmy4pH557YH1igKNC
=fSfi
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
