Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543881;
	b=tfukFqVHLS9e/hsV2OtczDu72TaOVhnyG6FFVBOQsXog5RwZmVIU4vp+/U/yJyqNvMAj
	 tAHrsZMNBhZz+5mX4ujcIdpvHW66acMQiPrHlXz7LRcov0yaykT6GmsxzxsmPOCY1Joep
	 XPWJRblVZql/RC+6hr8qqG0ncXl8LmAMYzoWAt2QldTd4rEOOWHCrVYKprOQZOnlabMJV
	 SW4FIozuZYvBGxtC5gsrM6JixtZmhozbXneFA7VDPvaq+/0symcSbI9GQyooWNB6nM5HU
	 +Yw+Mglmx/DnC9ANL7TFunWGBPfYhh9/IsHJcK4eqqr7D3RMhimJ1lVbNrrSBi3iW2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543881;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jDF6SVwXBWVs6LXBLUGTk3dw8465AnPR8YTWvsMv24s=;
	b=HmlQAtgi33i8f+7sOQeK5xdd4OjftnDqaF9Hyo1vhwXNeZawl7uzQOhD4xklQ0asEO/F
	 irwTsVzuGGgA1AcEsgBOW3CONLXlsNO37sxtDhtPCpaDN5QvK+a6frQIn5IYwyjRALryI
	 AOiLqqXhxRZVwORoX1khtxrPBwpbSnEL0uJnbYe0Av1Lt1w/YUsO/8TgOtma94Wqg+EyI
	 hveEVfAYhlcqxycNdXkWGk4iXwQ6gjs7shxbAwPIyrRePe9oFdMOR9uLhukjPy2+zNNkZ
	 +T0cVTU3zkSNq267Rbl2OiqpjvJMUGy9SsVPNQuJE9vifPfVBz600BCwHFsVr3tuWWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxJnB7pn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DB606A336;
	Tue, 24 Nov 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VxJnB7pn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457F71F000C6;
	Tue, 24 Nov 2026 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543880;
	bh=jDF6SVwXBWVs6LXBLUGTk3dw8465AnPR8YTWvsMv24s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VxJnB7pn2uJDPmIRq5CXEOYjHLjoU8r0rd7m5nbJuHedoyyz3zu/Vwj+4T0uXX5CS
	 830gIU3m8Hw8lkL5ZkpydRIMBLZrnEwLQlj9TiVCQmixnWiQrvNYDzTNk20T/sHLCd
	 eCYerWIDLO0WgDVrGxbPxLmMemI2Ys9I17BjOq8SqNBO0+rr6BF5kdIQzDkZAri/uy
	 4UXvpbDZEIKGP1uz5OSqetn1cbIB2U0QJiKnMRiPee4RpfQ24Nu8Hw+BAeG8dyvgw1
	 EFynP8ePISDIST+f6J5UEstkmCgPD8I0EZBXlexLTePYAJYT7RfAUKA+vBi6mPvdYt
	 XVCAcYUhwKkBw==
Date: Tue, 24 Nov 2026 18:11:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com,
	u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] dt-bindings: spi: Document the spi-dqs-not-wired
 property
Message-ID: <20261124-salami-munchkin-c0fc3f6cb6f7@spud>
References: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
 <20261124-winbond-nand-next-phy-tuning-v5-3-261e0e712857@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="E8ZOmwWvrmxJayb7"
Content-Disposition: inline
In-Reply-To: <20261124-winbond-nand-next-phy-tuning-v5-3-261e0e712857@bootlin.com>

--E8ZOmwWvrmxJayb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--E8ZOmwWvrmxJayb7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawXTQgAKCRB4tDGHoIJi
0mBvAP9SUkEgzdz54o5S/UJV2eJ2dfAMeTowAiaSEkcnGCJQoQEAxWGylqJs3azd
gXKj602bGw17GjZ37Swr/cNcw5a1SQA=
=hYiG
-----END PGP SIGNATURE-----

--E8ZOmwWvrmxJayb7--
