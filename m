From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC] generic iMX-spi driver
Date: Fri, 27 Feb 2009 11:38:40 +0100
Message-ID: <20090227103840.GC3481@pengutronix.de>
References: <20090220144126.GA9203@pengutronix.de>
	<200902201641.21168.hs4233@mail.mn-solutions.de>
	<20090226103844.GB3058@pengutronix.de>
	<20090226232639.GF5811@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5953578275295218153=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Holger Schurig <hs4233-x6+DxXLjN1AJvtFkdXX2Hg4jNU5vUVPG@public.gmane.org>,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090226232639.GF5811-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============5953578275295218153==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> What it does do though is want to naturally align structure members, so
> it's a good idea to group u8's together up to the next members natural
> boundary.  So:

All the hot-path variables are u32 as I don't want to do shifting there.
The u8-members are all cold-path, so I can use them as shift counters.
They happen to be 8 in V2, so that seems to fit, too (for now that is).
I know about aligning and will keep an eye on this.

One more thing I had in mind: As every access to a register now looks
like

 'regs + drv_data->version->$some_offset'

I also wondered if it would pay off to add the register base to the
offset already in the probe routine, so we then can reduce the access to
simply

'drv_data->version->$some_reg'

But this is for later, after the driver is stable, I think.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmnwrAACgkQD27XaX1/VRtJZgCghnulCB1WR/c4KMMrN3eQxPq0
R0kAnR4Y59ihllGugMXyCxP/urfzPbmQ
=82dj
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--


--===============5953578275295218153==
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
--===============5953578275295218153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============5953578275295218153==--
