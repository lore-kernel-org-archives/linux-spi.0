Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF33EA979;
	Thu,  4 Jun 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569032; cv=none; b=Oxi6ardQKTjn4m6UChjpuJh31KhyOTPed2z+I67/olKevhcJNNBkf/HI/Icy4Rc3su+QVNZspunb8x1YRVNLxU74nyyxAqFvuXJFeTSqLPR909sjP0yS3Jp6gBxi4pkOyF8hmEMJjJx1/CnDHxmwtEMl7Tj/zOVDJK7UJzkfIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569032; c=relaxed/simple;
	bh=MtuYg/GikEOV2piE4z8yTl8DJxJEHIStr8A58Ue2VOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEiA/O8hF94cOsqn4pVw8njfNAf6Jcx9poY2Kg1aX+SSetZBQFgRlGK/1E+cLaU82BsAxbgF6Yl1yCe/UfPGaLIlGkHMTedXMCnNwHYh0j3jDiy2wWDowTOtpPD9S6C/H3yY2+S6ZHNU5EmQsqB1AFDZgRLem9NsXoZqGLyzKec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaElvKRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaElvKRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE61F00893;
	Thu,  4 Jun 2026 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780569030;
	bh=sZADRMa0MfIkR7G/LGQuZdn3RgfUSUThlzmU6o98XlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jaElvKRVJ1uwYNIcwRwhqzFAewe9xXJT2QU9wUw1Y23aehm8yiiddgfTf5jeooiOa
	 2HVbaOXo0TOsfoqUk2oCNxzxVmvVpZJsFun+pWQ6O6fij61w3zogVlc6t0wF1booVH
	 sRpbGXKhhzR91t9GCeHyi7+7xS6JrLXQhmvOz+rDx1+X7nUb3+ZdITVcoeRaAJkP5c
	 PtzD+tBmFA4pdQWLLIgCxYIZXn6j9l3ZRRDvF+d6IVtQ4uct0l0CokkLwKeRVOx2lY
	 hI5YJPAupvYC0gdkzg925KuAVAGcK2aWqJLuY9oxHRjJ+mIgIBcX6U/g/wtsM+XyrB
	 x1mqfvzgvROAw==
Date: Thu, 4 Jun 2026 11:30:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] spi: cadence-xspi: Support 32bit and 64bit slave dma
 interface
Message-ID: <f1cacc64-1f27-480a-8f03-4f4b0dad599a@sirena.org.uk>
References: <20260602235825.28614-1-jszhang@kernel.org>
 <e9259b2d-38f4-47bd-8816-3940c2314e9d@sirena.org.uk>
 <aiC98CaOgjs-q39m@xhacker>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLGHpOM7hA1MbBA3"
Content-Disposition: inline
In-Reply-To: <aiC98CaOgjs-q39m@xhacker>
X-Cookie: Q:	Are we not men?


--SLGHpOM7hA1MbBA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 07:51:12AM +0800, Jisheng Zhang wrote:
> On Wed, Jun 03, 2026 at 09:20:29AM +0100, Mark Brown wrote:

> > readsq() and writesq() are only defined under CONFIG_64BIT AFAICT, but
> > the driver will build on 32 bit.  We need to configure out this option
> > on 32 bit architectures.

> Currently, the cadence-xspi has depended on 64BIT, the dependency was
> introduced by commit d58ecc54bb09 ("spi: cadence: Add 64BIT Kconfig
> dependency") for marvell sdma handling. So we have two choices:

Ah, the patch is fine then - I must have been looking at a fixes tree
without the dependency when I reviewed it, I'd forgotten that Marvell
update had gone in.

--SLGHpOM7hA1MbBA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmohU8IACgkQJNaLcl1U
h9AQawf+JJBxf+1h8+2wN/zXVfBnV4PqPcpfW7/YGwuwu6zkMPjuEF+4a+h3L/9C
AcWRuOMvP18hOXoX32fhmrgIoh3zwqqJGuPfAdsHJi9Rpjc3Ne3PCs8wmWoFNkrI
iomLddTr5JqALW87iyuOr7rJ7kYue0DrksO2jLzkDSalpYVoKIP9r5WHPlxva+sf
BVH0EOZmBqFJmjSWfWDkyuWJBep2YoqRSVB3sy6A1Ri+KTzp5/T6jM3N781nTyyX
YH3LayHTz6rfSLdZ5eCzNfr/6xZwLBxzKycj9BPhoqqLapJeWvWWTHEaT4Y+vXiG
p2i3+YypFLaf8kbupRLlKnpTCn7w+w==
=/AOA
-----END PGP SIGNATURE-----

--SLGHpOM7hA1MbBA3--
