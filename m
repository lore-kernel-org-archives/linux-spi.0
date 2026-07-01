Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88943E4A1
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904622; cv=none; b=YNSrUbt9tRJ5mqxWdaREXw0biDv/MbyVF62C/wpyX9249dUsxiWeg5f0CM7+XTYO9cclZyw5xSX+Rd7t/tEuJvOSlF0/0QMzTAYNO5t54ZzcGgOzuYhsI2hJhTX89oaMrjecdjL693EcgYm/fpbqzMBkLSJ2aUVrdcloX6E6G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904622; c=relaxed/simple;
	bh=Ju6G30nPmVF/JwZK4zThMrqgftJV0nXXCv80BHQAxH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4TPdukVAhy/kYB6LnIBxWou66hTpNNbWTz7zGrheVcXM/vKcqWFgVorEsCtLEjjAs/0+ZqgTSa6ixaVDtj39dMnEheqvQEiAtgpl0owu/BhusNMjVnhxzQRB9s/o71/VrGA2qv+Fc4XMn8HCN/AMbpxe1QcAsWeeZz72Y0hdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HCN5EfcL; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HCN5EfcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ju6G
	30nPmVF/JwZK4zThMrqgftJV0nXXCv80BHQAxH0=; b=HCN5EfcLkITKJVGDJGCF
	T6b1u4EyEGQb7BBeoQr1FK5o+vy+sOZ8zmaV8tJyieIcBNONaFUcGnYlsEa162iu
	o54TzXBJnWL+sXHgT5MfxvDnBqXSX4NRaOu144fu3jWt7EZ5Vp1uVzQWGqEJr6i8
	M5j5opA0QCbbS+6WhQJM8QVOjzerpapI4Zi7PNfiXOhPPPtgZ03prnBHGltB22XC
	NygthqlXNPSGXFJQfe2gMSPMep+zG8xChDhBDh3TDVR9YDsgrqJ7cpwjgPUkqOqU
	jnQMsfRuq2SndbzMJwb1+yFSPdu5frz+e9jQLnqlP67++fv6YdaxTEEbh7Qxh3Y7
	+g==
Received: (qmail 672995 invoked from network); 1 Jul 2026 13:16:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2026 13:16:59 +0200
X-UD-Smtp-Session: l3s3148p1@vMt31IpVLelUhsc0
Date: Wed, 1 Jul 2026 13:16:58 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: snps,dw-apb-ssi: drop
 superfluous RZ/N1 entry
Message-ID: <akT3KiUJccT2bjRn@shikoro>
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
 <20260626180326.9593-2-wsa+renesas@sang-engineering.com>
 <20260630-dazzling-intrepid-lobster-c83db6@quoll>
 <b4a42f27-595b-4c02-a792-0e11c306d2ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SupshW18AQZrgaw3"
Content-Disposition: inline
In-Reply-To: <b4a42f27-595b-4c02-a792-0e11c306d2ea@kernel.org>


--SupshW18AQZrgaw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Uh... the compatible is listed twice (!) and you remove it only one
> instance. That's completely missed in the commit msg. Patch is fine, but
> please be explicit that you remove the variant which should be used as
> fallback while leaving the ABI documented.

Okay, I could have used 'duplicated' instead of 'superfluous' to
make this more obvious. Will reword.


--SupshW18AQZrgaw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmpE9yoACgkQFA3kzBSg
KbZPDA//cEfcjG5ymTzgvGp2vHN41NVqUEM85KtpECI6mgPJcgrmhtjPP2s7xAKk
0kxf8k6xcMp7XBat8hlh2OJbZyibKEMeWp5aKfUZWfGn7J4ys+QK2uf3YEeg6w1k
iC25q/KsmwdVAj1CKGx/QNeMeWoyG5HstDfZSutNoHUHyE/VDF8K+u2jyiNkz0yi
A5wZtc9Q8IPKfkHDhGhHaby3UieaaPdWr1i3Ax0PqSJna0iBL0v+mHQbiJPld320
DguNQDmceeBp0PFznrx34zgbcZj5NJbvBWrzomwiZWLF5/bbBwGPhqk8B7t5jrGC
Bd9jk/pNVlv4gnZbzJq5AZptJEWARYVSTKwEGbWfoZDfTIUIM+9/3TU43BdMWbJ2
uUNsaIreK0KdRvVC9JnRNayAxPIVD+3ag9FTO9gNEoDWXf8w1PxMJr/XUwEmp99i
D69HJZlKWaevCePkPt2uPEG+OpB+oi8fnCAdW4IJzR/5JYPlPA/hAwUZIX+4nTQj
0tvSGINdQV0G9nbgBmYTo48OvP8nz8LOzHb87e5FuU69ROlSJUPqGcrPs1ftnhRk
8q9v6AX4nVSTh27/tBUTZILWNl2fbl0wwG8vp/DnD/VTV/kPGdizanU9UtnBNxe1
5GVFu1cPEjWZNHW3Y6B/asrDa6K3RfF7YcoagQBUNPZ4kmcqj6A=
=e157
-----END PGP SIGNATURE-----

--SupshW18AQZrgaw3--
