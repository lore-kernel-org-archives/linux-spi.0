From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 2.6.31-rc1] eeprom/at25: bugfix	"not
	ready" timeout after write
Date: Sat, 18 Jul 2009 03:12:08 +0200
Message-ID: <20090718011208.GA21948@pengutronix.de>
References: <200907031836.28475.david-b@pacbell.net>
	<20090717173546.11f55599.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4439295409019927423=="
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090717173546.11f55599.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============4439295409019927423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2009 at 05:35:46PM -0700, Andrew Morton wrote:
> On Fri, 3 Jul 2009 18:36:27 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>=20
> > From: Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>
> >=20
> > Under certain circumstances msleep(1) within the loop, which waits
> > for the EEPROM to be finished, might take longer than the timeout.
> > On the next loop the status register might now return to be ready
> > and therefore the loop finishes. The following check now tests if
> > a timeout occurred and if so returns an error although the device
> > reported it was ready.
> >=20
> > This fix replaces testing the occurrence of the timeout by testing
> > the "not ready" bit in the status register.
> >=20
> > Signed-off-by: Sebastian Heutling <heutling-U9zb0o/1OQCELgA04lAiVw@public.gmane.org>=20
> > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> > ---
> >  drivers/misc/eeprom/at25.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > --- a/drivers/misc/eeprom/at25.c
> > +++ b/drivers/misc/eeprom/at25.c
> > @@ -173,6 +173,7 @@ at25_ee_write(struct at25_data *at25, co
> >  		unsigned	segment;
> >  		unsigned	offset =3D (unsigned) off;
> >  		u8		*cp =3D bounce + 1;
> > +		int		sr;
> > =20
> >  		*cp =3D AT25_WREN;
> >  		status =3D spi_write(at25->spi, cp, 1);
> > @@ -214,7 +215,6 @@ at25_ee_write(struct at25_data *at25, co
> >  		timeout =3D jiffies + msecs_to_jiffies(EE_TIMEOUT);
> >  		retries =3D 0;
> >  		do {
> > -			int	sr;
> > =20
> >  			sr =3D spi_w8r8(at25->spi, AT25_RDSR);
> >  			if (sr < 0 || (sr & AT25_SR_nRDY)) {
> > @@ -228,7 +228,7 @@ at25_ee_write(struct at25_data *at25, co
> >  				break;
> >  		} while (retries++ < 3 || time_before_eq(jiffies, timeout));
> > =20
> > -		if (time_after(jiffies, timeout)) {
> > +		if ((sr < 0) || (sr & AT25_SR_nRDY)) {
> >  			dev_err(&at25->spi->dev,
> >  				"write %d bytes offset %d, "
> >  				"timeout after %u msecs\n",
>=20
> Seems OK.
>=20
> The code's a bit nonsensical though:
>=20
> 		/* Wait for non-busy status */
> 		timeout =3D jiffies + msecs_to_jiffies(EE_TIMEOUT);
> 		retries =3D 0;
> 		do {
>=20
> 			sr =3D spi_w8r8(at25->spi, AT25_RDSR);
> 			if (sr < 0 || (sr & AT25_SR_nRDY)) {
> 				dev_dbg(&at25->spi->dev,
> 					"rdsr --> %d (%02x)\n", sr, sr);
> 				/* at HZ=3D100, this is sloooow */
> 				msleep(1);
> 				continue;
> 			}
> 			if (!(sr & AT25_SR_nRDY))
> 				break;
> 		} while (retries++ < 3 || time_before_eq(jiffies, timeout));
>=20
> EE_TIMEOUT is 25 msecs and `retries' is 3 msecs.  So the
> time_before_eq() will never trigger unless there's a tremendous amount
> of CPU load or something.  It seems a bit ripe for some rationalisation.

Not 100% sure if this is applicable here, but here is the thread, when we
discussed the write-routine for at24 (i2c).

http://lists.lm-sensors.org/pipermail/i2c/2008-April/003370.html

At least, this routine still uses retries, so the thread might be a bit use=
ful.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkphIWgACgkQD27XaX1/VRu0RQCgrya4afK/MzZJpBcslYyVZwVO
ktQAn183VXSFzL+ar0yuZbp6LSMFzH5k
=Q6pn
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


--===============4439295409019927423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============4439295409019927423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============4439295409019927423==--
