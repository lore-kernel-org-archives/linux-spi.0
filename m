Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7A82EACEF;
	Fri, 24 Jul 2026 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854723; cv=none; b=Ew9pYWISeknJ9za2NgCoLRcJ26uYZYsbG52CAIbpUGaOF/r3TbJ0d8WoHZaFU7+8579wyERRHh7V3CnZK+TolsRUh1KnZfFqs60saRxTmp497ep/LsQkOOpqMZSjOoPdH3XzEx10kRAXjsS/cSw/sfONLXxz1DZqscztOWgOuYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854723; c=relaxed/simple;
	bh=paT0EgDOjc3vEpgjmtYJsq9rFphaCgtgbuM51+hgsUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e9cAWdvyI+4PdcjGLiGLtZKpJAJnKTDP8m72BQjWd5xO/B459RIFg7pHAWJhNteX5g5aRWwOyamkx+IU5NJ9u1IZHLf1LPt2j9vQWysCUpiMlZrNP+riMRDN2ex4gwDvh516/JSXC+U2iXQ4Lta+5kfA7HFAgexnTgW53uvz0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiRHR6My; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiRHR6My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DACC1F000E9;
	Fri, 24 Jul 2026 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854722;
	bh=MTE3ekRM/dUuD7swK2qnfDz3MgDaOVtmfU7rqUsKiP4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MiRHR6MywchzHg5bAjcpNQsAP3QwCZ9F6go+5x2rrZmZBlEQSP3glnevKs3MZrq5Z
	 0oWnwY3FqG/cc+HMdd3C0UlxVSYrRQRcj8uuFRsCIqplOKDZk6KHIdR90SJu2wxIsO
	 maFC8w7owyJCu2TyrtgzbsXERxXrp5Zv+iFstjsxujzbjhbQF/o0a2xejuLxcQcSgl
	 TxElx9XPZvETJVDkbO8whoOMtmwJ4MNp+VPJVwNrjjVfltgo8+j0eqq1AhnxxeeKYa
	 sWG6TOxf7oLbkIqoO3jCYx/cglEGNrFQnF75MPwYvnKs9q/1FUMJSKxQQUQ+giFdVN
	 lp2aPj34bWYWg==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
 han.xu@oss.nxp.com
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Han Xu <han.xu@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
References: <20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com>
Subject: Re: (subset) [PATCH v3 0/3] Add DMA support for i.MX94 and improve
 AHB read performance
Message-Id: <178481660524.53486.16709271966474677924.b4-ty@b4>
Date: Thu, 23 Jul 2026 15:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=broonie@kernel.org;
 h=from:subject:message-id; bh=paT0EgDOjc3vEpgjmtYJsq9rFphaCgtgbuM51+hgsUY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqYri+L5XkQxLBYrzQPKVS4j973YIp6flIsz7cu
 cgR3QQNbPmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamK4vgAKCRAk1otyXVSH
 0JXwB/9y9jkv9rM1aQpigs8h/xGon6ocqEPIndgStSKUfsm4LIyO9J7p58WgCdMBzxVSI92Tk8P
 c4XxY8edb5msw7tUI4kF4PN4HwQLuU4KaBHnedu4q0MNr2d0XeV550syZw7AUiJE6RS5YmTwlry
 TxqToN0IH3lpt7EpuScWdtrnJFx4mQWyWH0ODuYR3bWJ4W2+R3GMn9kmKZZq8ufjZbSdh7ZwdX5
 hEBBbkIYHNTavPNloeft0g2ZupEdq4KCET/Dx1E5Hqndi3ssen66KGr6zGpsVnK6tAIWZmsFh1G
 I76lI6lSD7gCTdCMy0mXRCngcLXT/YIVd8fC0u2ulIpQfBS9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 22 Jul 2026 17:00:41 -0500, han.xu@oss.nxp.com wrote:
> Add DMA support for i.MX94 and improve AHB read performance
> 
> This series adds DMA support to the NXP XSPI controller on i.MX94
> and enables the use of DMA for AHB read operations to improve
> performance.
> 
> On i.MX943 EVK, the measured read throughput improves 4x higher, from
> approximately 70 MB/s to 290 MB/s when DMA is used.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA properties
      https://git.kernel.org/broonie/spi/c/6f99efb11526
[2/3] spi: nxp-xspi: Improve AHB read performance with DMA
      https://git.kernel.org/broonie/spi/c/38d11bb2cd1d

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

