From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 4 Aug 2015 16:00:22 +0100
Message-ID: <20150804150022.GN20873@sirena.org.uk>
References: <55C05E18.600@martin.sperl.org>
 <20150804095443.GH20873@sirena.org.uk>
 <55C08F70.5070303@martin.sperl.org>
 <20150804111528.GL20873@sirena.org.uk>
 <55C0A40C.5070806@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NNF9FXNTY80mBlY+"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C0A40C.5070806-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NNF9FXNTY80mBlY+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 01:37:48PM +0200, Martin Sperl wrote:
> On 04.08.2015 13:15, Mark Brown wrote:

> >I'm not finding that patch particularly enlightening here, sorry...  can
> >you be more explicit please?

> Well, while trying to figure the issue out we tried to disable or tune
> different parameters to see where the issue really came from.

> At that time we had to recompile the kernel several times, which is a much
> longer turn-arround than tuning parameters on the fly.

Right, and runtime tuning is much easier since it can be done with less
of a strong ABI than the DT.

--NNF9FXNTY80mBlY+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwNOFAAoJECTWi3JdVIfQZYsH/i0xrBOKc/wa1YhUP2Tju3Eu
6MvdgTndbyVzgvSE77HgUOaAHezUEfaQ+nneKJDcvEyX0kp+ZnLOjiJ+qzkAwESf
z8KTqAaPcl1cCnXNy5MWySCrxslUoCGNauagQtlH6susZ4MwNfqTa3+qLp2afMqR
j7s+0fLoiaD4SIfd+1UlbXOraR5R4swGDl22IEM1rhyhbint/P/VcJSiCyxMobD6
OMX5HKyltiLNU+v6WOPXYZC8t+hkR5LGq/mxyGT6/LiiThvOYgPNjwjfO9USRt7Q
09QGIkZFEvTc9pe3eaKjRgPfHUFKvdubuBDohsTx0jjV2QRhRogF4DMT+HmmbDk=
=CVfS
-----END PGP SIGNATURE-----

--NNF9FXNTY80mBlY+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
