From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/4] spi: dw-mmio: allow multiple instances
Date: Thu, 23 Jan 2014 19:50:55 +0000
Message-ID: <20140123195055.GK11727@sirena.org.uk>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <74a507ce4370729cbc31c7e8d182821287ffcca1.1390481413.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74a507ce4370729cbc31c7e8d182821287ffcca1.1390481413.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2014 at 03:05:56PM +0200, Baruch Siach wrote:
> Use the platform_device id to uniquely identify each SPI master instance.

This is OK but it'll be annoying if anything is using it for a stable
dev_name() since it'll probably renumber.  Not sure there's much we can
do without platform data though.

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4XKcAAoJELSic+t+oim90GgP/2NA4TeEOw1MTgeg7tIBlTQ/
KQTFsfjEZwyXtMcPc8xnqh1y2vccxX+DzMQTA8H/JKekmCCTy6sfIvmRtGDcB+uM
LKM6SrAyAVfxO66cgoPNteDLzAMNroJCgz3Hik9GpT0BYB1dk6CE7evoj0z2lvh/
A5ENcrJQy70LXpDjxxl8SM8TOlN0ninUu851nyeeQGVJt0Sec9TnfuXmM87D82l/
41r8DsjvcKfXhn3WU1rdoKAA6oTtH6zBDjByRtCchAAJlg1qSvC5LWE+EmmeQqjj
of9Qh6vAa2jTejd2l35c1tMKsZQ9HBWqW8FZ3BsGZZPm3z1WF8TIGzzVkMyP1IEh
mo7gFWifHTGWYnGbi8kqoB2Qppfha/vn1fyHqqaLDK/9e5lBvq8LXsBwLIHkSz7h
vOGo5dSTBO9Z7LY4c9e+w1yCPSxGee7xHD4+e6gA4oBMqTX4Kub7sPUmDikJ1UM3
4bwScpKUvuBI+vKTNz4dG3mgN/+VJJ6YJ+QviKC+vfbNyr2DF1Zl682IJVcOsMgd
STatFN/lpG174eL/jxtBJDYPCLlXMvBf7CyJNb2RuiItrXuHal49G08jtyEeU2OH
1SnNzkfQTyUlLIxrF6EULKtJhuDMm3Nt9bmeZefwsmhr7pEC3NrTUTdQqPj3CD0K
SnrUaiptevQA86L83VNl
=HRIq
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
