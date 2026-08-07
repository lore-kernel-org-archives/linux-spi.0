Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8C9349CEE;
	Fri,  7 Aug 2026 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123455; cv=none; b=OVlIPDsOfePPhKPzgV3yv0K5TYmXDblhVe2WSUB1AY3fnA0Wp/c4G2YAKHZtaSb97qDS9gzeBwf6CBcwHITZU6OMzF1xWTXyvVVWECPpbwg80U9kE7p6YuD7jIeMes67S+93DNBawx2YB5aLjLAvRytY1RmNTRVjyQ3T0W+7tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123455; c=relaxed/simple;
	bh=dp+rQ+9tXN+ILP39MtpVWdK/56TUiIFgbZEK/rGCry8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGpemt36k+3bDJDOQJWPc6bttnT5T9YLEcQqR+izhI0Afo2aybpfiT39bw6ZgBvoiG/sNccoNFqaVVpmQsBGZMfW36yRLBo2J1ul368Rg4YjeNs0OZN8nf/xQJjaNMqKNsFPj9x8qUKlQbI5bvd9MQCy6p3sBcaYm+UN1A7fk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWvpwDAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWvpwDAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E03C1F000E9;
	Fri,  7 Aug 2026 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786123453;
	bh=dp+rQ+9tXN+ILP39MtpVWdK/56TUiIFgbZEK/rGCry8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kWvpwDASOGrXOaCK48UqKL1L/VSWGuXmoZ4Qo5lXfQcf1IFtOSKhL5TlerAkHDs3U
	 +BK/RbjX4tGC1lX2a3QFFDgnIjipDMg/NhEc9W6o8rnykXQKiroJFU/90KheZPrCB8
	 AppEMwsdqNAeVPnK1nhj4Dy9rtWE1NGLPU7tO3MNQF7DD8oZz+XOnqIBJuLesJhFOT
	 C5aRkX723vgdFFwSAPBu65JKQO9XFKpsloNDUWpTvXTWKTqoOLWmUSLTUIl2ct6Cb8
	 iohnLAnA4za4bHpky8pvHrei974W+kW21Y//qbBTX0pQqENBXwAL9v+9tQAPVnGfmo
	 2c2abMCHCJN3g==
Date: Fri, 7 Aug 2026 18:24:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] spi: dw: use threaded interrupt
Message-ID: <f612ec54-6aa4-4b25-80fa-22666cad7227@sirena.org.uk>
References: <20260803140649.12718-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RQVSMlE7aA9ItFry"
Content-Disposition: inline
In-Reply-To: <20260803140649.12718-1-jszhang@kernel.org>
X-Cookie: 1 + 1 = 3, for large values of 1.


--RQVSMlE7aA9ItFry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 10:06:46PM +0800, Jisheng Zhang wrote:
> To avoid blocking for an excessive amount of time, eventually impacting
> on system responsiveness, hard interrupt handlers should finish
> executing in as little time as possible.

This is broadly good but needs a rebase against current code, I do have
a couple of smaller comments.

--RQVSMlE7aA9ItFry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp2FLgACgkQJNaLcl1U
h9AkZQf/YJjckvIWrV7/MsW9mMemAijX1XgIwiQ8sGFogilczD6FhMpnZVd/Lq2m
k+Q/8kebR1zgbWyaFrZaN12r+3s3Z8TcCvJj+tyP82DflOHETR4lTKFrWf3o4j7m
oh3/BTo9m11hoEXRO3wYjXEJjxXBAOL3vYF1ZXPce7d0amW/JMMHNugyzYCmr9Hp
urfMTGbi0m8YVnBQoLUPB0MnAvYYg/81WbTdn9pNkE4X8EcEm9PzqREuzEpeIMny
VR0sDQ8Z97w1TawEzigHUP3gsTSDOvGRZZckjoBy9blEDhnZUGATMM59vqIUQXLQ
16pMI1+IvIehrvFrIutRR8cng1TYgQ==
=8WZP
-----END PGP SIGNATURE-----

--RQVSMlE7aA9ItFry--
