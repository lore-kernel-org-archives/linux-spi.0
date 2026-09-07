Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E791DB92C;
	Mon,  7 Sep 2026 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803724; cv=none; b=OvzorxwZjLAzA8c3nXhswgtQBnPM/0N8iYHSF0o0jVuA4JAo7w8ledLY5S9GKVD2H2iWHYFwAZVLBwDa1K2vk4pY9+vBWWx5AET1KvgUst4k7gUATD1L0mkGshupYqm/qB/jQxnYhjoKqyDhNuA7CplRNdORX4/QYBhEfucRdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803724; c=relaxed/simple;
	bh=huMcG0o28dujEbJ1tdSTmTg5VDxN0/FcYXM4+rca4bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFIA8MN/U9tb0TGzKOpy8Ab8cvx1as0vIZgVUJ0uDYj5UcIW+d9cQ18t/qUpMAc+8wdqH5XCACKWZGCe1/3oJ4jrp4XjCQHkHAtPLBrGC/N0c5hSru1Cix/ohZXIWJmjJ24VCrHRLCygBuk8as4ELxhpzU1umuLunr6C4c8oLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKN64uk/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKN64uk/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4B81F00A3A;
	Mon,  7 Sep 2026 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803723;
	bh=huMcG0o28dujEbJ1tdSTmTg5VDxN0/FcYXM4+rca4bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKN64uk/wYAGT3JfcBa2PdhXCIOwnK41pd3f/LAbGxWnlfeRslZ1S8QdkDhJ0mUvQ
	 mpSZWZImQIzqrXqeljoowxH1GDarEA0fF829GriJIanqFGbKnTbIhHgKRZNjKKlV/F
	 R8LoaL5SHQ0jTnXNRAh0KEZlIaQtO4WCG0zS8zu70x0pWNLkpw3FFLNGEcINXVL7DJ
	 KHgI/ortFfwR6Gm/SL9hCxGvpqCihQEbc9twboTTMqLBp1dew4t0izCnW+EmtR0BJ+
	 HHVHVai1HnGyMRwJS5U27443ilcUjDYTha3cPKSM8WG1Be5qnVD/bMMnRg9EJd273M
	 vr+fLcu75+22w==
Date: Mon, 7 Sep 2026 18:55:16 +0100
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
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 05/10] spi: dt-bindings: snps,dw-apb-ssi: Add
 compatible for UltraRISC DP1000 SoC
Message-ID: <20260907-swarm-tipped-1ced3b29aeb0@spud>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
 <20260907-ultrarisc-dts-v2-5-5eb4c97477c5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DXYn/o3Hfo5bTITl"
Content-Disposition: inline
In-Reply-To: <20260907-ultrarisc-dts-v2-5-5eb4c97477c5@ultrarisc.com>

--DXYn/o3Hfo5bTITl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--DXYn/o3Hfo5bTITl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap76hAAKCRB4tDGHoIJi
0kfBAPoC5wZaISLp5Yx3SsPADTEU9Xy/OV/PXUZM7irbbrji+AEAsd6cByxKmMur
XzjS9K+pTyv/kLxw1tytrxzGV+7Wiwc=
=LNh0
-----END PGP SIGNATURE-----

--DXYn/o3Hfo5bTITl--
