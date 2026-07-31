Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5348987C;
	Fri, 31 Jul 2026 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538267; cv=none; b=LrHSIA6BFuhuGatI1uYcL5CCDiu6xayRfsG3YssaqFJA1EBHzZc6zbMbvmJh9K60HQE2fB6ONM58GjsrBru06Fk0eDtPBjJl6ozPHhPW8dkhFftPGgVzuQ2eGxhSPQGeQYi6GPUJ/MylCnqDnlI3Uaqfh8lDgGrFAGxlg2ij4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538267; c=relaxed/simple;
	bh=cz7lRihMnkawiNil9H4gtJP9gFF4jfLX+34GTKV4XWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vkma6gmIcYE5I/LrFsWNU6svqSNQ6eCJ36y25QV400BqRULYgILKxYJh/bSmVwFfc83jSCBQ9DxnRhqdk90Sh43x24WmmcKX0fV1wTj+hDUmCDk45PgrTXxp0I6JU94WESx7e1yQhS9KYRjlrOhUSSjyw5k/eDtX5RoyBa6yQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcuVJaQJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcuVJaQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62ED1F00AC4;
	Fri, 31 Jul 2026 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538265;
	bh=WVKewVt6jU8PO8TNBGUDNql/WkOfmdCohX/gNa/Duyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OcuVJaQJ2gso9gBzoXTyT5UXsLZpk8k7ygVvJlwz+k9rYRlJ0G3qyeHiomxOmH00J
	 fqdkrWcFq+t+DLlublLUvZE3OotdTU1TUyaSxt0aNs3G8qxONF5mCI+OcXD+jRkNpS
	 3bNNFUfWbkDelwpActv6QxyT+pc/SYltjq1P2YYWOopqYkWOo8uJ7kMBKy1rRYAG5V
	 b7FpoHmJ1xKr2/HRpdQv2sUxuAlLd1gDLmD20RYNUOlz2RLdLFeQtoj/KQ8hBIQEj/
	 OQstNVBi6HInhD3fryq+1AVdvFIb8hjZMKC3/Q1TAyLsi6BmmzBq6nUAoHB54d9cJU
	 eoh1jOAcjwHXg==
Date: Fri, 31 Jul 2026 23:51:01 +0100
From: Mark Brown <broonie@kernel.org>
To: xianwei.zhao@amlogic.com
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/4] spi: dt-bindings: amlogic: spisg: Document
 A9-specific properties
Message-ID: <b09ba781-9042-4199-a7bf-126d07e97408@sirena.org.uk>
References: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
 <20260731-a9-spisg-v3-1-a15da3f70029@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qWk8ktmf4xBbOZ3h"
Content-Disposition: inline
In-Reply-To: <20260731-a9-spisg-v3-1-a15da3f70029@amlogic.com>
X-Cookie: No shirt, no shoes, no service.


--qWk8ktmf4xBbOZ3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 09:08:25AM +0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>=20
> Document the Amlogic A9 SPISG controller and its additional Device Tree
> properties.
>=20
> Add the "amlogic,a9-spisg" compatible string and define the A9-specific
> "amlogic,mo-idle-output" property, which configure the MOSI idle output
> level.

> +  amlogic,mo-idle-output:
> +    description: |
> +      Controls the MOSI output level when the controller is idle.
> +      0 - Drive MOSI low
> +      1 - Drive MOSI high
> +      2 - Follow the last transmitted bit
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 0

This looks like the standard SPI_MOSI_IDLE_{LOW,HIGH} we have in the
kernel, plus one new option.  Usually the client driver would control
this.  Why do something different here?

--qWk8ktmf4xBbOZ3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmptJtQACgkQJNaLcl1U
h9A3qQf/X4NBWrjUXdjd5pQUpvotXq++6lKv73KQ1S09OkFsnDohDY0i/0KYiioM
EmC+GEO0NlyJjgcV21jaWiqqgGtpP0ApoNbt/gw4UgU6KPSzVUTgNGa+1z9WfuzP
2xHyPwI+OcRdVA1XrvlX81jRAM07NFiZFUY07KEL4A6xxXnIhDsA+3UDHIvJ7w3S
x6PiApjV/07YkDYA329ke6gKW4JuRzjlhjjvUZ7qUUS7luKD7P9bgzZi/GWhw8Li
AAGQpM9deg0TcO0WeKDrIEZgxwCXKet1Za+iKoMBUiFKdQpD49FPYuFvKYetWjoz
y1BPChJzQRvvK/awXFouQBzf3mqnNw==
=Dttr
-----END PGP SIGNATURE-----

--qWk8ktmf4xBbOZ3h--
