From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
Date: Tue, 10 Mar 2020 17:14:03 +0000
Message-ID: <20200310171403.GL4106@sirena.org.uk>
References: <20200310073313.21277-1-michael@walle.cc>
 <4beb5200a76f2d817be7276444543de4@walle.cc>
 <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
 <CA+h21hqMoPhbq8YG0UeV1kP0iXApYsJvb9MZjPGX54dm2U-KnQ@mail.gmail.com>
 <76923af394f334337a3cac125c270087@walle.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sCNd3Ivk/oijKKf1"
Cc: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org,
        Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <76923af394f334337a3cac125c270087-QKn5cuLxLXY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--sCNd3Ivk/oijKKf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2020 at 03:12:45PM +0100, Michael Walle wrote:
> Am 2020-03-10 14:02, schrieb Vladimir Oltean:

> > I'm testing LS1028A with IOMMU_DEFAULT_PASSTHROUGH=y and I didn't have
> > time to change my setup now. I've also sent a v3 to my patch series
> > which is going to conflict with this one, sorry.

> No worries, its easy enough to rebase.

> > I would have picked
> > your patch up with my series but I didn't have the right environment
> > to test it.

> I'll resend a v2 once your series is working.

Since it looks like your series might need another spin anyway I'm
thinking it's sensible to apply this now and you rebase instead?  Cuts
down on the number of pending patches if nothing else (unless the
testing stuff gets sorted out of course).

--sCNd3Ivk/oijKKf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nytsACgkQJNaLcl1U
h9CFXAf9Fs1LfShbPgNXymA2EJASuKmlCDxY/9JGibPArY1h+qg7eMbJsbijndm2
iXclHhId06fmvFubASnkilFQmkiJRa8xQ9f0nc5bAU0im4gKeMaO95GzMzoyrCa4
SPLpHEjJLWqD/aW9ewH7Hr5Q9Z45QvmGW/43go97TgXv5CTwwZzcEuLDSabSFUaR
mVvqUpQGy+dnRCebK5XVt31+n5SSJ8ma6c8e6QcO8qRbJzf5Nq4hxg1eH+vYNAkR
vQGIiF3wL9aMu9JbLmTFSPe/yj+WSGr9jDNPT6NgbR54XxwCzFVjAQx21Nj7xVIe
+PQK4vngYCQTN36fg6XPznpD7EeEYA==
=+Mos
-----END PGP SIGNATURE-----

--sCNd3Ivk/oijKKf1--
