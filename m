From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-imx: use correct enumeration type
Date: Tue, 3 Mar 2015 09:58:42 +0000
Message-ID: <20150303095842.GJ21293@sirena.org.uk>
References: <1425338911-11407-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p5Tgzh5FmVyYTm9d"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	llvmlinux-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425338911-11407-1-git-send-email-stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--p5Tgzh5FmVyYTm9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 12:28:31AM +0100, Stefan Agner wrote:
> The fourth argument of dmaengine_prep_slave_sg needs to be of the
> enumeration type dma_transfer_direction instead of dma_data_direction.
> Since the used enumeration values actually stay the same, this is not
> an actual issue at runtime.

Applied, thanks.

--p5Tgzh5FmVyYTm9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9YXSAAoJECTWi3JdVIfQUYwH/3d/gwE7TjySUt3V6ediYSh5
iqz7tHWZW/xWcIE4HA3cWmpS2IdhiobImVPtWbR34JXSv+4sejSwjUhPOMdYLut/
NUQ7Y+WrHTAXbMoRtKIAwTTLLBULYrIVbzMAzApPXwVC5eSIGTxI7DlNucNXaQqA
wCr/l+gFMA1zky1gWw4uKlg3hxZ55kgem199ir3s0fiZnxdNGk+62YdF9/RE3h3B
tuTRbsWJXB3Nso87uf6LzxMp3BDh3X0pRBYrMoNgM5kGQUih+b/nJMGkgGFzzDUP
tt/HM6Hsd8/UkAJ9u+0eA5OkS7JVqNhxLfXuZDOBD5YGbx9Yri5R8Nsdxxot6cU=
=mr9w
-----END PGP SIGNATURE-----

--p5Tgzh5FmVyYTm9d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
