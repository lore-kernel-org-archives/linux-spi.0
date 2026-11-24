Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620198;
	b=j0D8rhouOgRpQOMhc3p0KatZJLGpq75jaqTi6oVkw/9K/79sxT6hLpIZLQ0SAubjJ3w8
	 x5t8aVs1i/cOAnJvDu10ir6b1wTOkJ8dqLXskF1pwSBErqHcOYBrIc6xfg/HD1IgaFRAv
	 TPR32djlaBjHuQUUws9/bBuOr9M5oUYnqVw/pFg8MDEEfA+208ddB+aM23UP8ygHcRhND
	 Ne886VPZe6yV5julT10g1pdFir6oPWR0UFQzhRXOKzyyuxNmkgPYe9dnosJ0MtuS+E7I1
	 R/xNkG3mgxZDJ+BNZA67zH5gm/KM7cPCOINKchpN6uaa/Z8f8+WT1NOpAcidzOCwaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620198;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=uNCx6F0Jb50sazmOSgNSIQP2RpHDiNerOJw/r/EpMcg=;
	b=s/xyh3T/7/M++gi7AhZVJ2NHFEi/6po7ayy+qODMIJjlRM12R1TOlhXU9TijwCdhgoy7
	 n9YQO7H+ar5rHNbyOa2dGaOw9OhPRBQadHVZ+VOYGIS/hz/uqMYeucc5VHDtbfBcstzJ/
	 eQF+N+CaIR+ox9dNNWNYUd9cl7mmIDePT06RsXh7IeQRQvQugwLywSHUskbmX/KWkXkfd
	 AD+4TiA60MZNJT0MFq17f60h+UF7uqrnWUDW+PMR/wAz1WGEkVYZkpRYoFo6aW9FDYaGd
	 iBfIj8bLDg/s+gIcF5CYHsyus9CS1ahq/CpuBRiLWu0WPMBw8kaVDXahnoX1TCIKuaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmjlBZil;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2F1606A327
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kmjlBZil
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8461F000C6;
	Wed, 25 Nov 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620198;
	bh=uNCx6F0Jb50sazmOSgNSIQP2RpHDiNerOJw/r/EpMcg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kmjlBZilBpRLesFyxaHfvlpUsDA53eQMDbSrz0P5ZoSpdl/WEy3QIQPTICnYOLInQ
	 oh0SDdImWewF5vAnS6h/1R7v0rfpdZLX1cpM1S0j+j2R3FCcTSZ6P/7i1b2JBiWDmZ
	 2ATK8TqMSw7z9EvU9exJyjwr+K5MQIAlFC2qJePcdeSVIxtbt4I9KU2+I1jhSp/6I7
	 TATbxIyWdoVJTXeZvhJjDBIy244Nfei/nf65YxGZQUx8BFulyeGYbjBbHGDS6uyykP
	 1don6BG/kIeEzHyZHru26XxDbLlMvpIjF2lOZM5G6u0qmis7rEm9VIxRNBc2atGSG6
	 e5WfeSuLYNECQ==
From: Mark Brown <broonie@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de, 
 Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
Subject: Re: [PATCH v4 0/6] spi: Implement a atomic transfer as a last
 resort
Message-Id: <179554960286.947306.16162137377244301666.b4-ty@b4>
Date: Tue, 24 Nov 2026 19:46:42 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BkRnoZ6dXxdejugLnRSwCT4+Gvx/LKOaQRRGFM8oQfc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLZ/ia3cWf/26wj2uthZiV6J1rtcaB7mNXy9W5T2ef6b
 14pEyvTUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgIn8eMTwP/qcmtKhyz6ydh5J
 Oxv3rrSeez77sqFy64Sfwb+u7TTfbczI8Kl+Yqxpl590/dcLH5+cmpHFzcSieltc7lz3jhTTutC
 rbAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Nov 2026 14:58:02 +0100, Heiko Stuebner wrote:
> spi: Implement a atomic transfer as a last resort
> 
> SPI devices at times are used as PMICs including a power-controller
> functionality that should turn off a system.
> 
> This happens in an atomic context very late during the shutdown, where
> no interrupts are available anymore and conflicts with the asynchronous
> nature of the SPI subsystem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/6] spi: Allow spi_toggle_csgpiod() to get called from atomic contexts
      https://git.kernel.org/broonie/spi/c/bf7dd2bcdb4b
[2/6] spi: Allow spi_delay_exec() to be used from atomic contexts
      https://git.kernel.org/broonie/spi/c/3a54ec9ea89f
[3/6] spi: Export spi_set_cs() function
      https://git.kernel.org/broonie/spi/c/a26e42ee67cb
[4/6] spi: Add infrastructure for atomic sync transfers
      https://git.kernel.org/broonie/spi/c/4ab1c64f3f04
[5/6] spi: rockchip: Fix runtime resume error handling
      https://git.kernel.org/broonie/spi/c/2aa087742af9
[6/6] spi: rockchip: Add an atomic transfer function
      https://git.kernel.org/broonie/spi/c/324d55c0103c

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

