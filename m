Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0F38F646
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780905037; cv=none; b=WI/SmQaTu//HNUlzFA2cr0Nc0ksZqgP5dYJ4Wq7S76RUsFld+THUSaTorvp7ESWnCU302WGlDh5/joXxMMobTvMRynHeu8ZOtC/hbXuCcMimNMIElb4oxJraDxXa75GOMpNScP/y3MssJtB0Xc3DCdHFIPnd1PWJjoXBRMdLeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780905037; c=relaxed/simple;
	bh=zkhyzgO5tDO4myvdNulSTUD7XMAtqn3FBpCPEmSzk/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJmxH3RLXOqqi2HqyUVwpKZjVOjBFAS/8/us25HNknV9mA34EAhMoYfy4HH/YK80fpkII/UVOjhYlTz5KYM2i8GScEIe/oRE0i3gP6yjT7gb8UBd2nlkzSCxxkwD3ijlZenkjiLceju+Vjc90BUW6Gb6LAMXsnKZ6lfLfKDkeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kWlt5VoC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="kWlt5VoC"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef1198766so2190000f8f.0
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780905033; x=1781509833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tddTtw7jfmG7mtNYVt3FvpJwKAzzKQR2or6J9wFp804=;
        b=kWlt5VoCJG0YO8sLTEK2h92j0/89JYTQxbZw2H40AJ6kqResy3krm0ZAJ3eub7bEDG
         kuUuNEl+sx1ktBNTnUEvDXjmC3PGyjhNHsGUamv4jCh7qNEs0K6qGMCuyEYrASWEgUBs
         +Y2TZ0Z/9bL/9KrxmHlQdgA6n5+IzmZPx//SP4dIk39LCz+xe9ta9hRKu9jSKgr9LlPZ
         DWO04o3a9z5yEHGcmIIMNIMw+MTGRAR9vfjYKPIK4/y61iEtYjNHadFWnM+LLYv/c6w1
         gfsGMYDBI7RJ9N9sMD/Exoylw1QLKd5adrlJ/tg5J7gwnxeHxr2uQQ3uC1OZyBZqALlO
         4RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780905033; x=1781509833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tddTtw7jfmG7mtNYVt3FvpJwKAzzKQR2or6J9wFp804=;
        b=Is2eD/D9XFuW+JKRK5n8aBDxMTMnoMn7jeXRVQyIIqsfRp+nuSMFAUhR4i7a2GCFAZ
         hBbg8dTdEcrlbasqGY4XzMRlnVFiyBowluywSY5Be8QdH1xtS/tPvUsZUvmosWcqSGNm
         /DT4ThZDvRk3D8CWlD4uH9xcssFGlBjJCIkSfeYhwIPn9BIaMVQHPXh4FTBxSKWknhvD
         Edf8itth4z3D6YwzUgrX6FKr5Lf+4f8o+yEQPieGFRo/X48Pawvlw8vpuOsahesTZJf9
         WX1NcueMbZEKaGmNeRGAPViQGA4ns1JNYHl8zDhDUYfn0kBI7Qk4p7m73oM4zfXSw+QK
         EV3g==
X-Forwarded-Encrypted: i=1; AFNElJ/gXr9bSpndXILlOvGGBTlmAZdySVJGWph/0Czi7OPydGq4BUrhv0GHJAVR9IuSbLBNSIAkueQXuwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUGl0v0GxOm0Mpvjq2e1LFN5bwgqgw/rm80+AO72XzbwvN/on
	5QICPgKtCF9S2LUVi8w0EdHCeFTyCFvgyM0hQixdCpuJocf+LX9iiFye8PxxGBckn/E=
X-Gm-Gg: Acq92OGbYN7OVv/BjWqZ3h+Qv5deqyDYhSjjjbv65uC85Q/wse1pfyTqJewszv5bFaU
	fFjFiXdIzj3yu8B06ar2jJEhx2De1NZipAjiboyngmLsdxMyzBMDTDuZZRC5EojJZpbwwwg8R+m
	2sZbeXMkkGJ/SCKT1/EEDESSOdaPP6zBAuZFOYEZoeZXHpNNlgqApU+zVhXZw39CughF4BuF4m6
	lOsas1xit+8NQmwkmaVMpYKabz60P08hkNKgy0f2GFNPoE8bO1bXn+TzED5GPg6JOciLPNeBzLM
	gpgBOlfF+uwr+Br0+94d4Fu/nH7q+b/mqi3BTqSygUF6KEgb9OrPZx0B8s47EMsPbXGddlxveE0
	f6n3fLt6BVT3zly8kZVb3J8/a0cIbL0pRUPfqOEi/IPMUtk9u/4RTNDCz1LhZNk+nEalDB8WPpc
	7t+WyCQOiUbgtqJwRkj9WZFyfFj9/eP/XSobUTqdQSvSmt3ZyWcpaRqYZ06b26U9FqozI5bsYwi
	VRHxrw03jGNZBzgBxy3ytaunA==
X-Received: by 2002:a5d:5f90:0:b0:460:1c93:6eb6 with SMTP id ffacd0b85a97d-46032daaee2mr18961681f8f.20.1780905033344;
        Mon, 08 Jun 2026 00:50:33 -0700 (PDT)
Received: from localhost (p200300f65f47db044a0cafb8498f2f85.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4a0c:afb8:498f:2f85])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f0a43e9sm50122898f8f.0.2026.06.08.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:50:32 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:50:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nathan Chancellor <nathan@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
Message-ID: <aiZzqUVahsnD33n8@monoceros>
References: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lhabohevynta6do2"
Content-Disposition: inline
In-Reply-To: <20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org>


--lhabohevynta6do2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] spi: cadence-xspi: Revert COMPILE_TEST support
MIME-Version: 1.0

Hello,

On Sat, Jun 06, 2026 at 03:26:04PM -0700, Nathan Chancellor wrote:
> Commit 0c5b5c40dc31 ("spi: cadence-xspi: Add COMPILE_TEST support")
> allows this driver to be built for 32-bit platforms, which causes a
> semantic conflict with commit 4954d4eca469 ("spi: cadence-xspi: Support
> 32bit and 64bit slave dma interface"), as readsq() and writesq() are
> only available when targeting 64-bit platforms:
>=20
>   drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_sdma_read':
>   drivers/spi/spi-cadence-xspi.c:601:25: error: implicit declaration of f=
unction 'readsq'; did you mean 'readsl'? [-Wimplicit-function-declaration]
>     601 |                         readsq(src, buf, len >> 3);
>         |                         ^~~~~~
>         |                         readsl
>   drivers/spi/spi-cadence-xspi.c: In function 'cdns_xspi_sdma_write':
>   drivers/spi/spi-cadence-xspi.c:623:25: error: implicit declaration of f=
unction 'writesq'; did you mean 'writesl'? [-Wimplicit-function-declaration]
>     623 |                         writesq(dst, buf, len >> 3);
>         |                         ^~~~~~~
>         |                         writesl
>=20
> As there are no known 32-bit platforms that use this controller, revert
> compile testing support to restrict the driver to 64-bit platforms to
> avoid burdening the driver with workarounds.

Given this fixes a build failure in next and we're at -rc7 already, it
would be great to get this in.

Fixes: 4954d4eca469 ("spi: cadence-xspi: Support 32bit and 64bit slave dma =
interface")
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks for preparing the patch
Uwe

--lhabohevynta6do2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmomdDUACgkQj4D7WH0S
/k4UHwf/W9Qvh79Nc8CG7LvGA/Jkb44VNYoKXcNGrsYfqWH0OUlr32yDIiIxk/CS
H/YpqcC27pj7e3Re03XHPHZBTlcNcBZNAhGWaN0kFM1+UV+R0NNVO1bx6gGFgt8J
QN/dshTsh8qM895Mp8YPuPm7XSIqeTCrT/ZiGw25vgpOrmm30eROIDnr9IvUgsVi
9MVU2o2VXc+3JZQjK97v7RsVOi1ue8IoHrP28jkcYgFcTeWTjSwt6xCo4jpK3P6n
eKu+1V8WvEgL1eCRVvFhHgOo+bKry1WV3Ljm8wV5t7BQTFKBXs1LUFYtRDhWmr1V
ccuedWPv4YApPm/As48MYE0FIrrHfg==
=18VH
-----END PGP SIGNATURE-----

--lhabohevynta6do2--
