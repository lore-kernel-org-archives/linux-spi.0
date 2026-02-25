Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B93EF0C9;
	Wed, 25 Feb 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046461; cv=none; b=n5gM6v9UNRRy9ZHIXmr5XfGQoSgAd+MK+hD3KoOUr+Y2xRht2qIi4kc4Um+I16lwlhZhnHjrEi7fdLW2jHGX61oz50TBmvwc8uEA+Rkyq3dxRsGjTykrUyzZbChVqTAJnairYeo3SG5IJZ67Qps4kaTi+r3ADupsauajTgtGU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046461; c=relaxed/simple;
	bh=biK/LZjPMrU7Yfoz9m/nYzOzEBFg4csNt7xjj2Uy6fU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bUuCGF4Utzs6oGeU7cIw72juE1iatMM75tK/+EbCXTSXH+J6rcfsE5XnS46SwyOlkG/r0U7+T9jPQBANvV7SxAxlXSALUkE0si3lleDWIObo3uov52e1l9yID4k9xt3X3T9nvNkHeNwcnGY4rmBLSrVqUa49GDGbEdxM0WNf1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImV7GXLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImV7GXLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037E4C19422;
	Wed, 25 Feb 2026 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046461;
	bh=biK/LZjPMrU7Yfoz9m/nYzOzEBFg4csNt7xjj2Uy6fU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ImV7GXLh6MOLVQyKzxpUqahLV4FJxDduQFsyp4pT2SbmZlwQf6yJYMGFjITvD4uCx
	 Aj26vzyD5RwnkND/vjdk6c1CuAaqjgm1f3kPMcFjYfvmholDVs5fQc6xWphFK0Wlnm
	 Wrdk1wNe7yE8nOb/riDFtGfGI6u++ivMLJm6xn5bptdnF0lrkV6ALfuOCZ2u8D2VZI
	 yo+0CiYyu3YndD8Cq3Ettz9hsUFlGFb+wMSS9MceY0SqF+9CM3gmPMVSlPAg79JV5P
	 GMdd3oXviKC5VHD1bu8yAlA5Lhd385cQo97L03L8tIBi8IdhvU2AkVU6oszxs3bFjo
	 HxHn4TkmX01Hw==
From: Mark Brown <broonie@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260214212800.262461-1-apokusinski01@gmail.com>
References: <20260214212800.262461-1-apokusinski01@gmail.com>
Subject: Re: [PATCH] spi: omap2-mcspi: add support for 3-wire transfers
Message-Id: <177204646076.169139.5869223867161474200.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:40 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sat, 14 Feb 2026 22:28:00 +0100, Antoni Pokusinski wrote:
> Update omap_mcspi_setup_transfer() so that the driver supports
> communication over a single data line for 3-wire SPI devices.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: add support for 3-wire transfers
      commit: 6f7e9b11549dc726270a7e8539201d4270f15803

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

