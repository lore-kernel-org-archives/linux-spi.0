From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
Date: Tue, 17 Jan 2017 19:04:07 +0000
Message-ID: <20170117190407.p5ad3dz7ixqm4vz6@sirena.org.uk>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
 <1483522697-6691-2-git-send-email-pandy.gao@nxp.com>
 <20170109193350.aufenjuhtge5e3lu@sirena.org.uk>
 <AM4PR0401MB22737664A5030928464226C7F67C0@AM4PR0401MB2273.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ssxgtaym4udffnfl"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0401MB22737664A5030928464226C7F67C0-4rsfagO7TJw08dPJ0juu2Y3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ssxgtaym4udffnfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 07:03:28AM +0000, Pandy Gao wrote:

> > > The patch recovers the pinctrl setting when exit VLLS mode.

> > Why is this a change here and not in the pinctrl driver?  It sounds like
> > it's the pinctrl driver that's forgetting the settings and should be
> > restoring them on resume but perhaps I'm missing something here.

> If the pinctrl driver restores the setting on resume, then all device node
> should be scanned,  which is irregular.=20

What would restoring the configuration have to do with scanning the
device tree?  The changelog says this is just reapplying the same
settings we started out with so it's just a case of restoring the state
of the device after a runtime resume which is a perfectly normal thing
for a driver to do.

--ssxgtaym4udffnfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+aqYACgkQJNaLcl1U
h9BRdwf/bxQ9Wv+ad2w/+cU0Ojfot2EaxHSBudNn0XbXUSzAuTxZ6w1JacYD1oFk
csQPP45ZpuwKbjNMLrnW2UZfEiskCO0+uizuqX7wjzYZaUGkHbc8zdp4evrBgS3F
tUDzNGcvT6oaQbV68YkgjU27mLdcRxb6gYrJ8XKT4BO6a8tULZ8kPSwM6IbI31iz
vN6GqNQxdwmRfOCeN1eYj8YRQtM8aqts40DeWPKcteLH9T7FMBJGS0hmUnOPWajS
WBksU5pYNkdXSpqYjqdHJ1EavqkJeOo4OAtN1q7/bhtYRsDbGMer5sgmYGBXdSzX
S/rkj1yK/X+T4eINbBeJ7EpdtZRvYw==
=khs3
-----END PGP SIGNATURE-----

--ssxgtaym4udffnfl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
