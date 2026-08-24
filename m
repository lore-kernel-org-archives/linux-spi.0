Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5E2F1FDE;
	Mon, 24 Aug 2026 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591038; cv=none; b=P6tI3Uw1oF3NNzQ0RfWH74EZW15U0BRu3vt0CMH5W7bfd+dlVq2D3VknuZ5gKTVltGvT/LkY9yBcjrTBJy5SOyGhX7HmnRGS4GYoNWzi2Rd1ggvg6/T0f/JakL5l/+4pgivdaUKlLjAyiRrVmd3xYr3wP1PmD+2bnGAoX2KaVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591038; c=relaxed/simple;
	bh=zx6wtmxEDr87XTfq/xXzxMw3WpxfP3T0Uqne9w4Hlic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBSIHUur67wfzQwzyKhI8wFfwk6Y/CkA+UQBsgX3zh7Ss0gEGSh0TmYxCHE2T6QF0jINuEfu8m1iD8tXGm88wWv4q4az8BgzyHf6fNTLbaFZ2c1aquwLpKXURH2afKiODRprponBwkUx/70Yp21HrkjQByZi5CGRLwAPwubo7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARXBbPjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARXBbPjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523661F000E9;
	Mon, 24 Aug 2026 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591037;
	bh=zx6wtmxEDr87XTfq/xXzxMw3WpxfP3T0Uqne9w4Hlic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ARXBbPjbsXyFXA6jl6HmtNZenFpylqyE06MYLgtJNvhX+BvbR8fbXUKmWElbcv7PC
	 UpWhaPRGDNV5v7NJYgz67y72hzRsrqORGU7EokwpDbwzRE1Ey443vy0crfy6wk7nm2
	 8eCYZVUAll50vj7YEevhuuUuSj/jFjnv9wNNvp2XTp+EjziFI/VKu5Ss/P8BkUmlLJ
	 k2gwI6Sc7uqwTf2qc2kkJ7FE4eKKDcRbh0L4YYTIn2T/QaiF29ARLcSL44gECH8sa5
	 htEqpPNgU4uruk6R7ZHCHtrGFLw1XJttbJlXO75blkcafGnwpKouVbsbsvmRo3MPUk
	 3UMJr4vZs/S/g==
Date: Mon, 24 Aug 2026 18:03:49 +0100
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
Subject: Re: [PATCH 02/12] dt-bindings: vendor-prefixes: Add shenrongda
Message-ID: <20260824-quotable-seventy-87597d24cabb@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-2-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VBbgSIA6PKblOnpl"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-2-61ab7aebe9e5@ultrarisc.com>

--VBbgSIA6PKblOnpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VBbgSIA6PKblOnpl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox5dQAKCRB4tDGHoIJi
0iZiAQCeCX+ycV74wI6lO/DGRbMc0Lct2DjNjwwPxnjzu+eV0gEAqvQWiC9T/47a
gCnhsQ6WaUYzlErQLhp8EkAg+acPmwg=
=M/rF
-----END PGP SIGNATURE-----

--VBbgSIA6PKblOnpl--
