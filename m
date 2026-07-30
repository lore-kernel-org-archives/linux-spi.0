Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE23437124;
	Thu, 30 Jul 2026 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417755; cv=none; b=FUxhZjegu0M7tXR9zPETONdd18l38FviMJdXx/XBznRQbz8DYrEWjL11al6PLsCzfMeVpVxaewNNfM2L7WdWHXFTHFDoPqxoeONi45cZ+xm86W7fPKDkODWhz7fI1HB9MzrLmX3r2ITMdMWxpJNrVTjb4pbzS4bmCbb7sc2fokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417755; c=relaxed/simple;
	bh=mIo3bDHGxiYgzwh+V9qnJf9WN84MJyrvU3GvTfByHMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssvPp6jlPtGKbhfsj1fsVVymWqYSP6DKj3/w1ryLzJBTvYWjeZ2mxQLja9WDeERKJp9rczsRkJIy3GFUawqaMu7MTtC891Lj5jjhgCrcGTcKGX2X6kPwnF8YGOzPZyrhV21YUKlb99JThK0czRzO+aEWt3w02lQEclmCbIQPccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/O8Ol09; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/O8Ol09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C06F1F000E9;
	Thu, 30 Jul 2026 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417753;
	bh=9Q3HIxWWSodqt0Bo0OCgnfV4yYAcllzEKkbzND1L9o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B/O8Ol09cZSmMUODobcKqSgd5Q/JcwB+2tZgm0DaW+RO4xPO7iONvAMbU7s8GrSss
	 tF71RlusA1A8HJt452LGRwMCcB+O2o5A+ngycPYg/Pn6KsVL8Zy1VIuU7WWaMht3I1
	 0050WXTMkk7gol4vgXHOeTeAFqzR2l3icuVR7z2g0PmSwR0DM3skSzni0sjgoafmZd
	 vnSfQHPVUf0C8FiZDURuUF/UMKh/fEO/i4hKC8kSFW0RbqHKFp5TJhPoRk56uEhQO/
	 8ihOS88SOl29wZ09Wr6XN2aX/RUL7xIZD0rW0ttoinnmiUzo65zvplml7lv7YQ5Lcl
	 cyf7wIqfPgXgw==
Date: Thu, 30 Jul 2026 14:22:28 +0100
From: Mark Brown <broonie@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Message-ID: <db111663-27a2-4299-a692-6154f1f842ca@sirena.org.uk>
References: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
 <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9CS4vkVm2ZtSBEMP"
Content-Disposition: inline
In-Reply-To: <20260723-a9-spisg-v2-1-9fc39106b7e2@amlogic.com>
X-Cookie: In specially marked packages only.


--9CS4vkVm2ZtSBEMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 06:43:42AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>

> Document the Amlogic A9 SPISG controller and its additional
> Device Tree properties.

> Add the "amlogic,a9-spisg" compatible string and define the
> A9-specific "amlogic,mo-idle-output" and "amlogic,word-gap"
> properties, which configure the MOSI idle output level and
> the inter-word gap, respectively.

> @@ -35,6 +34,23 @@ properties:
>    resets:
>      maxItems: 1
> =20
> +  amlogic,mo-idle-output:
> +    description: |
> +      Controls the MOSI output level when the controller is idle.
> +      0 - Drive MOSI low
> +      1 - Drive MOSI high
> +      2 - Follow the last transmitted bit
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 0
> +
> +  amlogic,word-gap:
> +    description: |
> +      Number of idle clock cycles inserted between consecutive SPI words.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 1

I'd expect these to be per-device properties, not per controller.  The
word_gap sounds a lot like the existing word_delay feature we have - if
it's different it'd be good to be clear why.

--9CS4vkVm2ZtSBEMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmprUBMACgkQJNaLcl1U
h9B6Igf/X+zzg9VfJoUN5T5BGj5eihf8ukNh7rLmr4zYQsfOkHIr/NcL/kZsXsxf
7KuCeVVRO/KVxZesl6kSr8Kf7h8SEjJChTauUDDy2Yy3up9zzI0seOO2Kpibc3Nh
Xq+6ZmSDie9G3zBKMHNB71//bhMI+K5duCbfk8A0F6dsG1wsJobxAAlhTcHZnsiu
LkmiQ+7p/rbBodJ6B+zk7tnpSvNFYaOkXVYO0I+kgDCF7uCyHok1/UKT/iYaaBbI
R6ryWEykKC5fRmxPgculPRoamYLQhC/uMIMtSLdQK1DiKxVc5tEzp0pVLkKi4xss
nQMdyTzCWVf4gThGtW1MS6J6xSXnRw==
=2hV1
-----END PGP SIGNATURE-----

--9CS4vkVm2ZtSBEMP--
