From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
Date: Thu, 4 Sep 2014 20:19:54 +0100
Message-ID: <20140904191954.GO29327@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4aWqK7AGBdpHaKKF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648468-5436-3-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4aWqK7AGBdpHaKKF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:01:02PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> move spi controller's gpio request work out from probe() to spi device
> register stage, so after spi device register spi controller can deactive
> device's gpio chipselect. old code can't do it because gpio request has
> not be done until device register is finised in spi_bitbang_start.
> and add cleanup function to free CS gpio.

I'm not quite sure I understand the rationale here - as far as I can
tell this is making the GPIO request happen later not earlier so it's
not clear to me what the problem this is fixing in the existing code.
If the goal is to move the request around in the probe function why not
just move the existing code earlier in probe()?

This also won't interact well with deferred probe, though a better
solution here would be some kind of deferred device registration and
typically the link ordering will mean it won't be an issue when
everything is built in.

--4aWqK7AGBdpHaKKF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCLtXAAoJELSic+t+oim9pbgP/0kb57+s8wUW5S+q6syqkU/C
HabGSkT5JfO50An89yeInQtBMUBXfWL1F5HiP7WgFvTvxLRIh7aOFBVt4YWhdmyy
98qh3CqqlvCpzq/0xhceCMDLBfE1dxDGEeOwTGwYGTN9fIzWn45VapO0CJsTPGY9
eA+jolJlVuUWk5ip48JiSSfa2ib0jdcvWHZV4vTOI167qDYK0w2WglMHnijbKR1X
PZHyfij/c4u+XTb92utFzZRx8wYw9Bg4LTjyJipmAmkm4Dx0MHBo8T2nS7fHR8Ck
vDC+/zfzTUDtiN5uF1zPrnmS5gQe6dDYAv4Y2a227vcbyrMkS9/ZCsYHluNYQ8fy
gqRNnGnsNc+piZpZy1uEv6fgqn+gEBmqb6S94Pzo3iWknKBpyIlTecxS4rfnPDY9
U/XPrg6Tna+LrKUFtJBbwFn0lkGLdv3Sa3nll9ZvejSxrxy1WPmUPf2yjpLXporG
CMn+hiL6FDMzzXUt4sG5qFf5v52CAXtwLp2BHqbY+C84QgMMqHgFCDNHQJ896wLa
EwDjtcRAmJCC6pebEOIur4FXyoMtOuqZjTZ4vv3aKkbFy7JuLaxlj8FcGeMDkKAp
C2Lb1/KHPndOfomqPWliZdQw1hLmNa7liVEhdYKhlahI8w8AxKhaYpXt+RDbL5MA
/JskN7F1PkYGUglt1Vnt
=5FYG
-----END PGP SIGNATURE-----

--4aWqK7AGBdpHaKKF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
