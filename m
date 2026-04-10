Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2480323EA92;
	Fri, 10 Apr 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838555; cv=none; b=CMumYtV3F9qlWex6mrfVh2opLmh3hT0XkCZt6FaKGi34X2UXuuLtO6nHTB/upgneiq5U7+I1d16Lkf1dzXYUDieR/E3hsRS5SaYLqRyUXHxGD573pmumO2izWE5LAAXtef7+/Tc/m8wUkJ6nVwgB2Uqk7gXHh9Vzzc1P4YEMtMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838555; c=relaxed/simple;
	bh=26fwHxNpki+Ob6d6WUjt8WD1LrAPhSIiSMk6soO6pPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AWuLSqLM3BE7hdqQXEw9zSjlaFcR9iOTUhnPqdH9JJeZnMktpksuvG2NVY94eU0ABlFq15DL31erEQsT7cMRLFVa/+NC9MpVBSn6J2MfVVdZ4Plf5zMbb330e4Gwz752mjBvBvhJ2jKYGnHvwLOuGZGjJA1SNbNDtw7F2A71KaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+1BwHRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+1BwHRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B19BC19421;
	Fri, 10 Apr 2026 16:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838554;
	bh=26fwHxNpki+Ob6d6WUjt8WD1LrAPhSIiSMk6soO6pPw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L+1BwHRmdkqMdRXThRBPP2H3fSRw2CYzAJXDx8p0QbgKfl72NrQyRrA/f8dP6qzu4
	 KJyrT0RfGL4JQhhYDzc56+McluvJ0Heis3RSwhkj4v9bjXWVabsNpdNRQz3ccgWHUN
	 bBLdAskOEHOhcQuEdxmQBVIclEAzQKlDRVpzvMmqiO9Vi3lmqZIlZvfqNvFsMT06yM
	 AyZc3pDbjPoyR/eHUZwFqVfYlACiqFxd2H+rfYa6YUXUn1H+Z9rxx4z+ofb4FnF9mk
	 Yor1KbtPoEgp4HlJub5lgU3c9UmFKikZWi+2P4oj+1isjRBfO9RzP0V9eE7OTQ0NHJ
	 mn8zOp3DyMYJg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260410081757.503099-1-johan@kernel.org>
References: <20260410081757.503099-1-johan@kernel.org>
Subject: Re: [PATCH 00/26] spi: fix controller deregistration (part 2/2)
Message-Id: <177582380289.1175120.17653231953714258947.b4-ty@b4>
Date: Fri, 10 Apr 2026 13:23:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4523; i=broonie@kernel.org;
 h=from:subject:message-id; bh=26fwHxNpki+Ob6d6WUjt8WD1LrAPhSIiSMk6soO6pPw=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsybqiEWecfags2tv/PNmjEtvdktT+EHw4mNizJndN6rD
 DBtE7boZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAm0jWd/Z9iSipbRnGP9pEF
 lndTu+NvGzUrh837zR4SfO1hPGeekqTerr1zbp25Wq725M+SxIXfBdsvMbupvKp8F7nuiMWBNWv
 /bEyOSJdYVT0nNnIvf7TiJsn6pSc91k1mjxJfpv2aceHVS/f2cPRwLtnZvMt64vIv05aUFcn4JC
 6zbc/TfR7GVxZy/XXYlxe2unxf6rou7Vz58n7Rh+7E/stvWS/vCZJJD4+4+LrRQKLyA4c054/IJ
 TscZI3ce38dl3t1bvo8XvEPSnwqqco89wVcRer1eHU4ecNUZnDw55wpXs+Yn6zodKcoyzWOy+ap
 W+/TyF2nUo+dFN2u2n5ix35xIzvpvAXd+lzNVirR4S6bAQ==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 10 Apr 2026 10:17:30 +0200, Johan Hovold wrote:
> spi: fix controller deregistration (part 2/2)
> 
> Device managed registration generally only works if all involved
> resources are managed as otherwise resources may be disabled or freed
> while they are still in use.
> 
> This series fixes the SPI controller drivers that get this wrong by
> disabling resources such as clocks, DMA and interrupts while the
> controller (and its devices) are still registered, which can lead to
> issues like system errors due to unclocked accesses, NULL-pointer
> dereferences, hangs or just prevent SPI device drivers from doing I/O
> during during deregistration (e.g. to power down devices).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[01/26] spi: mt65xx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/2ad30599cccc
[02/26] spi: mtk-nor: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/76336f249346
[03/26] spi: mxs: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/8b0d0011af20
[04/26] spi: npcm-pspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/ebd81199e00e
[05/26] spi: omap2-mcspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/fb45f95c377e
[06/26] spi: pic32: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/6b627bfe0c44
[07/26] spi: pic32-sqi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/420df79d1a61
[08/26] spi: pl022: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/994b33366be9
[09/26] spi: qup: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/443e3a0005a4
[10/26] spi: rspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/9944fa6726af
[11/26] spi: s3c64xx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/c1446b61e472
[12/26] spi: sh-hspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/e63982e6392e
[13/26] spi: sh-msiof: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/45170f67a08b
[14/26] spi: sifive: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/0f25236694a2
[15/26] spi: slave-mt27xx: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/ab840cbda4fe
[16/26] spi: sprd: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/123d17dbc5f0
[17/26] spi: st-ssc4: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/19857374010d
[18/26] spi: sun4i: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/42108a2f03e0
[19/26] spi: sun6i: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/d874a1c33aee
[20/26] spi: syncuacer: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/75d849c3452e
[21/26] spi: tegra114: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/9c9c27ff2058
[22/26] spi: tegra20-sflash: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/ad7310e98332
[23/26] spi: ti-qspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/0c18a1bacbb1
[24/26] spi: uniphier: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/0245435f7772
[25/26] spi: zynqmp-gqspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/6895fc4faafc
[26/26] spi: zynq-qspi: fix controller deregistration
        https://git.kernel.org/broonie/spi/c/c9c012706c9f

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

