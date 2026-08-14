Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEE39F162;
	Fri, 14 Aug 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721158; cv=none; b=GKJvW2K7+WjuVC398wskIMlogm8J6b7j2Ct6UcwaemmNwgaSIoMo0Y3wxNnJuDvR9JsZnNujf3yYbm924oCD1s25DOI+QDyVpLGhJL4sTiXX+hVvDag+ZB5TmQaNhu6iEprKorplkbYvm1I3QP4U64X6GKXW7svlC1/MadtKu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721158; c=relaxed/simple;
	bh=WqAGnzPYesnDo3xK7PIUld1flS8WAhP99AdR92FDBOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kzgsosFrLrr+if353xd8dJbc8t20N2fZNniqnMJY+narJ8Mn995xcuUhNu/B+VfMPIrx2sa7jhtUSA4FpUdhkzNLOF/hz+fzwt4dgjcBDvE58fAYFV/H59DD2kJN4drJ9z+J2522SMGX2wxLv6hOb4A8vRSeqKJG3YuddtnmSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Khs4OS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Khs4OS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E441D1F000E9;
	Fri, 14 Aug 2026 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721156;
	bh=+qyVwXNXVo30slw7p08LuNDnsX2PRAB7HNo1duI8TP8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=c+Khs4OSp//TnKS0n/S9r4YAnvuZdZpfa8zE0D8EkaU6xvkqz8eV1b2DqC1LULEBT
	 tP7Akkl6TNgX+orV3yCIwNel9Hh6fe3tAmM5HtEkf2hAPArMeIbSSU00WkfQGGpLfJ
	 YswenjX/kccdITcM+fGhmkqNsVW7t9KTnRx+GVcgFwV+fV8JK9+02QKMoLFvpihqDJ
	 TVjweVXzJZPNgZ4pKGbjbTzkVP3+ObszQV+O/kk92p99n9oyqK/35IdpGaK5qtIKtd
	 tztTaqioSvLyv3M0wKjkqs3v08GZi+uUpD6DRyEAB62hg4wdiZW6hlrBYg6RxxtLiY
	 V+yGLpaB6bnJQ==
From: Mark Brown <broonie@kernel.org>
To: Liang Hao <haohlliang@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260814114235.31281-1-haohlliang@gmail.com>
References: <20260814114235.31281-1-haohlliang@gmail.com>
Subject: Re: [PATCH] spi: dw: Remove shadowed dws in dw_spi_setup()
Message-Id: <178671087720.118516.14269033371358934851.b4-ty@b4>
Date: Fri, 14 Aug 2026 13:34:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Fri, 14 Aug 2026 19:42:35 +0800, Liang Hao wrote:
> spi: dw: Remove shadowed dws in dw_spi_setup()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: dw: Remove shadowed dws in dw_spi_setup()
      https://git.kernel.org/broonie/spi/c/11dfeb73d1f9

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

