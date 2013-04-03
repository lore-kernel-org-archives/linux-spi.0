From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: slink: do not prepare dma transfer with
 DMA_CTRL_ACK flag
Date: Wed, 3 Apr 2013 18:36:53 +0100
Message-ID: <20130403173653.GI11305@opensource.wolfsonmicro.com>
References: <1353662559-26515-1-git-send-email-ldewangan@nvidia.com>
 <20130401133459.GS18636@opensource.wolfsonmicro.com>
 <515BF6ED.2060904@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
Cc: "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <515BF6ED.2060904-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2013 at 03:01:25PM +0530, Laxman Dewangan wrote:

> There was bug in dma driver about handling of DMA_CTRL_ACK flag
> which we fixed after Stephen pointed out.
> This change is no more require.
> Can you please drop this patch? Let me know if I need to send the
> revert patch.

Someone really should've followed up to this patch then, the last
discussion against it was you saying you thought it was OK after Stephen
queried it.  Anyway, I've reverted now.

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXGhuAAoJELSic+t+oim9uCEP/26Nam8u/5S1MPjEGqQWn3Hl
GRhoEe5Iyrn6bk4b9toIYYEpWrm/HKqJAkVs1mkQz4OEmjBkbQ/sCp/ixph6CTpt
Zjr8fmSL0IvunH6JT1dttFWAvp183rlMm1Xs8E8fQNSffFP3oNsDxQBzKal9NqRp
r5qS1HJ72TkJDF7CmJ7FXzc/JUxwBND78zCW2GhVqShb4p7e2KGc5R/x6dCMfW+Y
6XKhYLBZqFVjPAzfbJOX+4G5Lom8j8VHMi4XhnRwjsr1F4kdH38VmJwP3CUQaQPP
mw4pdJz0ps88Kb+Zd0IHkQeQuGZZZ4z2OX4TzBMJR6dhUqpJd1EMBpKkjZg6XpFf
cT6LgFfPxudWdoxVBptUS0I8TeBO4V+J+v6MHX/hswQ2HyWhv3mDpmfOm0SzideG
5sb+OZrzDdR/xgsrtQQchBP8qVnsPToeHwsV4uwk2f1zaOZ97ssYRXYHlYbbDoqF
qict+yMtpVIggFBPD2F404gz45oZy+ypqu4LEtVO6D0Ne4HYvfeRxZp7NEGKoD2z
Bwzw5nUlA8htCbAUHB5oYqWmk4FqVWDTNL2xxOfoZ6zzPV9hzvxJQmTR4SHB3eI8
eFh8EtVttVyJ7SXnEbRRzselfvD/5F8WXCUnhyHwSZoEz34b+/JRZKMkTPUM2Vtg
XoCqylAVSIRMADf7JqKO
=xqm6
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--
