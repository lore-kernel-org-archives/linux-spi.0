From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] Revert "spi: davici - make davinci select edma"
Date: Thu, 9 Jan 2014 14:09:13 +0000
Message-ID: <20140109140913.GU31886@sirena.org.uk>
References: <1389261359-4446-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KmqOOynKnQuy3zXe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389261359-4446-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KmqOOynKnQuy3zXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 03:25:59PM +0530, Sekhar Nori wrote:
> There is no need to force selection of TI EDMA DMA engine
> driver when DaVinci SPI driver is selected. The driver
> builds just fine even with CONFIG_TI_EDMA disabled.

Applied, thanks.  Please use subject lines matching the subsystem -
doing a revert is just the same as any other commit.

--KmqOOynKnQuy3zXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzq2FAAoJELSic+t+oim9O9oP/RoRiE8vm5xmNS4un07TEcY7
rR4NSSc1qQmPhTK5ByML+PrFVa8CeGjOc8QXNFZ0RzdkQJ8Nt5Ldv0Qa5fMLN7a2
CsTqemuH0OoGBup5Fcs+Zv+xAI5H7XXkRnmxOIwGsUVwXe6icDOaZQojd++tiPZa
H9HAoKjjVIVpks+h4snwT6HpbCbX/yiFvcYRrRrNBpDOJDQzHgTcb9JUIqrAjxON
0WJq2d/x7lczvvQ/sOqtw+XvTBYwJf9GZq57nMSI9ByNCbXJPotCs+1s93CVWBi1
t//DTp9U4sHC5XATCGCc2mBlDPEyBoFN5fspNdZVBIAwtxtJDugVZpC5IpBp8SWg
BtJi/qyfJr38l4bTjq+l2YWKyOMICxwiPT+qXCchHrK9oxvCZRdvWmPBqcxt0yVu
89Z1vl5MF6TJzCrQRVkbdNp4sRksJgjkVMjfM0deiL1P8W6towgZfI2ImS9rDNwq
JXKuYC/VV5O55yDqGvgj+Tg3ucSDVRo8nDHTWvPAO6SVCCpYHJKrtm5HjYiO8tNF
SZGlbIOLifwioJ8UMWXVu3DAwJAB9hBcLvOAXRVcWqIx0uPAf7uEGYJwa5O3c7D5
EVV42cmLHACFxNCgjadlIyUtGrLLmDT0Pj5ipoZBxashFkawME8AmdxFe9bFrm5h
HUBgSxOW0/hWv7r3uQzR
=ScfH
-----END PGP SIGNATURE-----

--KmqOOynKnQuy3zXe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
