Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CF4334D8;
	Mon, 24 Aug 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591704; cv=none; b=rty1m6sibWSQw2hSbo41hLXb6plWZBC5WzvMPqqj2vAGNVEbmdsBJYtwpADvT72NMECMgvnrefu+R3Kda+VYfD1cC1zf/Y9Gwjdn1exLmMRVfLwiZgVl06RmRIamf0iuMJ4HfPQ7tfA2XkfJjCetcij1XnzTV/QwXL9YAJCkCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591704; c=relaxed/simple;
	bh=6Sc5Y9vCSGbnpzxV5PcaxCNo/0x15tmyZtQNLFn68Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0ZXyCbEH1LeJ5iNVuw5XsTW7CLfWMZKn2AosWVzukBZTeD0ytsrXRmXCYFLU9OnoxKcFRjfYTye2r5me9P+GivRpPS9G9vPuqNAmeSNOy/WHe15QxnDdyfOITca5r1tL1ua2Lf7bIJUpg9Otp2TnlfeEU7OzokFXPwu+6cnudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhot1lF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhot1lF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F5D1F000E9;
	Mon, 24 Aug 2026 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591702;
	bh=6Sc5Y9vCSGbnpzxV5PcaxCNo/0x15tmyZtQNLFn68Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bhot1lF6tWKfFQjY6mgoobH0Us+PcA8VLqnTpZIXawZaqyOm614zxG3qJt0baUF6W
	 k+jmpqXhcWfmvce8MI2KPylqfYvfRM0/wcZuBtb7IVfBeqYllkGISH07a39ojormNp
	 wPpiS1A2W9NSzQplVM4pbkFVBxQ3yfLpUxJxbaiTElhhX7xo+UTxSgIsGGZk2+pz8c
	 ignWUNVU6gfZgJBlG9ceXQsOyfJarQGF6Lhcma+19uaR/fkEf9kzLue+oigPyKhH1Z
	 kFxmO8Do0/zHKdHIFuEfdidX9aX7RLougmWghGVwHvcuYQYrMtT9WxQCi1XKl9meqc
	 muo/2+4QuEHgw==
Date: Mon, 24 Aug 2026 18:14:54 +0100
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
Message-ID: <20260824-aging-umbilical-8e68cfcea468@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-7-61ab7aebe9e5@ultrarisc.com>
 <20260824-oppressed-jogging-5b055ca274b1@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nYx2eXSGYSMMPrV6"
Content-Disposition: inline
In-Reply-To: <20260824-oppressed-jogging-5b055ca274b1@spud>

--nYx2eXSGYSMMPrV6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 06:07:29PM +0100, Conor Dooley wrote:
> On Mon, Aug 24, 2026 at 01:54:20PM +0800, Jia Wang via B4 Relay wrote:
> > From: Jia Wang <wangjia@ultrarisc.com>
> >=20
> > Add the SoC-specific compatible string and use the generic one as fallb=
ack
> > for the UltraRISC DP1000 I2C controller.
> >=20
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Same here, I was too hasty - please add some constraints like clocks
being required etc.


--nYx2eXSGYSMMPrV6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox8DgAKCRB4tDGHoIJi
0gSyAQCaBIW9bAhXt5j3k7rcMtWvFlse2pAXUaOee4/+801w2wD9H2KW+zz7KzT+
CxJhvXEmTdJV1oOXfYdU7jBei/IjUQI=
=p5ke
-----END PGP SIGNATURE-----

--nYx2eXSGYSMMPrV6--
