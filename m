Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD424195D2;
	Thu,  9 Jul 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619734; cv=none; b=clu94l9Pxx6XnVjE9yFwnIY7rSELS2cQ133mYkADPYpWgAWc05sHttHyiVyzZIzFtaTMFto9L9abItwS5Fh7Soag+ZoVWL5hulrhkqQJC3JeCPTeUUnq6mlROyCEM1A9t1bL2VrmnmuebC7ZYf9ZNJ4A4TzeiU6r8PVkU2E7LHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619734; c=relaxed/simple;
	bh=5c0ePBG4qS0xsg294qaV/O58VNPvquRw3o2eBFNumMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um31qWxrv7HFWfM8GXAAVF82MYnFoAtSJ2OPdaJxirKvNbjBU7XGnaBQfTrzgGOyumO44uGgwXzCmvYTlF8AivLvN/Qvf7uChtDZBf0eiq6VLTqA+zk6fSWg0tlgDE9UwcVrgk6OukoImowKxZA3HmD9zNLhilbiekWQd6ONPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqZAyW8y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqZAyW8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3891F000E9;
	Thu,  9 Jul 2026 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619732;
	bh=5c0ePBG4qS0xsg294qaV/O58VNPvquRw3o2eBFNumMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WqZAyW8y5rRMIOtbQ9Cqf0p+p6dFviN8Ix1fCiJKj11E3n7wpKWS/kCOrwnBch27b
	 msbGbaR2d3hTlYR0Em5s0x8BdJLtvQXMUV2ScwRxkNn26RZs7Y37aPXPaxhYO2VclC
	 t/FicwmfDlfJT5zII7GyDDbjtwyy0lzRGKvcgFsnNd9ifqXcTgPAXkYvgx02YIEnuN
	 hNXAjn36WQjKb8G8IXQi/hXuubZsWw2x1m6AFaIO2ZzA4+9jTE3xfNjF0SoswVkSig
	 THN604z2ybIquMbEWb1mFdkOui79BpfjTqGiN6UmigoB68ExKTs2OjgL5ZqegnmWyK
	 GIvDPYATclp+g==
Date: Thu, 9 Jul 2026 18:55:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 10/11] spi: dt-bindings: snps,dw-apb-ssi: Add
 starfive,jhb100-sfc
Message-ID: <20260709-unknotted-semicolon-e6ca03045dfb@spud>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
 <20260709055204.138168-11-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75GMnnpgGICtpI4b"
Content-Disposition: inline
In-Reply-To: <20260709055204.138168-11-changhuang.liang@starfivetech.com>

--75GMnnpgGICtpI4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--75GMnnpgGICtpI4b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/gkAAKCRB4tDGHoIJi
0i4dAQDaNsniwMrRz58aPNNJgIDQ2gGyhBF5ce672KyXoQ70DgD/S7Gdx+OPCZ/n
rCxj+ota37SgrawTEEfZDw06Typm4Qw=
=sMq5
-----END PGP SIGNATURE-----

--75GMnnpgGICtpI4b--
