Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43201258CE5;
	Wed,  1 Jul 2026 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782914474; cv=none; b=fWJBvOdZkErNcI5UgLIN8dABOKRYyzJGkcmnjUQ63aZJHVoCaXPtYoPVf8inB1iq+l3LaCYvq6KU3Q+N6XTJAki0k49pDYnGCelfmuQ/hMhrg38VEJCQW+jJA2M+pwJlhkZSt7562cUs0dDlooHLkZCbvYK/vgS+cvgRLa73EgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782914474; c=relaxed/simple;
	bh=VqZCnCHSoI/GEJwsKuS7ZPBXcwhIn9kmWniqg9jwFnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG7aCAXeHVMmnfaW2T8t2jwdMk1y2iwGK67RlU6w4u1bMqDhYvDcySox2RggJdDqKkzTuUbOmPoPhHDJZuRKQlKCflQnK4hMfpPDotqqqOTfCJhcYZnX9kIjRbhxwDiJ6LWmo6iDdf3YRQkOaHyhjJe5a9C0/uOJd5MPMcveQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgPMDe+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgPMDe+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4A31F000E9;
	Wed,  1 Jul 2026 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782914472;
	bh=VqZCnCHSoI/GEJwsKuS7ZPBXcwhIn9kmWniqg9jwFnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TgPMDe+dzdQzr08x0l/ofKjzb0vziIrOyUgzp66nznlm2Bv8iBbNF7B3Tqqi75dYV
	 1WxW9wx/rJhX2sv/33J4tZuQloXSXb15Vl4cYNoBQ56HZ2GI/s6HshUXC8GPOS5qUq
	 ZUtQ9Hkv3VeTaZsKtRM9O7QWr/wBLOOwF8qICKe9vqzP7BPErvZ9HucfH87ZEymlR5
	 AhoL436Y1bC1/tsjAkJljn0ISvCarS7ZspEdplJpZvyeHvcQy7tK9XMUZ2FmjCpig+
	 EfzOrr1Wx45yPv8GZXToE04rEUE8ZG86Jb4nduoVdsX8DHlcD3IaEPJvtRDGwYmCqZ
	 yncVA/IyN/0QA==
Date: Wed, 1 Jul 2026 15:01:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 0/2] spi: dt-bindings: snps,dw-apb-ssi: updates for
 RZ/N1D
Message-ID: <364d2f57-db58-4ba1-a12c-025233fe35c0@sirena.org.uk>
References: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gdQxpYIOjL2qDbmZ"
Content-Disposition: inline
In-Reply-To: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
X-Cookie: Do unto others before they undo you.


--gdQxpYIOjL2qDbmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 03:12:48PM +0200, Wolfram Sang wrote:
> Since the actual DT additions are in -next now, here are the remaining
> DT binding updates for the Renesas RZ/N1D SoC. Changes since v4 are
> described in the individual patches.

This doesn't apply against current code, please check and resend.

--gdQxpYIOjL2qDbmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpFHaMACgkQJNaLcl1U
h9ABGQf/Wrp+1MMYahe5qL1MB4SpNVJWw+/ijaZkh2uanUYr8F1UPMhbW+fwGvlS
pEWpO1vyKm2WLbRL6cdKOgcGmgQ+qNRDmyFXQigsY96NAgCU22LeRGOwt1dmkgMp
vurivW4k+mteTd+ZTSt4oeEjS795o7cEZdD2aKz5YJmYQt1O1yuSdGeynjW5/eB2
DQSvQkEZhkAJeEKmf6BiserEiFeW51SBfBhl9J4+7gePK/yfa7BoUYRWkXKrgDWg
TeJILao1tr/NbTy0MP3HCx/pny9jfpIP2k3nIjxAZxaSc6Tq6Xwh0BtrmlteW6RS
xEwckFiaAsjumK+EIHP2NCstzvVBpg==
=MIDP
-----END PGP SIGNATURE-----

--gdQxpYIOjL2qDbmZ--
