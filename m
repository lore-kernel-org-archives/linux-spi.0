Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771B384CE9
	for <linux-spi@vger.kernel.org>; Tue, 23 Jun 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782256051; cv=none; b=enPLwSApii4ikwTiAH00t/PZXguGueKwK3gP26ZgvY/rrAcDvygVAKD+xTmRsDIpHFz7Qgyrkx/KqlKMo3yJtZTbOdnKOiXYxHGjGBXyH9buXk1H519TjOxHhw8nlX0MWWU6bgCrhq4rAyd+qf98RfVPviez/ycxsXBZ/TH57Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782256051; c=relaxed/simple;
	bh=Yd545GqIfbnXZUQCFl4mDlvW28Qjy3hR1AIQLLHO/BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoqElH3HKUnbbRcTLInW/ZR9ceFrulKlyQ5ixN405ByMYzSYWGlIQaBwvrZDbLPR3AAlXrtpQXXWCEVirel/IMm9kQc56/VaHZAxbwZe0+YmvGDMnIJOh9eGRrZVAprqz7ktFowoJ7GCqSssZDV4Qj6tEASu7+8ruQrKwFUdKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ObK0ZbtP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ObK0ZbtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+QeS
	jfYgJlnAI/ew10CUiFjFUaNitNkHaAXMPMGpm3U=; b=ObK0ZbtPGq81Co+OWjRO
	7I8xaepsQSQVXCQ8lP27l0b+4hQeCzfjsGeWuIuh9UoNSSAXgKOj3oyxhOB/caCf
	5EHij71JQA48I6aYY72PM2b7D9GkjL8ztH2xi7y7KZaXqyKPYXgvRTKIRY95ANcW
	qZ1AA/erhHev2kofs5chWlU8J/bn4hkLqCpoqbssYtkzH/HagXPgXxvKYpeYSywm
	+g1RGpVMlSDHSKCUikF8nzrkrx8omsh4wMseo5Wj+VzCZ98SsAfXcViRz8Ke3Uwg
	TbuhgdBvQvimtDfdmfu0BowyM48LbB/jx8skgQliEbRCF3ydzjU3CnfjNL/VCTMt
	7g==
Received: (qmail 2528513 invoked from network); 24 Jun 2026 01:07:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Jun 2026 01:07:24 +0200
X-UD-Smtp-Session: l3s3148p1@7eJt0vNUkuUujnuj
Date: Wed, 24 Jun 2026 01:07:24 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: dt-bindings: snps,dw-apb-ssi: add
 'power-domains' property
Message-ID: <ajsRrFBdhiXm4Iwp@ninjato>
References: <20260622174806.74450-5-wsa+renesas@sang-engineering.com>
 <20260622174806.74450-6-wsa+renesas@sang-engineering.com>
 <20260623-banana-bettong-from-saturn-417cce@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vIwgRz2LlLolQzb"
Content-Disposition: inline
In-Reply-To: <20260623-banana-bettong-from-saturn-417cce@quoll>


--4vIwgRz2LlLolQzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +  power-domains:
> > +    maxItems: 1
>=20
> You should explain in the commit msg that likely other devices belong to
> power domain as well or likely can belong. Otherwise based on the commit
> msg I would suggest restricting it per variant... except that indeed
> these other variants could have a power domain.

Okay, if 'likely' is enough for you, I can reword it.


--4vIwgRz2LlLolQzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmo7EacACgkQFA3kzBSg
KbZpUQ/8DweF5fY+8taKeSRhmRor2A/dFaL2ORXt8pokPumkA2w75fh3FpqYfP4j
FUDJUpt5WkmPPP/eKJtC/M4LrwMqwYnluODx1axtw3AwK9n+ZK/+O1K/tbBvY166
9BPDtLl0mTSXUYjdw1bN+GegDl5gIHgkpgzGK9wyzu+vBK+WvLcmVi6Ua0BTwP1i
uF0IzhabpyZ/ZzqVKfJNuE+ca8Yg8++ajiiHmvBdF4gAdKPaCzasfauwjxq8UBJ3
cKKR5+RPoqQ7A4cFYN5y6KClVuYY3osvwudvqcsSqv3FGIVaexwvNFiuQaAIl5ne
I0kMqe9jXLsnP/mgj6u1HbwWmD5F86wGaIZo+0zvYAhLwuL599k+cf2rgycmBCwC
e+Yd0Gww1ur2+fdwbn7zuXsvDnwr0a8dCZ5OIbHcvZL1MeLGLBM34Vf1RwXHRwAq
Dej8Ned7UwLUaq2shbqvkdy9rgKZEcTcx8oXo+FzVgXqJ9Tw4gVGi9PuhvhT2/B8
PmfPxLWHhDC7aZseGUcPl76e4HJ0AJn3XgbRl7VN3s5aHawM+EfmS37YkF0ckASK
xO1ohRha+5QmwBoQ9fjChyYj21zJJ3ZQMKmwEmez+Lt5SI2cuUy7pwVZGVfHcZ/s
LMPGFK7egMnFeZXGK5qA8lPtuOvdT6pG11j8kgSmI5RYXCjJCcA=
=2lbN
-----END PGP SIGNATURE-----

--4vIwgRz2LlLolQzb--
