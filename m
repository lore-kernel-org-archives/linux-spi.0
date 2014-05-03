From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: qup: Fix return value checking for
 pm_runtime_get_sync()
Date: Sat, 3 May 2014 09:53:05 -0700
Message-ID: <20140503165305.GE22111@sirena.org.uk>
References: <1399085877.8748.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399085877.8748.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 03, 2014 at 10:57:57AM +0800, Axel Lin wrote:
> pm_runtime_get_sync() returns 1 if !CONFIG_PM_RUNTIME.

Applied, thanks.

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZR7pAAoJELSic+t+oim9O8sP/0Tx+R0CmVBMWnffZDYyyJdo
43E9XqTpPxRUP01jmmIqYiCUVL9W+E43/oR1qcfcs2pGQxu4pI5hzkxvzK7CeeSz
Rb+W4zzx3eRk+GeaeuzQ+1WLogcyRYduqAj0WlPtPZUh2rGZy58yi30ZwZpbrGkX
M2O88JgSJU90yfHw1wbGGCsYU8/peNnn7z3EjQCdHgL2isrtlK7wnACRX/cxOGO3
YS9rYEEKtuT8Yts+AmZK9l44Z8VefIeKkbOwqSLMg9uVVA9c1Ou3z2+GACp8QzJ5
ntumc0T2cUMtiEtsyKAKVNszvWmnl7/dnHedFs60wjDsC1PmPw6wA3Q1MOGB9zdV
YxxR45PWkE8c0bf18VMAZyhYrYDOM8OF568J7GiAREfq5UhD19Q7R9AL8ALNWblt
ERqRoFpZpN/2ZlvnVpulEZ1or7PQ1s17dehnxzZxMAM0VFwV7uEiwqZzC2lWrNI7
3UgqOtH01g3s9gHooX7iu9flaPsHE7YwD4S0KuLSWtwb0snvVm6uoeBpPe4dTNke
09aX/dE5CJzdk4s8Rik3kDzhINSfcwG/v2jk5GKLp0RJzNkZ3OO4UraRvg2W2yI/
USiYjDQ1mevr52v4E3ZbZYpLTONp8cmxizo4qlQ0CtPfmCCdyq7/gS/zw10IOkH3
DJ55/CPcGW9I8w7Qldex
=kpkb
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
