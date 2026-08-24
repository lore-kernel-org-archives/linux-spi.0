Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6630BB8A;
	Mon, 24 Aug 2026 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591260; cv=none; b=L9rWdFvXo24ClYuWdUDcaPDUo+fOQpd/hJC1ihYKu2Fqew2dL3Z0tkyhic9JQ7fp/Q6Md7UVvLzZG3Kh1eMSzlMRor+NIe4ME2dXH4X2erng7JQOvtrKqPY5Ux0GdsutMvIURmCONEWkmu6hbfMDvr8Gaznx4PpD9LFiS5b4bBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591260; c=relaxed/simple;
	bh=5zzBlRRW+p4N0hvKvXFBc4noB+H2gMROn6oFNdVBBWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5NgEval9mnclF+abl0K9yI9WQ5MVE+ZqYu+BCXSRQO5Yyr/6nnwh14mb5Oe8KItlugWe6z/FiwSyWPZGCZjZojbdXAoYkTQtJXzk+FSSExZN3IXnewKnWCEyvhcvMIOZR9t4T/SnhprdVVMvy/mq1T5OJsAid2zs1C6KwvOCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDjGCzTx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDjGCzTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D241F00A3A;
	Mon, 24 Aug 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591257;
	bh=5zzBlRRW+p4N0hvKvXFBc4noB+H2gMROn6oFNdVBBWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kDjGCzTxIgb8KwapjiPT47fITOVRTacMOC7NJ9ad4fq4DXT7zGRZ6APX89uJwhIjO
	 BBBs6RYmqZlCpHKUncVKfO2Swe92V+mHp7r01TZYB7y5HnDsZSXLSPPr++kenQkYi1
	 uaRH8vzf4y8DtyCfIFdRbsCbkf4+q8m04oSs0NOvsgpUkDsSnUMeOl80OVQ3EY1Pq5
	 HOtphptYpSwbHgItmgncT4ER/oHKNzXeNqU+T5WYOPrJo0PVRjtvqRAr8nqrJ5fO/E
	 XB2xwRznJfsKC7YPzMwQ8DfwXWLjiByb7UYJDqfjqzUcRRWg3O6thsuieywkOwgO9C
	 L3upEpQL2DZXw==
Date: Mon, 24 Aug 2026 18:07:29 +0100
From: Conor Dooley <conor@kernel.org>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 07/12] dt-bindings: i2c: dw: Add compatible for UltraRISC
 DP1000 SoC
Message-ID: <20260824-oppressed-jogging-5b055ca274b1@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-7-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ypjxoWnZgSDokRmL"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-7-61ab7aebe9e5@ultrarisc.com>

--ypjxoWnZgSDokRmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 01:54:20PM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Add the SoC-specific compatible string and use the generic one as fallback
> for the UltraRISC DP1000 I2C controller.
>=20
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--ypjxoWnZgSDokRmL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox6UQAKCRB4tDGHoIJi
0tDgAP4maHyBh0jMjn9z5RCMaYOe0lnbfrGgHf1xQlVCs8SjgwD+KLe1U3wfT4tr
HDrk17RO7KEIAysOIRzo2oG2VbfibwI=
=nYgQ
-----END PGP SIGNATURE-----

--ypjxoWnZgSDokRmL--
