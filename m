From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon, 4 May 2015 18:29:57 +0100
Message-ID: <20150504172957.GU22845@sirena.org.uk>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
 <1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
 <20150504134226.GY15510@sirena.org.uk>
 <9A0ADDBC-5D5A-428F-B434-9CCB97505DCB@martin.sperl.org>
 <20150504143030.GE15510@sirena.org.uk>
 <812CF966-8B7D-4019-810D-BF2B17D86A67@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pjxWZcyw0FkHgndX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <812CF966-8B7D-4019-810D-BF2B17D86A67-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pjxWZcyw0FkHgndX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 05:50:11PM +0200, Martin Sperl wrote:
> > On 04.05.2015, at 16:30, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'm not saying don't lock, I'm asking if adding this spinlock is the
> > best way of doing this.  We already lock the master most of the time,
> > can we not continue using the same lock?

> Tell me the lock to use and I am happy to handle it.
> but a quick look shows that transfer_one_message is running without
> a lock held=E2=80=A6

I didn't say don't take a lock, I said don't make a new lock. =20

> But for that to work we will need to allocate spi_master_class
> (among other things) dynamically - Let us see how that works.

I'm not following this at all, sorry.

--pjxWZcyw0FkHgndX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR6yUAAoJECTWi3JdVIfQlc8H/AwaKRafLDeHmD4zi+WW3Bkh
gf6+2z+WldpcT3hguQAzAEC+KecZQPkTB6ELJWWRjXtFdZr1z16aW5Xa7EvQ7iwn
uq2aG027qRfb8n0COWZOGBISvKLchJayUFHD/nY7k4ImJCHzbak2nIDCqqTZG4DD
fXbga0ELtwK5YGHSK/KMLDBUm3iDrA+f64MMfjrrSwn4Qq2hmIzrdBPxs5x8CT2/
lC+Hc1YRZB7MdxV8GC9ciFq4ob+vdgcioep3BTV5nxGRCnr9ngamuS6KvaFYGUzU
yfB0FEcsuqcwAa+y7nQhGCu1aYFjBmcdRTveNVTdT3tsoD5LiZjxi7XdrEdekOE=
=oMOQ
-----END PGP SIGNATURE-----

--pjxWZcyw0FkHgndX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
