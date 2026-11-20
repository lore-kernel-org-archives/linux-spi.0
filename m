Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195605;
	b=eWDAXYbEgPQ97ek9+6qrByy8n49balFW5CWusnURlVYoAT7TRjQHypBC3R6mnsXnpdBI
	 YWqnHsoqWGyY5VqVfAx64MVSp7ON3FamBfo3t2i898yo3YGM/UY2OXXjUUyvUbKSEHzvu
	 3nG9o+sSNEKun6v9gvQ2IUHTiu6Pc4ZIYBwNPCs3XZBLL6ZYxV3CrRFwSa6f1KxeDW/u7
	 lDZoRViUPQJ3/qX/3iqLon9a12O/HPQ17Yty1xMQuM3S2NvpZRlj7GScaea+jQWwEBLvS
	 RJZ/OxWVRAVMZ9xb9iMeeB4sUenxMfRQ02SvYkykd+yVciM2ZXD3xIR7qvJ4sWUjgDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195605;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fxf+nipH1Cr8jDUljHcHSs5CO02bX7aKJ8t0CkTEBBU=;
	b=haRMOo/iTWl45lI4Gu08wjRTxxAn4Ix+J1PC1u75kp75VDa0kSaymJle15bwF9szCWfJ
	 M5jEm8AgYuZMpSr69N/msDbtFPaDlLibUvhM0cDaD+6jTRvpg8U+sfbwvoUXvXXPnogPN
	 Gi9OyiGqCbH8BQDmMyCC4GleEobgfvlAjxDqZow3j3RAVSuI6BVeZfO5CUZb5mon98F0W
	 Rtbb+o63NADTNkOQZ/Jq7ku5qIBEWpktzjpIdH8cSEjFIM/tvbtoFMwHQ27bTvRC+cnGd
	 r3kKerp8FgHcVOEog0/XtKtHmsBXZ49Yj7ZNeN0FcSndS37lM5Pf+FUtkYLGzj3dw8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKjykBdQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F23606A32A;
	Fri, 20 Nov 2026 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKjykBdQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E69E1F000C6;
	Fri, 20 Nov 2026 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195604;
	bh=fxf+nipH1Cr8jDUljHcHSs5CO02bX7aKJ8t0CkTEBBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IKjykBdQKK6UW+SjhXzoKfCs3ox84evesRjlgzUkRt6YulvgkWsuJ7oWEVj3R4cv6
	 Fftdt/yPrrRSZUjOA9mkOAUBImSavMj2Dy6TuqPKpPUrulY4kci8BvV1clqgYYORo0
	 bQnnB7toxNM/1VekBdnBdO5GsKR4cy9Mc3ZM7i/IMuPOy5hr3JmsfymyfkU5WkCn2N
	 lB8b9+78K9kTag+XccBAZpKZq8NCcrmvZ0STC89Q4c0FGcFr9AF5/f+QkN07cB0XbA
	 Emr1tzs/OkXsPtIdltSMHc+eDGheLG67tntbcdN2m9XB32B3myFkLcjXLcO4WKUAZh
	 G1zd1xci164Ng==
Date: Fri, 20 Nov 2026 17:26:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Navid Ghahremani <ghahramani.navid@gmail.com>,
	linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash
 controller binding
Message-ID: <20261120-unrivaled-prong-1e95735fe087@spud>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
 <179518848943.6016.16140133614242447239.b4-review@b4>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rjrmWXXpDlSqC1UG"
Content-Disposition: inline
In-Reply-To: <179518848943.6016.16140133614242447239.b4-review@b4>

--rjrmWXXpDlSqC1UG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 03:28:09PM +0000, Mark Brown wrote:
> > Add Device Tree binding for the ZTE ZX family SPI flash controller,
> > supporting both ZX29 and ZX279128S SoCs.
>=20
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
>=20
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - zte,zx29-qspi
>=20
> This looks like a wildcard binding which we don't normally allow.

I figure by wildcard you mean that the compatible is covering the whole
family, rather than the x being a wildcard character. If so, I agree
that it should not be allowed. I don't really know why it is here, no
other patch in the series that I looked at seems to do anything of the
sort, it's all device-specific ones for the xz279128s.


--rjrmWXXpDlSqC1UG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawCCzwAKCRB4tDGHoIJi
0laKAQDRGnEKIBosOkTgcH+zt5RiPxDTs6KvjxZOxByJ94lB1wD/RN9YSoRwzHfG
KwRcBXW7isi8mBE1p07Uf0zJ4hunvwc=
=RCwU
-----END PGP SIGNATURE-----

--rjrmWXXpDlSqC1UG--
