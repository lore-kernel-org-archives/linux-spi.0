Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFA3AFD12;
	Tue,  9 Jun 2026 23:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046341; cv=none; b=Cu3pcUgOrTJeXHY5pZyZyaRFuKFduk/XzyTtiZIMeX8n7CzlLstm7/KHJ0/6YXrTR6LdaneAZ6SN4l/AMcQO84peODZl3POY9vDicoDo4rXlrqD1Y8fBJSnCVw26B5I/1ZsJyCfY4WixFzFyWXOyEIBe081zP+LkFGruKYrVUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046341; c=relaxed/simple;
	bh=ra3Ot0dD21La+p6doqPoqTkhF/nL/hx+gpU6xyIOI2s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HIj4kTCMW0e11wJCgCIHGCVfLBq2JJygtshmcx2srPsEBQbDrleOwcrdQnEaNYRfxm4e2DGC6pTxpm6nmZc8xS4y0z3AxBBAoqJVysWYQDep6BAGvOR1SC+oYVzu951l2Fu1/yHNMBr37Pad9Oa5k+Cx686xLswCRw2+rYXHo2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihzAXgVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihzAXgVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139AB1F00898;
	Tue,  9 Jun 2026 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046340;
	bh=H1ypLjGdWaHg1Pbo3gmt09FjgL1ztMAJAs0Zww3l3ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ihzAXgVjK99GcVi5pPZVLY3Q4ifxxCuGadc+NF/VkCAR3024NAIGVZh8uqW0VUlS6
	 UOq/f3kEX3qCyvjUNRGOkcI6CuUrpEcVopMnJaQrLFNcF2BTWxUxJaoTkpZ0lF+J5A
	 R3lbMtzzv87pxlVrPAKOPSgKsyuMX1EnUqj365ItjqoWc49JfUnkDcTOtRcctmCB6F
	 AdVX7+Jb9nKrEUiOJqBbVyiiQZOgTbcHFucj4OrK/MJu+S7yDpXcndn1WrlbLnMkyN
	 tHtoMQ97inGvISWBiS7rp0WP8wKtEvRsl5PgWdfz5CIX5flBWH0w3gYRW1i9DhGILU
	 6CFqWSE0Zh5GA==
From: Mark Brown <broonie@kernel.org>
To: tomm.merciai@gmail.com, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260608202509.3651345-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260608202509.3651345-1-tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH] spi: rzv2h-rspi: Add suspend/resume support
Message-Id: <178104140109.34323.21151893515331912.b4-ty@b4>
Date: Tue, 09 Jun 2026 22:43:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ra3Ot0dD21La+p6doqPoqTkhF/nL/hx+gpU6xyIOI2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKJxB2i4TVRFFfMtTNnvGvV8YhJQCzamsMvzIx
 BUI3wh+MXWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiicQQAKCRAk1otyXVSH
 0Fi6B/wIq7yO9CBdAf9FRBhiKCv28OoRZzncdVg3GpZV50rwBZRw5r6XYWCRJYvoC2e8rCNIab3
 TCfn+6mWhzKuvMHXh3a/6g0zCKy25tjrejHKQZBPV3yOEHIAxWpXpxzSBWzxVSYQRNdvLv3LbBS
 gJdWEG6PXMfWD5OQvDcjmIrIl97xYGbcgtLtJyx26k+voAqrYSLgSRvma7C7xqXO6LZB1HhN/wY
 R23NyWBoyrcH5dhxhxzYI7ogzRZVi8ziPIFWuDc796v7P+glkjXFwvmTHbaySN08XYdbyNdsr4k
 S5+5P4efje9NHNdh466s7kVIkQH24fwwe5peNBWSNhupUVrG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 08 Jun 2026 22:25:08 +0200, Tommaso Merciai wrote:
> spi: rzv2h-rspi: Add suspend/resume support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: rzv2h-rspi: Add suspend/resume support
      https://git.kernel.org/broonie/spi/c/2cf4ad412f90

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

