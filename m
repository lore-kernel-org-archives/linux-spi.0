From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Thu, 26 Feb 2009 11:38:44 +0100
Message-ID: <20090226103844.GB3058@pengutronix.de>
References: <20090220144126.GA9203@pengutronix.de>
	<200902201641.21168.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1338644525649928030=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200902201641.21168.hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============1338644525649928030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2009 at 04:41:21PM +0100, Holger Schurig wrote:

> > +	int (*exit)(struct platform_device *pdev);
>=20
> void (*exit)(struct platform_device *pdev);

Fixed (Hmm, quite some more candidates for this one in mach/)

> > +struct spi_core_version {
> > +	u32 rxdata;
> > +	u32 txdata;
> > +	u32 ctrl;
> > +	u32 int_en;
> > +	u32 status;
> > +	u32 test;
> > +	u32 period;
> > +	u32 dma;
> > +	u32 reset;
> > +
> > +	u32 int_te;
> > +	u32 int_th;
> > +	u32 int_ro;
> > +	u32 int_te_en;
> > +	u32 int_th_en;
> > +	u32 int_ro_en;
> > +	u32 xch;
> > +
> > +	u8 bitcount_shift;
> > +	u8 sspol_shift;
> > +	u8 ssctl_shift;
> > +	u8 pha_shift;
> > +	u8 pol_shift;
> > +	u8 datarate_shift;
> > +	u8 reset_val;
> > +
> > +	u32 max_divider;
> > +	u32 max_bitcount;
> > +	u32 default_ctrl;
> > +	u32 (*calc_datarate)(struct driver_data *drv_data, u32
> >           speed_hz, u32 *val);=20
> > +};=20
>=20
> A number of u8's in the middle of a structure where later
> 32 bit long entries are comming?
>=20
> Move that to the end or change it to 32 (I yet have to verify if
> the compiler creates stupid or good code when accessing u8 out of
> a struct, but I assume that on ARM the code is more-or-less stupid).

Well, could be that I thought too much about size vs. performance issues
here. My idea was to put the variables needed in hot-paths to the front
of the struct.
All variables starting from the u8-block are just used in initialization
routines and so I tended to size-optimize here as we need at least six
of such structs.
I'm open for suggestions, though.

> > +	/* Setup any GPIO active */
> > +	if (platform_info->init)
> > +		platform_info->init(pdev);
>=20
> This function can fail, so you need to handle the error case.

Fixed.

Thanks for your comments.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmmcTQACgkQD27XaX1/VRsI5wCfYhjcWVimAZoKqx09kKsBr5LC
8VwAnjqRjLilkeGHLh+SzRJMZMZDRT9E
=GK5x
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--


--===============1338644525649928030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
--===============1338644525649928030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1338644525649928030==--
