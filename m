From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/18] spi/xilinx: Speed-up
Date: Tue, 27 Jan 2015 11:59:53 +0000
Message-ID: <20150127115953.GQ21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <20150127001419.GO21293@sirena.org.uk>
 <CAPybu_1==6gvwbWQWxSj_C3siGFTjvqNh1=Xj6jvu_xQFOA-Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gmAlUWRVDrnirEWv"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPybu_1==6gvwbWQWxSj_C3siGFTjvqNh1=Xj6jvu_xQFOA-Kw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gmAlUWRVDrnirEWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2015 at 11:17:42AM +0100, Ricardo Ribalda Delgado wrote:
> On Tue, Jan 27, 2015 at 1:14 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >>   spi/xilinx: Support for spi mode LOOP
> >>   spi/xilinx: Simplify data read from the Rx FIFO
> >>   spi-xilinx: Simplify spi_fill_tx_fifo

> > spi-xilinx?

> Thanks! Fixed on the next version.

> BTW what is preferred spi/xilinx: or spi: xilinx: ?I have seen both naming.

Traditionally SPI always used spi/xilinx but that's too far out from the
normal kernel standards so it's hard to get people to follow it at all
so I don't worry about that specific bit too much.

--gmAlUWRVDrnirEWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx324AAoJECTWi3JdVIfQhK8H/0ZXDUtTT+oo6vY86o4oGdYr
v5xw6IQAoXKBJeOoGxlZCcphe5f4ljPVorRhhGN687coWlUspsKnnwEbxaIkaZRU
ey5WwYXoIKV/uIAbHEhF6W/F5cURs8tPYIfZfAVGbqXKa3ONAmlXf2ZpPoaLJGbf
fYVsgOgsY7cx8ewVYBdB2F15ZNuNDoGGvNMYGaDO5TAmoj5e//K+T25HOSMgPJaY
MV+Ptn9womu9QEIwbIaFoZZMFDUT+l/NRK9qpSNOZOH6GwDQNDgy5s533qfRY3gO
wUDL76bShR8hSG8zRvgEi8za5MMcbzpbYW/7R16jw0shvf2fCLdEPmnGazOE+wU=
=v4Yv
-----END PGP SIGNATURE-----

--gmAlUWRVDrnirEWv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
