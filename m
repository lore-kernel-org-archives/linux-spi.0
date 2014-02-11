From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: Convert to let spi core validate
 xfer->bits_per_word
Date: Tue, 11 Feb 2014 17:08:18 +0000
Message-ID: <20140211170818.GU13533@sirena.org.uk>
References: <1392123096.1351.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoibaoN3dya3u5fy"
Cc: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392123096.1351.6.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FoibaoN3dya3u5fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2014 at 08:51:36PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--FoibaoN3dya3u5fy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJS+lj/AAoJELSic+t+oim90iIP+K60qQf3W7ReeOd1YYTcwpjA
asra6cdsSYuOzaN0vj6UepZATZfskzHJkhoET1Ejy+3D8GKJVHmTuIrlp41v+Hba
FUA+nOhdDxHcqAZPPQD1PoZRRwvRbMMpYXKTXavipdDaWO/lMyXBnxTlo6f+xwjd
WSB2yPEYJdC4a2bXORF7D8f4Uxo5gor6xLog7XvQvgurpXIVljjYdInlLgG1Agg6
yY3OtmtJaEg+iCwi6PePRgn0DiE/fAVAH8WhR/vc83SbmQ3d9/ndbHz9iRGX8r/X
Or9NJBhrmjod9b13TFoqUhgWqdyc9MP3xLoccPr9bSp8o44wiVyqT1v4a/1zGLnF
KPyoh8Md8Q8pB8Uuqg1oiGBQ8A8sivQISRN+RAzNWP4HaEad/EqAa2UGVIoq9Z1I
nHBwD2g+SgBr5zo9aIUTAsoTDTXqC12NitFIo7PuQqZg1zcZOY1IrefsNRupi+iB
ixrCZCfE1jSm/ukGm3Q3ykA9mI3TptnYUHQ7czhbXq1O/MPjelDcWRatfCxpGg6n
Us4OD2yHU/ZnIoCgl4KMhbQilBYO8o8J1OmemfG373Wg+SUkrtbrq4lJd70Xz7gk
NXRpOgbbro2yKJVBINpFeiWgQyvjwxEVidTM92Sbzvuzv3y5EfnLWUdlml4L2tbi
azJhXivRtkxfCVyHXCM=
=U7Rn
-----END PGP SIGNATURE-----

--FoibaoN3dya3u5fy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
