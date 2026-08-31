Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584783624B8;
	Mon, 31 Aug 2026 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211643; cv=none; b=UJZLAysjn3yEsu8xROSZZlDFHYc+2LS6axtYWqCc3gxLdWXZFysknThzD3lMWhpC/SGabTu5hPS9olNd+zQRHgOly/YY3pdFz0S8Q3S01Gp/nOAKAOyh2QxoFMCzHURTWjfI1tcZf3R2MIQCtiX9PtiHEaYhqeNNz5fO8p9HwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211643; c=relaxed/simple;
	bh=UWkAB/0UN0jAczMe5AfSqL0s1dlXiU0QWMONLCr0qvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wum9iAuT0peKd7s2ZWJek6/SWOIfwF7iZYkQIS3mJxXHNrwRnJ96wG0Hpi6ONMWV+aUx9o3iIVhsLjeGedMTLJLzvD0MVa2fkhubyITcqndS+vvVXaSeR/Frg31ehbI2vX7PtTbLRlpgvHdP3O/v79O6RdCxj6UhqNJDGIZxAQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Wg3vRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Wg3vRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A7B1F000E9;
	Mon, 31 Aug 2026 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211641;
	bh=UWkAB/0UN0jAczMe5AfSqL0s1dlXiU0QWMONLCr0qvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B5Wg3vRFGUo/ZoMi0Kd9Mepopts3nZTxI9uo7amXP04TaiWeNf9eDNLC4CyNIlO01
	 Jr883+5+GPQ9HhKM/TaroYUonHwy4Ok6GcinzJznQEeLkRlpewaXwfivVhiTW9U/Mq
	 Il76JpGMDjl37kEOvVRN0uBpp46GqKnx0zAAv93tUSeGcpKlaOJcugX0zpJ+QhlElM
	 s6p4S3wckoXM0VPhh5+tfCAOSuoiZ8OafEGWcbxg9EEzN6dlrTfGsboCwxX86argFz
	 HRMTWQNva1hq2bjmlEl4q16uN5PGThW/1wMTTPnyrBZIRtQiZOHB3+lvU8kkfSVjwM
	 qfiyp9r3K7J2w==
Date: Mon, 31 Aug 2026 22:27:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
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
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 06/12] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for UltraRISC DP1000 SoC
Message-ID: <9bd5a17a-43a8-4e3b-bd12-ddde9265c2f0@sirena.org.uk>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q+7g5Wbpwns/c8Jq"
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-6-61ab7aebe9e5@ultrarisc.com>
X-Cookie: Chocolate chip.


--q+7g5Wbpwns/c8Jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2026 at 01:54:19PM +0800, Jia Wang wrote:
> Add the SoC-specific compatible string and use the generic one as fallback
> for the UltraRISC DP1000 SPI controller.

This doesn't apply against current code, please check and resend.

--q+7g5Wbpwns/c8Jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqV8bAACgkQJNaLcl1U
h9DI8wf/eSvMfTYF0nSWOpBbx64lahzK6gdu0QfgliH0pyXLXPkDKM/MJk8BN5Mn
h1/EIUG8xEEzzOTWbycIU1gyEVN1BSPELOL8mSJJg+5YS4SCKHjPLUvzHJUb+Tiv
I41ubInBfOHEb15rEuP04UQovZYMvLCr/Grw4crXMM/hZW5RjdT48QhaltrjdbNT
UOhg1ybDz4UzhD9ys7VACQ+U/cjjhbNezZZR4PaUST3pbURHoE9WFpohUbBhK5xT
esoGPKe+DYO0LkRQ+SGGTekeE0q5hhwDGNp5F2rqqoz/8jUv5/iFlNsmUGvJQQAR
0/8l/S9EqYMPbSKL1NQDqYdfFKPZQQ==
=u+gt
-----END PGP SIGNATURE-----

--q+7g5Wbpwns/c8Jq--
