From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] arm: dts: socfpga: Add SPI nodes & update copyright.
Date: Wed, 8 Oct 2014 00:12:00 +0100
Message-ID: <20141007231200.GR4609@sirena.org.uk>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>
 <1412711297-31857-3-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kPepdeVVZyud5ZkI"
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412711297-31857-3-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kPepdeVVZyud5ZkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 02:48:17PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> Add 2 SPI nodes to SOCFPGA device tree. Update copyright.
> Update spi-dw.txt with bus-num as an optional property.

Again, this is just randomly mixing multiple changes.  Also why are we
adding a bus-num property - bus numbers are an implementation detail of
Linux and I can't see any reason to put them in the device tree.  If
there were one the binding would need to explain what they were.

--kPepdeVVZyud5ZkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNHNAAAoJECTWi3JdVIfQLMQH/17DH64GaK/WL3gS//He087f
9bzMa7NZ4go/wIuwoFHKFGCg1VSjTYAUig/TU+hxJOEUKMZkQLLBGHjXF9snQ1iF
bZ7iBNXMR2wNR/ShN/IafpdcFjPjAq4RUyQqGg0MgFc3jMDc71i3VxbJ1SnlijD7
JMPzcJdz50KlbyaH8lm/x07xINKZjNzjLRJ3Y8jFnYHHVfKHN12nZJE459d8EoDZ
bg+6ju7KQpwta19GPyNtsk3KS5e/IQ0kgQ9p0hySt3bHCpIUuFwXviI1cz+dR/Ug
r5YMs9fSH8swW8NErRsjN/AG+b287L/Jtp4Ie4abH/gp3rLU71aTwJR5rdLOuuo=
=vvxe
-----END PGP SIGNATURE-----

--kPepdeVVZyud5ZkI--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
