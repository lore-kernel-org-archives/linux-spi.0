From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 23/42] drivers/spi: don't check resource with
 devm_ioremap_resource
Date: Fri, 10 May 2013 11:55:45 +0100
Message-ID: <20130510105545.GO3200@sirena.org.uk>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0UhZIN3Sa23/ILEd"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1368173847-5661-24-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--0UhZIN3Sa23/ILEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2013 at 10:17:08AM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

--0UhZIN3Sa23/ILEd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRjNIuAAoJELSic+t+oim9EeAP/3F5K6xUKoR1bkGZRU/CHceB
yG7qHKrgOSNrzkSa7HR/KlahfszLl8BQ9dCo2CzAEWhpxmbzDtX7Ift3CDG+sI9W
WxKNxOib39VRHYE2CkbXHAabX/cUWA498zxfMAfkRJzPnLDakkqhq8Vnk8JDDwzq
cjedISrRRtwIzQLea/dr0l3Ad2ipkI55GJScwv7BGunglTLg4mhoT+w32WqPXC4u
yTo5r79o2qfF2UkU6o3XJkoWG8Kblr26HAEPRMPwmeVzqjLrNiFT6BhdRVW6nvEq
KEobD06ZQ6AKrcs4/GZoVN2aAz288vRZLSEOiFVMPA0nQyNa6sEW88DBhhke3LVj
zzfTiy+0AU0yaJd8Qxxgg8H2Ps4N0C9f+o9YFABWyt0SHKXPldSg6mfIoYyvcKEj
fRa/k1l2cHaYaFdwPRm8MjjKgRO5Pcrsl4kp/idIwLTQHxr3VztDyeDpwzeeRMZ3
X2VsjlBlkw+kmlD1BR2FffsaXaJ6QM/YREju97Zzw5A/WrwY5w1AXJo7gTy+R7Vt
9x79t/3Vr6yujHwfKSnj3pvfbch5Do8RTjXocji3vTxP8KyYvC+sFGYKLTDxwhaB
pXSC6DIgWxr+uUmiqYJ/UkS16WfgTPrGNNsPQ4MXGL7B8J29D9agEtoqNXDGa82X
BUEfIfHkMPsyK/ct6wDs
=kFrz
-----END PGP SIGNATURE-----

--0UhZIN3Sa23/ILEd--
