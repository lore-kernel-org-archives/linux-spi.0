From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: Setup the master controller driver before
 setting the chipselect
Date: Wed, 28 Oct 2015 09:33:23 +0900
Message-ID: <20151028003323.GV28319@sirena.org.uk>
References: <1445009343-28307-1-git-send-email-fcooper@ti.com>
 <CAHp75VdexZWSEEM8xjYEx9WU4dbrNrXeczvBpyKcRKn-qMN=-g@mail.gmail.com>
 <56211C0F.4090102@ti.com>
 <CAHp75VchYayRsvsjPoM9YphcjMajfvYuDrLcLrTiADVn8LU=8A@mail.gmail.com>
 <562F6C9B.6010607@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H5pgEA8DvTwLpheO"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	m-karicheri2-l0cyMroinI0@public.gmane.org, "Ivan T. Ivanov" <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <562F6C9B.6010607-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H5pgEA8DvTwLpheO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2015 at 07:22:51AM -0500, Franklin S Cooper Jr. wrote:

> I don't see that you pulled this patch into your topic/core branch just yet. Would you prefer
> for me to shoot a v3 with Andy's tested by or will you just add it when your ready to
> pull it in?

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

Please don't send content free pings.  If your patch has been lost then
you will need to resend it, if your patch is waiting to be handled then
at best your message is likely to be threaded in with the original
thread and therefore not seen.  Either way a content free ping just adds
to mail volume rather than helping.

--H5pgEA8DvTwLpheO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMBfTAAoJECTWi3JdVIfQiq0H/A6ppeziyMPclCrW+8x0pQ4d
Rt1YbqJ/faPfhZxGJzNp00ta614MASzIROQl4XAo0bjfCs+NskJeDLlC8RWVZ6bL
dUmCL6UD7ThH6FTZlbgXIaRgMkYTiasHXDnDDn47mlma792CN26TrLX6APs261jc
AxMghl/enfWSzjk2hzoSpyvf8r6gnd4PAdK2y/yvxsNx3djAUHPAV9lqi9bxRtUQ
7FQkokj4xxxKM2mYDC9DwkGQWeOo9E8qYntTcKxKIl/vxbS3IYCIHS1wm3xesyzJ
QQ3880HMAdTp53c9gSRyheL6CDUVJ4G5h8WDuTZ9zaBMtzEgQiePUfk62T3nMxA=
=Vk3Q
-----END PGP SIGNATURE-----

--H5pgEA8DvTwLpheO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
