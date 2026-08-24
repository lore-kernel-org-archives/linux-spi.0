Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0544C65B;
	Mon, 24 Aug 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591078; cv=none; b=AgRWZ0G7A9nXTh77l1Cu83c5Ohn/6La5puikdnsGFQSRGA7VFjRFINey4jzWZowmtIyZAH8aRR6jdIZfTOvHkHPeQzBt+qcwlpJ16llDciGs8sEKF+BUw0JSqLxVuSk+KoCdtw0xzcTXFuiJIbhV/nRocQ1j4BAPl91b6YK1XsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591078; c=relaxed/simple;
	bh=eOctFNVYXBRARRaVpu4TxCSxy1tNvkqzQ5/ke/gDYtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAkI7ndHy9II23GSbOWsEAA5SKTOq3knNSIwyFoi+8AH4Zbvqn4HQ20F+dQh4ZtlAYGEZUnz4OwqyteOLy6gPfOx130wuEj2mNIlBBu7mvO9TjREBPnowgDnQvuIUewGgZzf4sC/5QLdwYcOoAchJowoJCUGpIYV4SXIZ1SH2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWTQudvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWTQudvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A1F1F000E9;
	Mon, 24 Aug 2026 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591077;
	bh=eOctFNVYXBRARRaVpu4TxCSxy1tNvkqzQ5/ke/gDYtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jWTQudvWK66CYNUzMgjH7VHhX2MsEGzxuubvd4Mm0rGtkMt1E9I+giFyCvSETW2A2
	 AjFCZOTNs/PZt1R3ZLSxKZXkg8bSBCVwDKKeHY+Rw0olkhQdBeIALPIKfXMOQ0njaG
	 QYSqGNaiYNI5OeZOzvJEpOBX2MoRxhvSz++/tLAZ0JojPisBZxsFkqbFLjH2PKNDtM
	 Q1uS2fTogpSwVnWrC7kZaPXhPMdL0/cpQLNbNwYP6bVxj7r9wxSjYqLQyz4czvP+wz
	 JQmtd4nueFDaaBiIxkitejemCLs5GuUA1LwNvpc39r+RTBXPL9dQqZTo+Gou4J31wt
	 fY58JwTs5njHQ==
Date: Mon, 24 Aug 2026 18:04:28 +0100
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
Subject: Re: [PATCH 04/12] dt-bindings: riscv: Add UltraRISC DP1000 board
 compatibles
Message-ID: <20260824-jot-sasquatch-afd27ab7a971@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-4-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BoJl5+mnOUJj8iig"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-4-61ab7aebe9e5@ultrarisc.com>

--BoJl5+mnOUJj8iig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BoJl5+mnOUJj8iig
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox5nAAKCRB4tDGHoIJi
0uZvAP4rzlPBiKn2gNnekoclojDzRT+Vapurk8Q83Eag38mGYQEA1uZjGdEAjsD6
jJXWn0LR/bXUSX0xrmxgHUXKH5TgVgw=
=3wea
-----END PGP SIGNATURE-----

--BoJl5+mnOUJj8iig--
