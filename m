Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084E312836;
	Thu, 15 Oct 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075984; cv=none; b=ArYUTOK0dxOTcrZJln4dlGC8y709r3xWT8uDomNNgC5gTrFyFGPMLmAwsxteWX3xf53p6EYVNKbgD3s3Tbagu+PFS5D5X3wDh2hnVP4CSHlu+6VDyG/ZI7uDCSrhCVYo/PJs245+J+n+Vmp5JNVag+26xxSmOpEL0Zn1sGKRwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075984; c=relaxed/simple;
	bh=FDgQwQDx9X6hfNwWrS6YouXRNLOlFWf+sGEb3qmKyOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S+RPqXEfloH7be+L7JF44JTpF6pPmTv5kLnT3zsa5Mxhcs+4xdhNgnKJZNsBRF4Sb5PbilBr2VzgSIaSiUZc7vMfaRuxIL9ZjAyX0ozbmk2bNQ8LnJ2bKuYwiQpNG6nQxK6dCYO1mqMVHWMDlUUZjVXkSOu+NPeFHPB9nKoAO+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nlm4MbwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nlm4MbwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826EC1F000C4;
	Thu, 15 Oct 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075982;
	bh=d4y6q7zwRfmUR8ctlN1+xywNu0uVLilrBEtFSc91IVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Nlm4MbwY0tmgK7J6My0jedEXE/lp65C5M7H8OC0DVTjcHvgabrDjZwscRq2Q8N7Uw
	 Z/aEGutci3h/M7Hhxc19qvpeJQrLo1Ov623FzEGOtbYM/WW06id38kKBq99rrAzfyR
	 w7mI0eWvAigsfrV8XnlTQSiittaNRn0NDPDCTvtGpPNrVDLbk6EAI9G+v4RTljBzh/
	 jaBZP1jCEXEpNFg4YIisRkWyc7URMwqKJmbg/1e/CckrnHe4snOgGb6Ts6o6D5+HQk
	 JftCVqB7DsZFv6oJstTeV6GE6ZQ2cR0Lb1BxXWoDQR4YvRYRj78z7Q5UPRfY/QnEHf
	 aC4jEtIOH8kRQ==
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: pthombar@cadence.com, wsadowski@marvell.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260929081146.41041-1-liuwb@xiaopeng.com>
References: <20260929081146.41041-1-liuwb@xiaopeng.com>
Subject: Re: [PATCH 0/2] spi: cadence-xspi: two memory-safety fixes in the
 slave-DMA paths
Message-Id: <179199270795.228143.15856421072994575885.b4-ty@b4>
Date: Wed, 14 Oct 2026 16:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FDgQwQDx9X6hfNwWrS6YouXRNLOlFWf+sGEb3qmKyOg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuvDg91+tHYdml9eqn9P69+j3n8qG72Rt3HS2Um6ewQ
 +RqxfJIxY5SFgYxLgZZMUWWuCzul/Ulr9fwHVzYBjOHlQlkCAMXpwBM5PYsRoY1h3UquFYc4PJc
 obdwkuaLq0EFM5i/vQsvyzjYy/bRZmsew/9KYf/Ss+EV/pP7Np7V6jBr+C9xObe+bMGc7u3eG7f
 dusgAAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 16:11:43 +0800, Weibin Liu wrote:
> spi: cadence-xspi: two memory-safety fixes in the slave-DMA paths
> 
> While reviewing the slave-DMA handling of the Cadence XSPI driver I
> found two ways in which memory the SPI core handed to the driver can be
> overrun:
> 
>   1/2 both SDMA handlers copy the byte count reported by SDMA_SIZE_REG
>       without checking it against the requested transfer length; a
>       device reporting more bytes than were programmed makes the
>       handlers walk past the end of the transfer buffers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: cadence-xspi: reject SDMA transfers larger than the requested length
      https://git.kernel.org/broonie/spi/c/ea9854a169e9
[2/2] spi: cadence-xspi: fix stack buffer overflow in the Marvell b0 path
      https://git.kernel.org/broonie/spi/c/ef9690269999

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

