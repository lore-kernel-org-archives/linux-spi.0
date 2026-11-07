Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135845;
	b=M+fUXjCJP3fm/pD48IsCCWa7XztK9ujjYbSHYz+ixqyZSiCJ+i3yxwAfz5kVuUXAdOfB
	 SurF7iOdnrMO2UvamHrEy2GvpcFq8L1jOQVQikP5CsL8W0LmAtRkQJR5S4YylcksKYic3
	 iAnri/eSbUMYqhA1U9MKiCNo/omt7Jdm0PjsHkk+KCRygTsFX2P1aAEE7ymV/KosMopRN
	 iinFZcOikyhmFH0U5i66Ki74kYC81XZxfT1ES903akno9w36akIxhI27QVUaZ2o4wQjnv
	 7Ja/mLlRHIOMzR2msWZY9cDvI9qW7eUYy9vgAsZda7PLR1wW4kv7V6Oxs2UOupcRvjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135845;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NOH9rvmKBnbMuVpOzvlihPh29ou5uq8gMNkmR0u8PDU=;
	b=nJaPo5DwMiFW/hm11rEgfTd8lcXl8eD3z816OROTYoEpOajlV7Fin70/1JXpo0m060xO
	 7ZTHAqnMj6j4q2zyENsffnd1jZUtyhmLyEYwdENDI+bbFC3FqX6f+MZmSrz65HJaA3yxr
	 Q38ZKB5gbtzWASAwNCPSrApKmECZp8Pgf/H4rPghr7aFzGFM5srGLotoHVLflEMYh9aDl
	 a7jtf6TlLoC+aSLNJJfNlbrjnbHNGNB8HVfXxgJMDP2FQjo5Yv4sp6J9htSzLvXjSaQrV
	 QFoEPqcjEcbmo/d3F4Q8z9dEvLjxA+t/C69g/UcZEESF4N9CdguC++b7JIWaRMDi/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEexgGVA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99D606A332;
	Sun,  8 Nov 2026 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEexgGVA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E91F0089F;
	Sun,  8 Nov 2026 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794135845;
	bh=NOH9rvmKBnbMuVpOzvlihPh29ou5uq8gMNkmR0u8PDU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dEexgGVAuXucoF8ixDFMhBHOti4RPHfHMPBIu8ZrG+1LDuvZ9LNT/0RN5xd6p7PDy
	 TDOp68Zoc6KEktnZCGJM+6nzB3TK8l49ElfnK0hEXRmmicbFYo4V8exj/LVm8A2YPS
	 /0VuJACkvM3ROI5CssnA7MVw0H87HKQ3/2wCfWl5qvidILOFgZxUn04Nnq8yMKQxQ9
	 HakXOca2pq4l/4Vpz2OMORvhzRalck+q+IbsiWfjqzktw3kdPX43rcc5LUK9ggcq/R
	 hO0SJpX5J4xrGfiDv2fRvVkI/FevUQCm5mY44Ny4G7bh3St9+n070F650Ak2/vJUKU
	 olkHcTdlwi3ow==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 4426D2BF8D29;
	Sun, 08 Nov 2026 11:04:03 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>, 
 Ryan Wanner <ryan.wanner@microchip.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Heiko Stuebner <heiko@sntech.de>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, 
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thierry Reding <treding@nvidia.com>
In-Reply-To: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Message-Id: <179406311622.3424803.2869752670970173307.b4-ty@b4>
Date: Sat, 07 Nov 2026 14:51:56 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=broonie@kernel.org;
 h=from:subject:message-id; bh=e27pH1DOpyvi3Vl4RSGr4H2h6BdkO4/LpSXv3m1TiX4=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGrwVyOjdTCE9S9OBFZY60d2uXkflutXeLj+hAPbkWGUWWQYj
 Ih1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmrwVyMACgkQL+9zsLPQOInk9AEApusX
 E0SNmJSb6PhRBdjP0Qw+zpKfW7o8VMCTkcooCtUA/ith6wDGE8iMhCBn3VujoltYF1KmR9Xr6Al
 rgHg/wDwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 10:22:45 -0500, Frank.Li@oss.nxp.com wrote:
> spi: use dmaengine_desc_set_callback()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: use dmaengine_desc_set_callback()
      https://git.kernel.org/broonie/spi/c/29fcd5d436c4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

