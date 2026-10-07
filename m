Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC848F84A;
	Wed,  7 Oct 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378052; cv=none; b=HtNOOG0ulH9l1WH6Q4KCHOVvYZL80H2YBVyEUizoXkRss1F+QZO5CeiJYLG+cd/RcE48i8lZdxrhfj/9LjBPSxuF4ZyzozbbJvinMdvgKcx8uZJXiNBD38FNTjYhUC/4y21G92jge1IcYIItpNEY5gNEWQyt8aWiaP+kCxzP/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378052; c=relaxed/simple;
	bh=wVui5JvcOq8huEO2qVQWNOOzNKKo/m7drOTBUTuvFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp1HYSFLrJE7oe0SKogx5EMvDcy5uEGj0wDuoCffHoVsXcWxTxziKYupWcXdgzm4MWXarFPN718+rtCaMs1WaxjwztM7KnyaGm/NrbciHcByuvnJf+JEMWrv5Dw3RQsDXACBd5Dcg2GjidVmWpvTl2MaHRdgsrTqHmkTuUKgpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtIczxix; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtIczxix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7DB1F0089B;
	Wed,  7 Oct 2026 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791378041;
	bh=wVui5JvcOq8huEO2qVQWNOOzNKKo/m7drOTBUTuvFcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OtIczxixZSjTMKa7l1zwOvq2KJ2nhXx0wyaYctDNoAbGQTSxljrNEb2S+aR3f+XmA
	 zEJw9AJYXZ0tlBtu0DnczDDHyaUpaUj68mxD3a4yQOldp2455OjaDmkzllPai6+FRi
	 IdKgv/FjWhZ8ca8lLZxripyBkoeZHifF67Qs8twGJoppS9ZlgOi6Y49LvN8WVQ3SML
	 5mmgpKZJYQ6DktmhLJixpFb5/7yA+hcIDk8wEzLRSkZcMbiZF4/Te0tbw4/+X3T+So
	 rv2+/g5g2nfRKgZobQRv+8pT8dw/VbLb154xgztC2OzOEFIcUOdESBoMXQZp/3Gwjq
	 DAPt+//eiMDeQ==
Date: Wed, 7 Oct 2026 14:00:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics
 sl2610 spi
Message-ID: <20261007-98ffe987a033d151c00f07b6@squawk>
References: <20261005152230.25294-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lltXdfbP2Sj1+Uqv"
Content-Disposition: inline
In-Reply-To: <20261005152230.25294-1-jszhang@kernel.org>

--lltXdfbP2Sj1+Uqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--lltXdfbP2Sj1+Uqv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasZCdQAKCRB4tDGHoIJi
0mBdAQDquimB045HtqbYl5UmVS2UTf3zHKFF6IMUtlr0OUDz4wEA7ha1saExxmrS
xdaaRIH2hauCWSiRTS6aScOFGPzJHg0=
=H8FH
-----END PGP SIGNATURE-----

--lltXdfbP2Sj1+Uqv--
