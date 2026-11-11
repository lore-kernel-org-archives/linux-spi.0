Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419837;
	b=bPV2KuebB5aNrtue7hnwrETIJsEmz0+SoaUTsOY1/MgVkyD9NpYxvkm7k9ybtUeZZKUe
	 NWxm3NQzQml6MsZ7HcRPM1ZPOb/BFO/CDJTCOGQPkTaeBrT9Oci3TFIomoRY8TJgD+EsF
	 W4Z3/qzBiy11fvoVW8syUgFjndrY2eRxX+TJlTm9nadJvGCB17L+OPVV9g0E5YwqgLRFJ
	 6PSvQZmH0X8wo+0uXnYWndszBYj158ic4eUpxzgUFalWurOWWQthH44eZTJLKPX7YJT41
	 LjHcIcGu3xvj/ryHIk3Hb8oe/HfEypnWAU02cLvamRB10gUiuUPH2idUxlB5PsykPNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419837;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kwT0u5BAmkTPt3ThPVhZPhsxaRduDfRnorrPaCLdPFc=;
	b=NwyxgUOvZjdjQB1oU497JErg+HlX1ndN0s7hgBRtkofOEQIFNk0EgLQ5mVeaRHuB7PhW
	 M7eJXri79cBmlrsLXFmTQ4wlw8P+f7Cg+1q5qKyzR85UhNVtNlPzY3Gr3WA9I+hKk5hWE
	 /yb7UA5pYYs/cftJsPKdD1YD63NuauYKRkeGjicLnFQEWGz0OX47J4gGTpP0lGsG/gZr+
	 RvrhNDolFY6py78zwJG0QLmI/DtTj391Thy9AEzeVFHAepOPAQ3Y+SwTL16VLP+8+v2RI
	 9ZBeGfnQz64YKO20JyFUVAsvjbpvkRMqABEa+uZ19TjRpgARtZFow9pWlyc2pMR3nAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAdejHGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68C606A326;
	Wed, 11 Nov 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CAdejHGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD931F00A05;
	Wed, 11 Nov 2026 17:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419837;
	bh=kwT0u5BAmkTPt3ThPVhZPhsxaRduDfRnorrPaCLdPFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CAdejHGqUulxp0qdb7r0tU9CVuVMOc04YlDJHAd5ArRPfnNwFT+Kw98CN2JK1bbDE
	 oqowJvIeOBgne8SOCSRh6p7ndaNuYtYj6VuZcZg2G2Y1fjasfDySwKg14dvbWKhGY2
	 ClZKSCiFWwnERKLTFkiBuQPd1vj4ElEEQWIVrTaL7S3WZzPSY/FGj92TDFhGnsGSx6
	 EUL2e8G08O4Ku4BOLoOBzAfKT8sAdX0Dz1W9kWo31ar3zGHGt+rwvIB4z7eHiKLrMj
	 q5NHO/JiihqXfStg5gPL7rP38rj1VwWdTXM9u9CwMNnnT85jfzVGD/W/E8Hva+YG5F
	 Il9uZmgYCRaXw==
Date: Wed, 11 Nov 2026 17:57:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>,
	Pratyush Yadav <p.yadav@ti.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Konrad Kociolek <konrad@cadence.com>,
	Mark Brown <broonie@kernel.org>, Jayshri Pawar <jpawar@cadence.com>
Subject: Re: [PATCH v2 3/8] spi: dt-bindings: cdns,xspi: add clocks and resets
Message-ID: <20261111-subwoofer-ditzy-a1f2ec454df6@spud>
References: <20261111-xspi-cadence-add-acmd-v2-0-d339046ada8b@analog.com>
 <20261111-xspi-cadence-add-acmd-v2-3-d339046ada8b@analog.com>
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
	protocol="application/pgp-signature"; boundary="JcbSWxQXZHqmfkbK"
Content-Disposition: inline
In-Reply-To: <20261111-xspi-cadence-add-acmd-v2-3-d339046ada8b@analog.com>

--JcbSWxQXZHqmfkbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--JcbSWxQXZHqmfkbK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavSseAAKCRB4tDGHoIJi
0hNOAQDmw0rBJLFjv2GrivAWAcL647h23IM2Cz4GwU/kDTkP3gD+NAcCkPcpYaEN
Dc6ECPHHPnSAYDrOzc6+4FvbilP+qQg=
=crf0
-----END PGP SIGNATURE-----

--JcbSWxQXZHqmfkbK--
