Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869829;
	b=dhoXeGQ/J40eVBhB9IO/f/8IwduC3Q7b5H+Vm+w5rqJLoK0uI89cQE5zXIVDoCzfgAEt
	 I9rTYv/r/w/tGV3t2O8Pq3OZN+1pUZ8DmPV1atWE1rdZ8U1eREzK76UxJSeJnPoH9nhj4
	 ubFXuS2X58184MB+08/uuEQkouIYV1TYyH9M/X7hI/NbBEveTADH7TIDqVCK6gWz+Iu9J
	 Ot4ajUMQQ2DfYccZmmz01pWm6mbJKmtFsK9ZynK6YDwIY5wX5VLDoC5ZVelmqCQyG1rzN
	 sFImCg/svhp2dhIng41TV/Or28PfXGXyhKs+1cZX2SlT9mUkwG0RDnohzMajlM9IFKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869829;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lN4ECpQjtPYk5YCpT9PbCQCY0iBuhzgsWSuOM5NawH4=;
	b=fph2qUpBQqxnaJZB2ebEg945Yos2edEIWwWrzUYiRkdpAxodl0c/L5PEKIIVDlBHgmvD
	 DnElDFkg2MMCFMxSFXEMb1jtZPOvTqJsk3iiO+7KzbZw59s8XsRLV3F6/3mLNSGavAh0f
	 qGjCG3V4akVg2wGUpzH5mrgqYSlcks9LVf+pX3RZFtlt35rL8Bgpu69KXZZvzdh0AssMT
	 /9y1xYahXy+jyqpPlnLoZDm84ufA/P9HFLxUzo2HDS4VMdxubnZn/g7sf4WWJ/lYPOs78
	 Fd/ylN9xazb/mTtog+BV+EVzookTzY/9yycOD/HhSP6N22GgzC90zjgqwIxObjzcGkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5B606A328
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 09:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C5B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=lN4E
	CpQjtPYk5YCpT9PbCQCY0iBuhzgsWSuOM5NawH4=; b=khLIHCgLpAYKXVm9ar3s
	6uDsYa3Ux3tUADZPDcce06qJMtyAq9c6T3nRwNLf+Ndj1q5p87zncCKSzj+OCOKe
	qlnEq6mSQiKWjZPASXat4Oi/E0zQluTPcIIXHm54nrkXeK28VwoPuG8O3jSqaJ61
	IMAxyp6SSb1+ug/tx4/SkKOqMDtgEAodthumCXAAluUdS7LtpAg3CaJHYGNoagnT
	72bfkmIGXx5U2e1+LTQmY62aXGl7IGN84U18r5EkrGk8MNsV2+qric3xGF+zJ2le
	3IMJT253Iu6LQyLXpatQAYJEoT64yszIgDQJzYWzbASNqjMo8WTk1XTwRKMZ4R78
	KQ==
Received: (qmail 1082151 invoked from network); 5 Nov 2026 10:10:21 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2026 10:10:21 +0100
X-UD-Smtp-Session: l3s3148p1@7tJ13YNf9JjAwtcC
Date: Thu, 5 Nov 2026 11:10:21 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frank.Li@oss.nxp.com, Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	CL Wang <cl634@andestech.com>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
	"open list:RENESAS RZ/V2H(P) RSPI DRIVER" <linux-renesas-soc@vger.kernel.org>,
	"open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/1] spi: use dmaengine_desc_set_callback()
Message-ID: <auxH_WzaOLsQ4-go@shikoro>
References: <20261104152253.3279052-1-Frank.Li@oss.nxp.com>
 <autj6pr_bPaul3w0@ashevche-desk.local>
 <7f96599b-681d-4963-bdda-1274371ac84f@kernel.org>
 <f1fa853d-1703-411d-b2d2-0fb0b176c2fa@kernel.org>
 <autqC143h7Qf1R9H@ashevche-desk.local>
 <9e39502a-dd17-4fa2-98a3-9019523cb5e8@kernel.org>
 <auuYcS7-YqJKcUbE@ashevche-desk.local>
 <63c24437-4261-4a51-be7e-31ac0759a095@kernel.org>
 <auxGom0XR-Hax9b3@ashevche-desk.local>
 <00390a20-7630-4066-9779-06c8f915a176@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00390a20-7630-4066-9779-06c8f915a176@kernel.org>


> > No, (partial) Rb != Ack.
> 
> It is, because there is no partial Rb tag.

Heh, just what I wrote a minute ago in the workflows-thread. The clean
solution is to introduce one. I'd vote for it.

