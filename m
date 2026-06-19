Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1A18A6CF;
	Fri, 19 Jun 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881242; cv=none; b=KpU5vgCZLHurA73uWBeR7eyZzQOdDGk/mtelamfZxmjnzEsGY6DUA+l23UFKWSaQp8tRFERQPXraszJ4TXo+uAJksmSwiu4w+gxv2EklFV4QCGbyVOngII+dz3S4i9GNBq+P/ffAqAxhYYDxRAWyTKKqAky9TvMshDRSMkcVpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881242; c=relaxed/simple;
	bh=dLseSs2Wm9SPVKWJJ3iGGuTBRDibOYCNjz4WJ+yAxjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uV34iKD5Bq1K8VWy8N0UdeFoBgwdfioKAWFKzEyI81IAtLjuKnS9JDGBFKePO4BnlwMjRzOsIkHqc5pYCzKXTvQNTCqfCPnUjdEm/bi1BekfI42pdRqlSvIKgtnMZt+p8DKhPmLXAdq3yX3YknKBF8bv0cfkW9fyzDj3Od6JwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnF+vQSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnF+vQSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B5A1F000E9;
	Fri, 19 Jun 2026 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881241;
	bh=dLseSs2Wm9SPVKWJJ3iGGuTBRDibOYCNjz4WJ+yAxjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YnF+vQSl8PpRFYny8vN1Sk/FNkz2tx1qvgKApCej7HKSecwB05eI7ScM+iZzPaX7x
	 oy5Bt8XyqRjmS134KhORjcg31hJZCRs9lqtc/S7zZznO7m5GPVlqp/r8laVSoGfli+
	 G5ELsUWdk0dLL7mFOvRHapMZ6W4WXC0GVF+G50kjNmpM6dmu8f5bsbdZxXLQOV97r2
	 B3WJFT3/I6ZnN9/rB/vlfS2F/WpeV0AIDf8RZPZ8H3iqcmXe59tRcn6fPLGB9T8i4Z
	 grW3LsLwrX8NEK3wSDMhuAg6rPaDSbLTgK2LZm9+zQc9oqIQMTNODwcJs6XemmuXXx
	 LLXhADs44gQ2Q==
Date: Fri, 19 Jun 2026 16:00:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add
 starfive,jhb100-spi
Message-ID: <20260619-monkhood-imbecile-7e56b57158a6@spud>
References: <20260619143443.22267-1-changhuang.liang@starfivetech.com>
 <20260619143443.22267-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ng5/tWqnwV/9AP26"
Content-Disposition: inline
In-Reply-To: <20260619143443.22267-2-changhuang.liang@starfivetech.com>


--ng5/tWqnwV/9AP26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ng5/tWqnwV/9AP26
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajVZlQAKCRB4tDGHoIJi
0uscAPsHhWou5nHvVuNchzj8wGZLoj6oDK5OnUyFTYCM1qvReAEAvIjgVwaqSCOi
CX2nNeYwL9+VpsNjreBAJIbt8U9WogM=
=4OYZ
-----END PGP SIGNATURE-----

--ng5/tWqnwV/9AP26--
