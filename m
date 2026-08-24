Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC473612F6;
	Mon, 24 Aug 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591748; cv=none; b=gYEFUp7fjoK6hggCB0qUUrYIweu61TXWySY2mMF/btIg067Vuu2jaKJZb9zDvZCYQvX/daHOzaMHl8E8WLOxWdMem+UIHMwBovrBkcRb4vE6S8jX6JmjMUdHwH2NBnez1NgJL+QpBlViLQynfm8fueSCCA/2kFPJ24YQDnTkW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591748; c=relaxed/simple;
	bh=y+jQX8iGRF9zxf6ir3GlAbpF8oS/QWr64Rgn2fFb4dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trWbyaEI/b7Yws6RWslGGjwkWbaEZME27tpjkiyLhYnx/M8gHdp/fXbIa3joeIjMvPtNvM4Q4HizN6uYHzWSgkzJ1QtGvC8/Nj6XYKZkZ82n1H26Emfqi5tAirBMb/5VBOWROAl4BQwkdUEpucT5Bsqrw6qBO15hF+nMPoQeoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdNQ8vrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdNQ8vrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FD11F00A3D;
	Mon, 24 Aug 2026 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591746;
	bh=y+jQX8iGRF9zxf6ir3GlAbpF8oS/QWr64Rgn2fFb4dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HdNQ8vrf6bbX9kg++osOlIuhRkGzl1huo6GemVtdEsLNe13NkqR6OSfJ5J6RFFoQO
	 dmUck/jnjUFx0/OmXjwnc+Up2+F146tOEbjxdDqx8deTpTTgTh5AuF3mDjxxjnDgrF
	 c81HjWpCgQvVjL6L4rypxwXax+N0mAWKr1t/Bz88QeXhywnbFSm+XbyAUOsJE4wgcr
	 4ApnvUCQ6wxi/3t4cohzX9DixnNALwWjHEcPA4Zs28PIBXuQjA8S63VHThbWdITYEz
	 rQyAL5zHK2bcSx7DCOhISBBE7ct4RdMLDBMdCBYxFZxMclPHYmVO0LvNHf4BrXmTHp
	 Rr/MSyZXnS8MQ==
Date: Mon, 24 Aug 2026 18:15:38 +0100
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
Subject: Re: [PATCH 06/12] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for UltraRISC DP1000 SoC
Message-ID: <20260824-slouchy-displace-c3f65dd5a2d1@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
 <20260824-paycheck-luridness-6de48a00a262@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pBly7SlyXFqOWhxZ"
Content-Disposition: inline
In-Reply-To: <20260824-paycheck-luridness-6de48a00a262@spud>

--pBly7SlyXFqOWhxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2026 at 06:07:07PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

And another case of being too hasty, same applies here. Please add some
constraints for your device.

Thanks,
Conor.

--pBly7SlyXFqOWhxZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaox8OgAKCRB4tDGHoIJi
0rQOAP9moZE+lJgb6oPgBgEZd/NnXh2mbJQ9JlBisNmCK3ELmQD9ErE+hEzGQnqF
m3Uv3/60n8UWdGer9coC71vchvgwIAk=
=w9lH
-----END PGP SIGNATURE-----

--pBly7SlyXFqOWhxZ--
