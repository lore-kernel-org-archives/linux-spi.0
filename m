Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757630;
	b=sxcpx413zCLkRfb2idleXcIFFtmkyi8EjYN53PZEoknpomYkeGnQr6oYUEokNHgzuXYW
	 a6Qx1tjrFFTz0KqPh4+YYLWl56S1R26ZTa5QkjamaWKA91F/VsT562gTSQpl6HGf2syIm
	 8O4dqh3VPKJuQUmvvMCwWE+l2I1B9BHiQmMH+iXMcnY5vhQbfZbfAGqPqjVK02DfEz3d+
	 /rgw3M7781oJYxxOxFHlttZbyU3plt/jxBPwmi6LNT6IoVZn+HPORUIDpCmmZ2ZdmHOHC
	 JZxYsUrS+nA1UVUSQqx3uLONRO1sXaiB1D3HIz6XasbtumLfTQUo//81y0E3Y4Gbe2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757630;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 Content-Transfer-Encoding:X-Mailer:References:In-Reply-To:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ID6BIMHIs5dozQ7uo2Zz7lMx53/Uma4fVMefg73C8Wc=;
	b=XhXLVmvqLhCf12ASWxmqy0Cby0bukb7pohxMnHON/lmtBA7aHtkSJlZ1jYFRmK4zxT3+
	 xnaeZ3bsZ/pNyv3zep0N5Bp9clOUd4TUjPFMMoBeaZ8Qqe6WZJmx2aJjoi1TkiSJL/M4U
	 EkHB7enc/AxV/Op6nSqCxpfarycZE4LTZikhuiuigP7WW3PDrvrHvrnfmZQOvVVO8P+8H
	 CBnm3ogl2wi8lIFoVCJvrnHbn8zzoCi0S6cFM4tZnT1hNusyEanCkbyGyi5DX93PQPOBF
	 0l+q6uU1Jmd/VV8vPU2RxlDF1xkHRW8OL7HJQrlWJqb4DjUkhcCPpKTM6qB/mppXaCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b="NR6/RAAt";
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A0606A31B;
	Wed,  4 Nov 2026 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A1A0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=NR6/RAAt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793757606;
	bh=ID6BIMHIs5dozQ7uo2Zz7lMx53/Uma4fVMefg73C8Wc=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=NR6/RAAtadCxMT4aZNlWPKRVIcS8Uk+8x0Dzwevvs6B9RgwZ7gNVgfqgw2V6jccY2
	 diZt/zl8uph3tIhysVhM5N/Yu8QvYwWUDPYY1qlQnLcFnuzUtdu8OZw0KH4ezoDL8p
	 E2DgEks2Bd8LbYe+KH6+erZz2fFcbxQrJtZNGXkc=
X-QQ-mid: zesmtpsz9t1793757596tb1b7ee28
X-QQ-Originating-IP: MD06nJQTuVrERiBp4eZOuk/3YdF/RHaLSj82pRQMepc=
Received: from = ( [58.254.68.27])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Nov 2026 09:59:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13434004078560652839
EX-QQ-RecipientCnt: 60
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=491fac0dacb0df51633230a215ca837ce7256ffa833a7a70182b3d999b4d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 04 Nov 2026 09:04:38 +0800
Message-Id: <DMM0TNL4VAOH.JFJQU10EQHE4@linux.spacemit.com>
Cc: <vkoul@kernel.org>
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: <Frank.Li@oss.nxp.com>, "Mark Brown" <broonie@kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Radu Pirea" <radu_nicolae.pirea@upb.ro>, "CL
 Wang" <cl634@andestech.com>, "Ryan Wanner" <ryan.wanner@microchip.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>, "Ray Jui"
 <rjui@broadcom.com>, "Scott Branden" <sbranden@broadcom.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Vladimir Oltean" <olteanv@gmail.com>, "Frank Li" <Frank.Li@nxp.com>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Han Xu"
 <han.xu@nxp.com>, "Haibo Chen" <haibo.chen@nxp.com>, "Linus Walleij"
 <linusw@kernel.org>, "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Daniel Mack" <daniel@zonque.org>, "Haojian Zhuang"
 <haojian.zhuang@gmail.com>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Heiko Stuebner" <heiko@sntech.de>, "Fabrizio Castro"
 <fabrizio.castro.jz@renesas.com>, "Andi Shyti" <andi.shyti@kernel.org>,
 "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Yixun Lan" <dlan@kernel.org>, "Troy
 Mitchell" <troy.mitchell@linux.spacemit.com>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Alain Volmat" <alain.volmat@foss.st.com>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Laxman
 Dewangan" <ldewangan@nvidia.com>, "Thierry Reding"
 <thierry.reding@kernel.org>, "Jonathan Hunter" <jonathanh@nvidia.com>,
 "Sowjanya Komatineni" <skomatineni@nvidia.com>, "Kunihiko Hayashi"
 <hayashi.kunihiko@socionext.com>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>, "moderated
 list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>, "open list"
 <linux-kernel@vger.kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835
 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "open
 list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>, "open list:ARM/QUALCOMM
 MAILING LIST" <linux-arm-msm@vger.kernel.org>, "open list:ARM/Rockchip SoC
 support" <linux-rockchip@lists.infradead.org>, "open list:RENESAS RZ/V2H(P)
 RSPI DRIVER" <linux-renesas-soc@vger.kernel.org>, "open list:SAMSUNG SPI
 DRIVERS" <linux-samsung-soc@vger.kernel.org>, "open list:RISC-V SPACEMIT
 SoC Support" <linux-riscv@lists.infradead.org>, "open list:RISC-V SPACEMIT
 SoC Support" <spacemit@lists.linux.dev>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, "open
 list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, "open
 list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NbUg+6sDJYMNBkr7RPGMw9gJVR1hBVris0TKaVpTaTYyOWUOCid/CZ0e
	ewmMLoQWVMqriHSh05rNNVdhGp6glTGBsIB3pFFM3mry/TO+93T7MjN6tqt53efaBfeREcY
	/Ly5r6Ta8tQUxmke6C6vi4MPyUoVvFFH8t8StiFG9XmwETB8YtfRxQIxHjgKGF1TkFTLv5L
	o/HnpwzC+d+r0zG1wI/tAKXXEyr8jdLcs9nOxOo3I2wQE4scoIJhQNiVI1RfpSxszpEQplk
	0pyO8LpNmYKi/ui9Xe0q0sQDctj+46yJG/E8aMDpWSUy568yzqPWvhUYbtbKL1eoJJQh3dm
	zIvg/Rucg2A9+fzq2dmOq0khzLFZLjZ1nGmEn5OwAYuwzgJHNLuuxnKfmpwq4/LDnWSnwqo
	qXg983HYVporMTDKy/EOrdPKnEjCUtmnyj1BXd8Y1Mcn98ij8yUXgkSJrkMuVL7lGK/TK4y
	rx5R0lvMYOFSrPuSCIrkmLBBted0dcbm/NQp5vyL5N7T7SvVcujByxzQGS1SXFuBN863pQG
	TuZGb3cbsn0C8AqtjHakmCPZDUSwAOkCjxT67NVu58C9akhy7CfaxS8UEl4UQPDwyteyPYP
	m59td7YhzdewAMaoFbKNlptfnba34JQhVXAXfyH3wb9r4BVDXFaiLyzKkgkUraebsJMAQb6
	6md2E45/dylq763+53uqj37YaH6q26GD5rOhdq7RBabsMjO2m4MgWjp5A4nx4sklv8RUj1S
	E1QK03DznZphP2r++0/Qu+DiGe+1Vkg0iizvQaCXA8IJXBE3qaglmmzn9AoQnCo4JtGZVi/
	VJYUE8PaOXtlKEbXci+FW+jKhdzNmhV1hqyjb2dGXGvluSPgTXDJF9Wr9vUXOr2fkXEOvGD
	XmXl0rjJercXo4Q2L8FyYqV3N5wadqT9rrvgMII2x7/HDJnGtmcpGTyXZXGS7UnkES7bdyC
	iAbZ2kwlVo2oKrFmT905C00hoZgjdI2BMnbttGuhcAWeejHqeCcKbXzx6p8dECsLVXLPwel
	BlZ1ywg8NPbo3DyHUU2ZTkUWicB+CDpmuBmZAKa/Gus14OMe+KJlz3Zg3rnYIq7gKlIqA0R
	n+0fQwogXGpz1NhCpf/+hZ4kyfTkYtDRQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

--491fac0dacb0df51633230a215ca837ce7256ffa833a7a70182b3d999b4d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Nov 3, 2026 at 1:39 AM +08, Frank.Li wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
>
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/spi/atmel-quadspi.c       | 3 +--

[...]

>  drivers/spi/spi-spacemit-k1.c     | 3 +--
For spi-spacemit-k1.c:
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--491fac0dacb0df51633230a215ca837ce7256ffa833a7a70182b3d999b4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIYEABYKAC4WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCauqEphAcdHJveUBrZXJu
ZWwub3JnAAoJEJgJ74D5MzQvbm4A/3HANvkYXGwCFgtSV4A5x/SL0RIfjNSYBzhT
PnYB++eVAQDPfgYcXc7pJv333Y0YE7vFp8FUIkC1g+Aqf+cidgd9CA==
=y0Nc
-----END PGP SIGNATURE-----

--491fac0dacb0df51633230a215ca837ce7256ffa833a7a70182b3d999b4d--
