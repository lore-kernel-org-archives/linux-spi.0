Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4451AED7;
	Thu,  1 Oct 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867335; cv=none; b=Zvg3xg6gRat2HL6xRELRVCcjiYxM6XrXIREIkE9ASktxcden5ELIBwlKHhYbosISSGR7/aCBYB3rA+qUowfh1SVC8gKuaqYB7hWkE0wvmSYuzTzV8AxL2Za6Ivkh0TdD8c6ooVi9jcB0lhaFT6tMPvnn0ERX7+ez+UajeDSyJvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867335; c=relaxed/simple;
	bh=9Fw3wcsgiryfAv7+hFXzNuu3dAOxf2hLIqyQz2BXWEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rSSytOXrt3BYsgd/A702FJtWqgLb2xma7lcYjXaMV1uuYyY/aj4NmNlh4akHLxa+kjsW1Ns86/M1XKE+ZEATpEEPrKPMuDXYJKO/LRWHqg8FTiYO4IPfR/q4CrCwAO+giGPfJ2reDTPjlr9W/8X2HYIl/9esq5gvxukKq/h5p5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7zYW2Ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7zYW2Ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076441F000FF;
	Thu,  1 Oct 2026 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790867334;
	bh=XiixTDlDdFLvDBK2BVDhKClEh5mA7ObgBz9wlRu3VFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=B7zYW2Uak3WyFAzNtZs3b+uQak24bOqV2hiemB1zFt2VPTOapLYVijif/TMPpAiBn
	 G9JJwvN/vvG41IbehvGLGL71E25H3QzcBi/dxKT9suEw0Zg3hSdgBnzqFXLOSun84m
	 5mmWEZirPc01FTIqehVgsj6RICylWB2l+IIWgmHaXCOtHPSchcZ66qMtWGIBglm0LD
	 oB8RHhLW23aeNcMZNo9UgohubmUTfHUfvGAIUX3sucyN5+5hxC+lcwd0TpBYt5+iQI
	 aRCKkWYbiNEfqKLt8rNZTdcA6TLcs7MELluYrsPXF5iaIfuu6/bY4yTta5oV7t8F5j
	 5SuJIXLJstyDA==
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu_nicolae.pirea@upb.ro>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Ryan Wanner <ryan.wanner@microchip.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260930140257.490019-1-Frank.Li@oss.nxp.com>
References: <20260930140257.490019-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH v2 1/2] spi: use dmaengine public API instead of raw
 ops
Message-Id: <179086451746.90966.11460372629001308510.b4-ty@b4>
Date: Thu, 01 Oct 2026 15:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1247; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9Fw3wcsgiryfAv7+hFXzNuu3dAOxf2hLIqyQz2BXWEs=;
 b=kA0DAAoWL+9zsLPQOIkByyZiAGq+d3KjtmBqeEKmY+sfGxu7exPooDtr2c/oeo3Xyu+4GOZHT
 4h1BAAWCgAdFiEEXmoL6X9066wOwaGGL+9zsLPQOIkFAmq+d3IACgkQL+9zsLPQOImVKQD7BScV
 DG66eUzlbgiv0ggSaOOIZojMixcHngbquX7GxXoA/iyq5ti1FMRjxOATpr/TOXfnWG8T9vtHvWP
 lLqp9UPYI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 30 Sep 2026 10:02:54 -0400, Frank.Li@oss.nxp.com wrote:
> spi: use dmaengine public API instead of raw ops

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: use dmaengine public API instead of raw ops
      https://git.kernel.org/broonie/spi/c/2d57d6fd1f56
[2/2] spi: use dmaengine_get_dma_device() instead of chan->device->dev
      https://git.kernel.org/broonie/spi/c/853de617c4a6

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

