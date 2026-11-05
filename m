Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872411;
	b=UIijqkr37gagRI1krZ2aCk8UsA2r8HpZP0+WliNbnssWvuMcqgMZmZRkydC+s0C5evRs
	 9uXd06ImX0vo6XCjBdj4i7mQoq//8Ps/u6i1B5dJ8OXcBUu4KVjDoJo1ruSEhNT55K2aO
	 Q5RcNuS2d0Bejl46ubhIibDXpJ3+SsWlm+0jxEupSH5DjOCDer5BlznDaGC7Noc2w32Iv
	 fxM3LE62naxxFcLiBswDSp2HCizsvx1U+Wq5aCm+F/srHscGO1oi0O/Ewrf021u9I7pf9
	 bhWQxrkut/+AC4PomEvWTR6MPXAzldSUSyEUue7W5094TT6ya5Edg/I58Tk9Q7KJ2gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872411;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=MqP9VAl2M+HKyxx6eNykqH5O6VAgeEFbQ04dXIcL6Fo=;
	b=be5ZUFDH4KOm7jD5rMVN9qrNMmQbKWHgT8BCQychXo+5BEWs3B5T/BW6wgy9uotwzNrp
	 O9Ui310mhKkfkV75U7/TjQ1Z5pGjAqqmJkNppduHYljWi/nmK7m/qx70XVbAtFCawK3Nr
	 dKHh3U/QulKrkPFvxiWeBUR/tCFmNUrGs7JddP94yYSiv4uTcF+VWkZBdjpPxEO8lZqPk
	 jHLrs0iWFtilyd9z6ERBpajIksI2Qmbz2ybt0PB/w3a9/9R15brNdfFqTGq2JC3w2xeE2
	 sAYc2Ky8YW3d008Shb6BQuaOSPv1e6BEJ8JanNHvG/5+8wMDGnAbRxOnqclFNHt7B4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0M+GuEew;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F17A606A329;
	Thu,  5 Nov 2026 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F17A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=0M+GuEew
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MqP9VAl2M+HKyxx6eNykqH5O6VAgeEFbQ04dXIcL6Fo=; b=0M+GuEewUIj5GPHIXeBPBAoW3i
	zXgPfn+4LRyxdrZX5AnFP0236jDmDcidoXjDIeK5la4bnSWlwP/aZUzh9u1vohdQc4sRqo5M9FiTZ
	XsKFcdvzK7qt8QEdsQSylM11AZnu4iPDITkQcjUn4zfIfcds/OLMyweROsbCE3fQAk1jwgK8PO7GC
	r/MMyfZXSnibjvKjuIl8o5UMF1xPT+WnfymrPAY8YvXlVRSPCk8iEnYhtKgHuTwij4n4Cfw4THGOi
	/JXgecGtiDWVrFC7I7GPBbxIJf/5GkIcvvbxDrRFBoSJ0R4DwsK1IZQlgJFaEAyXpaPB2c3cJR+sS
	7ddGpAsA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Mark Brown <broonie@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
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
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Andi Shyti <andi.shyti@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
 "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 "open list:RENESAS RZ/V2H(P) RSPI DRIVER"
 <linux-renesas-soc@vger.kernel.org>,
 "open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
 "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
Date: Thu, 05 Nov 2026 10:52:38 +0100
Message-ID: <2154003.0S5aU1g85B@diego>
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 2. November 2026, 18:39:58 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Frank.Li@oss.nxp.com:
> From: Frank Li <Frank.Li@nxp.com>
>=20
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
>=20
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

[...]

> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 1a81fd94b4396..f8d6cea2f3dad 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -475,8 +475,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_s=
pi *rs,
>  		if (!rxdesc)
>  			return -EINVAL;
> =20
> -		rxdesc->callback =3D rockchip_spi_dma_rxcb;
> -		rxdesc->callback_param =3D ctlr;
> +		dmaengine_desc_set_callback(rxdesc, rockchip_spi_dma_rxcb, NULL, ctlr);
>  	}
> =20
>  	txdesc =3D NULL;
> @@ -500,8 +499,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_s=
pi *rs,
>  			return -EINVAL;
>  		}
> =20
> -		txdesc->callback =3D rockchip_spi_dma_txcb;
> -		txdesc->callback_param =3D ctlr;
> +		dmaengine_desc_set_callback(txdesc, rockchip_spi_dma_txcb, NULL, ctlr);
>  	}
> =20
>  	/* rx must be started before tx due to spi instinct */

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


