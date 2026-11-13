Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574501;
	b=CkWL+wbC4Q8XS3f4of4B8a7byjuYRcCMwLaQ+t9VSeDZxp7My8e5OeF11ljPmKXL4InF
	 cSoGnn3dRq4TaMoE4o18yjDnECJI+YWj8/0hDXt9z7cNc70WLsELjeSWm7XRc8ukj9gdB
	 nca/tNYPUtgsjMEkphV3GdFaB8j7Dh6tcSTisFtaZYQcq++KXwehRKfbxd4J7IyX9a4AW
	 IOsbcIw/BzEqqqjX8gXtjkr0WIGBIXDS53fUm7UV0F7Iw9pkK3+SQX2/ijnbw5CSmau5L
	 xQKyizm8UNPprvlnZtJSoSFhSINb7PZKDmNR/iiT1MvOl+kPOgu1rThPGr2nZtN8E0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574501;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=HKKXCOwXKUZdC+9rpZpOluJQ3C9x5U5tPguxAdmC9bU=;
	b=fN5P5RQ6/3YEbIQ3ze1GkHoK4hWvzVMlPLB91NGVlyXE1cto9NF81RKwMQnO3Sw8OlZc
	 V/br372VMyiFlcdXBvetr5MTzHr4mtDJmulmjZj8iAlxbZyg2Aain5Vq48XFC927OZem7
	 +dzFk230oLcbTaUgbWIF+n/6NCxPflLW+PdA+pecY28D3X1v44PBaz0cpz8O6ylEiiRBp
	 9wLPBd6oqPwCsfgsCe0QXzbXnL8MbALR7TFmTdWoTvIM8OFLn1LH0W/jIkq+iExg7vii9
	 Up3oxTbRNFHxGDKg/KdFpayBd8yqK+UnUlzQbh5Oyi4Nt6fS4DTQdASZKIM+Jf26dYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwzbpA6b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6C1606A32D;
	Fri, 13 Nov 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwzbpA6b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ADB1F000C4;
	Fri, 13 Nov 2026 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794574500;
	bh=HKKXCOwXKUZdC+9rpZpOluJQ3C9x5U5tPguxAdmC9bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VwzbpA6blQGKWe2Blsinv9FWxgLFmMcDTIOtBzlcaUUiRKctHJ5zhgDdHhZ7IfZ7b
	 /KWruEk3v7rH57Uywyo8iAMTZmGpeEcU9mQldbEIF8KXy+S9+LalPMlpumGg7nqbRn
	 L2ZIDssRAwh/CTcZLbkwWz7wPanUbK1zQbAtqt/OiH/fMUgM5lJyACxb0tFECp/RB6
	 5jLBQtK7XOkYOgPWLVWJ8j/qy7axMWpEo10Rd14pNC/CrETi/4DyxSZztl7CTzH+hl
	 lP/Dc/7z3x0swbVB/fbQln/XasDQYOCPNTTcr7nzhSIpwh7fIUGITue6WkuLjiVO7+
	 5pUon8EYo2Oqg==
Date: Fri, 13 Nov 2026 12:54:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuai Liu <847807867@qq.com>
Cc: linux-spi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	ojeda@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] rust: spi: add SPI driver abstractions
Message-ID: <ceb9569c-afe8-4bb6-99ae-d9c3258d7558@sirena.org.uk>
References: <179451185979.339049.12323339081307899766.b4-review@b4>
 <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
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
	protocol="application/pgp-signature"; boundary="CvcVQqCYWFX2kFIS"
Content-Disposition: inline
In-Reply-To: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
X-Cookie: Flee at once, all is discovered.


--CvcVQqCYWFX2kFIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2026 at 10:05:28AM +0800, Shuai Liu wrote:
> Rework the device I/O to map onto the lower-level C APIs, as suggested
> by Mark Brown [1]: instead of leveraging the C convenience wrappers
> (spi_write(), spi_read() and spi_write_then_read()), all device I/O is
> now built on a single `SpiDevice::transfer()` primitive that maps onto
> spi_sync(). The convenience methods `write()`, `read()` and
> `write_then_read()` remain as thin wrappers on top of `transfer()`.

This doesn't apply against current code, please check and resend.

--CvcVQqCYWFX2kFIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr3CKAACgkQJNaLcl1U
h9BxvAf9FFXCckOE3lf05HMYN4Ot4Bo5H17CxFOi6H5J2UBecFWS3eyvwHlnt+/L
fnTQatuMKkvPRGZMIlJOIdcpEj0oe4XOO5e0sbrxcuVgimrOXj72+4+F1g1M1w6W
QrGyX4cPpAseVHjB6d6qnHJhosJLCbyiiSFlYfxXDhiC5yOpXePE9g7l+e3Jc6oP
0n1bqHYmBM0s05/qj+/0AUTaTQg212zk9enntEcbxXI3i4WUfnB7KPMMzN+7zItU
sxTHUHAY2elxp30quwc6+bI+2KaiaThr4DjvhTVfr/Dgbm4FpU0qMNcicbYm3UkC
NaY/JK7EBln3TE7G0K+oZ4sOBGw8NQ==
=a5fH
-----END PGP SIGNATURE-----

--CvcVQqCYWFX2kFIS--
