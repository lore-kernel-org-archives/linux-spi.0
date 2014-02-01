From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] spi: core: Introduce devm_spi_alloc_master
Date: Sat, 1 Feb 2014 17:38:41 +0000
Message-ID: <20140201173841.GU22609@sirena.org.uk>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140131121215.GB22609@sirena.org.uk>
 <20140131133111.GF2950@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KSdtjhIkTRrb1Xsv"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140131133111.GF2950@lukather>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KSdtjhIkTRrb1Xsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 02:31:11PM +0100, Maxime Ripard wrote:
> On Fri, Jan 31, 2014 at 12:12:15PM +0000, Mark Brown wrote:

> > This seems confusing - the idea here is that if we've handed the device
> > off to the managed function then the managed function deals with
> > destroying it.  Note that spi_alloc_master() says that the put is only
> > required after errors adding the device (which would be the expected
> > behaviour if you look at other APIs).  Looking at the code I think there
> > is an issue here but I'm not at all clear that this is the best fix.

> Ah, right, spi_master_put doesn't free the memory either...

The memory is freed by the driver core calling the spi_master_release()
callback when it's safe to do so (after the last reference to the device
has gone away).

> I guess we have a few choices here, either:
>   - Add a devm_kzalloc to spi_alloc_master, since most of the drivers
>     I've been looking at fail to free the memory, this would be the
>     least intrusive solution. We'd still have to remove all the kfree
>     calls in the driver that rightfully free the memory.
>   - Make devm_unregister_master also call kfree on the master
>   - Add a kfree to my devm_put_master so that the memory is reclaimed,
>     which isn't the case for now.

> I don't have a strong preference here, maybe for the third one, since
> it makes obvious that it's managed and you don't have to do anything
> about it, while the other do not.

None of the above, definitely nothing to do with calling kfree() once
the device is registered.  We already have that free, it's not the
issue.  The issue is making sure that we hold references when we need
them and drop them when we don't.  I (or someone) needs to sit down and
think it through since things are a bit confused in the code.

--KSdtjhIkTRrb1Xsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS7TEdAAoJELSic+t+oim9QtsP/A8w/rEqIDTUPKxY0crkW3Rj
UjyrafsfxV9OULkJR1G+Ikz+G6WauiKrYcy8YNOo5pQ2WMZPG/aXpk3jBHzMxtvW
4G4TEwIdyA7YUUCYzc6K5YVsJHU44MBBnQRyp6yBOD6ydoLlncUN7xrRiAWgOA5p
54tGY2r4mZSmVn0YBI3N95R8GSyaPR2ddST1dDDRdat23PkjpsQE4FKfvlOXqAXM
is8Any/3A3gj5S782S0raY1d8ae4Dr7EnH3NkM0kxJp798A4f/ZFcMkHDjLoLKcl
UOHEnmG/qVRJecN8wYOnbpEjmfBQZDUzXzlHIVl5T1O7by+ORP2DWdpJTv0NAwQy
LeRm/ANpY2icLSmvEs0YPkUlpYXh2KATPVEjYm3Sr2YedD7ij11g02SCt/ClmzAE
MKNKmJv3UhIx2rCnXbVyOdxzHxmHKOWjjeSk93Vya0YS7oEGRxZjIU+iHsw/EOnO
933R5hzAj8THfgJSngjweoDdRD6jLGzI358oXfPKaFVIF6/ZXECmcF66CK9zopSw
Zr05pNQ68I+rVhINnUqX8XCa/5UgxudOEwt0tstL9lieV9NS0GY3gi6Kt8hhoneE
rPdJiijBpNf1/PCTJDg1HNcbCtodJdGLs/QAM0OKuGh/1UcSUE3Qm+aIVsYrPhW5
7JZYNI8SLfA3G0GHzqrU
=IAOw
-----END PGP SIGNATURE-----

--KSdtjhIkTRrb1Xsv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
