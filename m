From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix hung task timeout when initialization fails
Date: Thu, 1 May 2014 09:03:38 -0700
Message-ID: <20140501160338.GA3245@sirena.org.uk>
References: <1398854171-5187-1-git-send-email-ricardo.ribalda@gmail.com>
 <20140501013402.GL3245@sirena.org.uk>
 <CAPybu_3g=VBW+gGhveBJoc7=tCiPurP_r_+hqOU78bvsg8QJWw@mail.gmail.com>
 <20140501141156.GV3245@sirena.org.uk>
 <CAMuHMdUeFJDq8TMQn=D+y_nWVy-puZDYekV3cPhHTnDF+ebKJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrEcvySKR+fOA8iz"
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUeFJDq8TMQn=D+y_nWVy-puZDYekV3cPhHTnDF+ebKJA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yrEcvySKR+fOA8iz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 01, 2014 at 04:33:58PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 1, 2014 at 4:11 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> master->kworker_task is set like this:

>     master->kworker_task = kthread_run(...)

> so it just contains the status of the creation of the kthread, not if it was
> killed, right? Hence we don't check if it was killed.

> So Ricardo's patch prevents the stopping and destruction of the thread
> if it failed to be _created_.

OK, so that means that the description is very confusing then since it's
talking about the issue being due to kthread_run being killed.

> What if it is killed? I suppose the kthread API handles that internally, as it
> could happen to any thread (e.g. OOM)?

I'm not 100% clear on this to be honest.  Since I'm at ELC I've not
investigated fully yet and I'm mostly going on the patch descriptions
here.

--yrEcvySKR+fOA8iz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYnBXAAoJELSic+t+oim93V8P/ie/2R5Q3VKwOMzugPUCJbR1
ln9p7Qg+oiikOfApn6I7EYiCU/K1Gi5dEWvwWqnIekG0ryU1Rsksqdn2p6a7bwhh
T6/nu4k7yRHLmpbKiDTJzqap9n/1IFtvrXcj/KgqzVj4S9YQUag/cgDOmF5QPonm
7iXzqPAMUPDPQFaVT5KuHWV02amrR72L2Nq7JpJd6TBSAFBnpKsPprI4lnU9KpiM
XWShbA33CTd7P2EtoIHSNBVFr43YwIHFc1m0Dj/3z2r6Ec3tvH0TsOi0mWQzVsOs
VlSL5Dg55laQwNTkz/ym1dBxn5qg6sE8alQtSDGlzLWhZu4Uc+q1Bfd0IJnu0bWF
XauMJRqaKGHYvt+x9yGiKyW7fu2X5L9RJS5QMgmpoMMn9+FGcscrpgAupZ32T0AC
u1mlY9+93LkztuO26qsuoajYYUIdRxV5m+acda2BoDcHZ6o5Mi2NumHCv796PEd8
gi9MeCdbdjyePDwM+6v/FfyGdvtuT9J5qqxqMvI+pfNgPFdcGBKdbveTMWP4hMgP
TKWNQki5GOxvcR57ozMuBs9Ly4ym09/9g2umHwPyf1piVqmweHMGjtRCe26jP866
nSdiqJ/06RZPYdXc1LByIjmcekYAhggse4jPdaVt1S4pQgX1IJ8CABVT3SPSObue
5hisNczFGlkLFLSnjimn
=2C3a
-----END PGP SIGNATURE-----

--yrEcvySKR+fOA8iz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
