From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: fsl-dspi: Make of_device_id array const
Date: Wed, 7 May 2014 20:53:40 +0100
Message-ID: <20140507195340.GN22111@sirena.org.uk>
References: <01db01cf69c8$584cd640$08e682c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KQVDJCmBkPV8WfA9"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Chao Fu' <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <01db01cf69c8$584cd640$08e682c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KQVDJCmBkPV8WfA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2014 at 04:45:41PM +0900, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.

Applied, thanks.

--KQVDJCmBkPV8WfA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTao9BAAoJELSic+t+oim98hoP/RVkj1WDYOODKM2HMSnCxuBz
5l4m1+Zl46LL+Qxy8TwJwxNNjHq+6j3lkIv+SXME3thRVjuGMf5tdLSk6t/TGT4X
mq4pq5QvtFAEcbOvKOsfI8VVOvnzCriVrslQURcwrmcP3t2jYCZkTc3UgDItiV1q
3MAZ1lWEUipwePutun/XsiJkV1dQ3zECktOLbHmsBjEQH5/uJCIZM7bIUan1CcJB
mOs+Kf/KJse86qt9ommKMC/KsvT/Zy7xnbVW3YS/Z8vd7HTiBp5GWQwHpO4uG1ik
F82D9GJW9jQn5pIBUB5tTLi/5zBBWj+btBMRgNpSWnuETICNumd0t1Dy64btLDif
Kwc1JYUbfhaGf7yl7MrSijp3BfyRpy5RpTLL0yL7YEEML5SBBw5CInKVX3B/Smfs
c+XZgcy+Rl4NxBHwysxh5rG9MFOK/EQFuUt+Cliyd7LH2SvCwGLHp99PvzYH/ObJ
sd420CqHUlbrJ4dgS/4qINGrp4AV2XF0TAfSbsMpW0QPvi4ti2kDEKBcx8YDR4rO
7vJbY6UTZOqlUsHvQr+frgpxEwErPcZKq+Lw9xDSA4Mim9uPCuvVMYQQ4UwyPdff
8ns8tdHl68iIAgbx9UOz29jdvBTCz1PHdZQG4+fcrCfjv8yY6s1o12BcxB2jV5Q2
en8uk8UJY8M1b0NiOHdJ
=6bwy
-----END PGP SIGNATURE-----

--KQVDJCmBkPV8WfA9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
