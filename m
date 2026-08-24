Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135745A284;
	Mon, 24 Aug 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589362; cv=none; b=Msck+VpuP/RhyOqCbZYxtArHKzrhVLsz5wRUB5PokUWmmGXv3DhpXSB/1yK93iUnlBl/4thXMp3hHhYxP12DooJ2orv2MMw5s50hbKTZ20aFhjDqrXDyTv1vhQEa6yTfah6I5hHsKLw3/SrwyIajZiGv/NQN7Fii7pgG3ZF3Qvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589362; c=relaxed/simple;
	bh=+ZW1hMJjctBtwALiC5du66462Lu1h+TE1aq1uFtvCzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJGvnfszi7goJFCO9cAtl56pvkd1sVygeOcm36MLz4UmTJ7A6W/+OlR4tZ+939ZWL2uwZs0vmzh1tQZ+7yeNKdH4Sxr6SWQWn2ViCVMAWj5QnKYEs70zLQa1p27ZM/HEgJE+bXQO7ulYEnhfdSegUQR5JflZlGkcwSo7tJEVSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/0tXVws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/0tXVws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7ED1F000E9;
	Mon, 24 Aug 2026 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589361;
	bh=+ZW1hMJjctBtwALiC5du66462Lu1h+TE1aq1uFtvCzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/0tXVwsKq25OehT4aF6oByzoBr+fUQgx8jEPl9VcGEMUgdrDwSA+5eTPy8oG5eZ0
	 0bF4stDY4TtdQ6oY4oFpgEXlbOShy6myLj9OmTIn0IIVoRB8lH4yluP+hpN/lUh/wt
	 VbZ7/YoGWPjVm1OVSz2oWvKe5DwYiMk21moAaFy8CNg8njIbJfCiReY2PMeB35Ezvm
	 bu66QZs1GdSZ2gSFkxu7bmbDaSt8Gkh8ZpaG/4Oxet0EQx31rRgMWuKtuby9X2krqJ
	 W+EemDg7WvgATo8HDfl/YDKzJ2aDTuMhig28BH8syvUH7T+fWR5WHh4vdC7l7WpULX
	 geMzR54f7i0rw==
Date: Mon, 24 Aug 2026 17:35:53 +0100
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
Subject: Re: [PATCH 01/12] dt-bindings: riscv: cpus: Fix yamllint style issues
Message-ID: <20260824-outpost-mandarin-532989726b7d@spud>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-1-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8v5dm5XnVj40MIRJ"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-1-61ab7aebe9e5@ultrarisc.com>

--8v5dm5XnVj40MIRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Or I can take it if needs be.

--8v5dm5XnVj40MIRJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoxy6QAKCRB4tDGHoIJi
0vb9AQDtUF9H8kkJH+6QKRQJH8iwwdaldMbo3HPU6yiA6vWiuwD9H2afICo0iqA0
++arQAoMF3AH3z4DdOsNWb0Fnh+g2gA=
=5zz5
-----END PGP SIGNATURE-----

--8v5dm5XnVj40MIRJ--
