Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB3446C5;
	Sat,  8 Aug 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206703; cv=none; b=SZeQD9D66BcYw7xDbQ9G7KQMTGjCPrDBK8jwdhesrwMO2XGMtHCD01viaNxlifDy0HabwkFPEBeoVSdhdO6LITnESQCJeRExiGBnW+0+1yIGqopGiZFMdYgnpF9MbCEu3z5e53p6VVTScqFUpNraDc5hWcvImU8FOTJNK5VXzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206703; c=relaxed/simple;
	bh=1W7Ikmw+mcyDANW1o+zmoWCA7jcGFUDxDCr2BHfT2tc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ibKdaMwg/fH/0uQAbUKnDwV5yfckSzQMvXRZzWk2nwVOaiua/pUm1SZsf1uvK5hX9eJAZFLv/m4QFufuxIKSfr1j+68llgiIwEPTA/zAfKfe1w/O4ElWF9zIzjsEao9C5fNhXK5DL6IBHH0HjYpvJeFOMyrx0+33gC5mMEEHyAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1ok0QCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1ok0QCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70861F000E9;
	Sat,  8 Aug 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786206701;
	bh=J5S+l6GM19vkMm5WS7hjIfdoHf3m4pX/xrtK8b+09yA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Q1ok0QCObu/s9ydyE6PoO6ZJ4zwS/u3wD6ryAUqXh+bu4MGJFUKvH1ynb7SEjgN4y
	 kvY8PA8T2ZPECDuk8CjADyx+rkY4ozlE5fOOpxtjTNZPGRcCvAWSkp6zmCN5J+kUhY
	 NkZbOjRifnmYQJM7dFx3haibrrNmID0K73HO4SljkYQdSXyv13YWrR8pq4f/2aq/Qt
	 NHhHc4Vwa7EVCOlW4vmSaxpmEp2EBL3NaCYPvRRD7kRy365L6KIDX6h8PxEv3c1QSS
	 3IRfgd/Gm1aYvObNNB+qdV4E+gAJtwD8FZJvnh2xW9Ex9BLjn+u9ApiLs7wT67wRPf
	 U5yXOkpEYFSvQ==
From: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu_nicolae.pirea@upb.ro>, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Swark Yang <syang@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Jonas Gorski <jonas.gorski@gmail.com>, Anand Gore <anand.gore@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Linus Walleij <linusw@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Li-hao Kuo <lhjeff911@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Michal Simek <michal.simek@amd.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260803142003.12857-1-jszhang@kernel.org>
References: <20260803142003.12857-1-jszhang@kernel.org>
Subject: Re: [PATCH 00/39] spi: use modern PM macros
Message-Id: <178612554109.577435.7904899828387218089.b4-ty@b4>
Date: Fri, 07 Aug 2026 18:59:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5322; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1W7Ikmw+mcyDANW1o+zmoWCA7jcGFUDxDCr2BHfT2tc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqd1nkZnfRUh8nVuZMZXD465QV2q3LqXoVgPIhW
 MvHqjamU8OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCandZ5AAKCRAk1otyXVSH
 0P1uB/9jnzV650I4/jzvQgPSHCQCTaARpi2Ew3tircctgQrlDLLS9HNe6Vj1tSQfZf8hZEE9Wdo
 y9FSquVw/Sozc1GhEG9mqid3BC2j27lwU/O4Nqp+wkkwDManvDk73GvmHV/Ou8HvXhLALk1YL2L
 0/3gYA9SkHyTUj4nCGuAYZnAK2AQJtLwA40Txlg+Smb+ddh4BqQ16Nh0QRWTB+FEbr7AtzDmtfU
 5z8vC8lTSxIvHKTJQrNN+sUXrJ40xVp035PzhZyg7FkfcMx+l5HS22MAdfiLRI6my0vvU4fhGi8
 //LuV87NNXKpVlyMiN6DvlgSxMBCoC+bU6zHiPkvt4PoGNMt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 03 Aug 2026 22:19:24 +0800, Jisheng Zhang wrote:
> spi: use modern PM macros
> 
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards or
> __maybe_unused.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[01/39] spi: atmel-quadspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/c4a452dd40aa
[02/39] spi: amlogic-spifc-a1: use modern PM macros
        https://git.kernel.org/broonie/spi/c/6fe48b995296
[03/39] spi: at91-usart: use modern PM macros
        https://git.kernel.org/broonie/spi/c/363557bf4d1f
[04/39] spi: axiado: use modern PM macros
        https://git.kernel.org/broonie/spi/c/a7fe79fd31d5
[05/39] spi: bcm-qspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/6062e0f2045e
[06/39] spi: bcm63xx-hsspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/408ba1d06ee1
[07/39] spi: bcmbca-hsspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/f95bf30ed173
[08/39] spi: cadence: use modern PM macros
        https://git.kernel.org/broonie/spi/c/1e64a0671159
[09/39] spi: coldfire-qspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/7975bfcf50dd
[10/39] spi: dln2: use modern PM macros
        https://git.kernel.org/broonie/spi/c/a0b764e3ec76
[11/39] spi: dw-pci: use modern PM macros
        https://git.kernel.org/broonie/spi/c/65172b5d381a
[12/39] spi: spi-fsl-dspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/cda6ef242a6f
[13/39] spi: fsl-espi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/4669d74be689
[14/39] spi: fsl-lpspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/4f6d93537f01
[15/39] spi: qcom-geni: use modern PM macros
        https://git.kernel.org/broonie/spi/c/527adbf1a193
[16/39] spi: img-spfi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/88672e90a945
[17/39] spi: loongson: use modern PM macros
        https://git.kernel.org/broonie/spi/c/8de18aced458
[18/39] spi: meson-spifc: use modern PM macros
        https://git.kernel.org/broonie/spi/c/aceceea2a44a
[19/39] spi: mt65xx: use modern PM macros
        https://git.kernel.org/broonie/spi/c/06f9d950cb4c
[20/39] spi: mtk-nor: use modern PM macros
        https://git.kernel.org/broonie/spi/c/fcb6a6e73e58
[21/39] spi: mxic: use modern PM macros
        https://git.kernel.org/broonie/spi/c/169d9f0fd984
[22/39] spi: omap2-mcspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/aa9d02583a91
[23/39] spi: orion: use modern PM macros
        https://git.kernel.org/broonie/spi/c/4fbaf6e6f112
[24/39] spi: pl022: use modern PM macros
        https://git.kernel.org/broonie/spi/c/9329021dcb44
[25/39] spi: spi-qcom-qspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/498e32cba465
[26/39] spi: qup: use modern PM macros
        https://git.kernel.org/broonie/spi/c/d87ae277834d
[27/39] spi: rockchip-sfc: use modern PM macros
        https://git.kernel.org/broonie/spi/c/07d3854aded4
[28/39] spi: rockchip: use modern PM macros
        https://git.kernel.org/broonie/spi/c/c88fb9432198
[29/39] spi: s3c64xx: use modern PM macros
        https://git.kernel.org/broonie/spi/c/1c892a2f00a7
[30/39] spi: slave-mt27xx: use modern PM macros
        https://git.kernel.org/broonie/spi/c/abc34022d658
[31/39] spi: sprd: use modern PM macros
        https://git.kernel.org/broonie/spi/c/96e9434dee1d
[32/39] spi: sunplus-sp7021: use modern PM macros
        https://git.kernel.org/broonie/spi/c/3c71dabf596a
[33/39] spi: syncuacer: use modern PM macros
        https://git.kernel.org/broonie/spi/c/7bf07ac9be73
[34/39] spi: tegra114: use modern PM macros
        https://git.kernel.org/broonie/spi/c/46aec256a5f0
[35/39] spi: tegra20-sflash: use modern PM macros
        https://git.kernel.org/broonie/spi/c/f4bc18af3b3c
[36/39] spi: tegra20-slink: use modern PM macros
        https://git.kernel.org/broonie/spi/c/355848a0f90a
[37/39] spi: tegra210-quad: use modern PM macros
        https://git.kernel.org/broonie/spi/c/e3f3d046f3f6
[38/39] spi: topcliff-pch: use modern PM macros
        https://git.kernel.org/broonie/spi/c/2dae40e9dcfb
[39/39] spi: zynqmp-gqspi: use modern PM macros
        https://git.kernel.org/broonie/spi/c/bec2ec4186d0

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

