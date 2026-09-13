Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06F6421255;
	Mon, 14 Sep 2026 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379297; cv=none; b=J4vbsP1IeSNXypIl0FTBtDHqPKeY1ly52gixzC/5vcHMl6bomf7Yr7FbNW0LXq5IEthAl0JDt2R2kxwCA6+QKC/zCruJ/AkKrHzLz9O8vKplLD7bDH+D8zm/oirYun+kz2myqrMmTqVe0NTBgQ6ffGIh2qtJT8fctjgAEXdaSFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379297; c=relaxed/simple;
	bh=347jpZ/9QMf533uLtDrXpTBaWmItzNDnMh9Tbe6MNIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bwyFyoD44WuMz+n+RdgQLlTyGe6pUa9pnzQKiIt1NoQQZin+3WdtqFPGeYDWaYLZ8Np24QoZmV+g/1xVWd47yhpnLGFCLY99/68DgzXp4/RQUTQ3B/wnpO5GJzsG2Kp9rIPMMPWuqXkfYPRbdVMX3xU7EGDhQphNwczRIPGomqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCq+nKxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCq+nKxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CDD1F00893;
	Mon, 14 Sep 2026 09:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379295;
	bh=0mYe4VizDGEwgBtzf4ANe51F0qCB0t3vyjf25fYmlDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cCq+nKxbkaTkvQhvQzvZGFjWyNw92AD5pCjEaF07rbuMIYuGwbUH1vgMuq0o82KFf
	 d1c1RcWoIQx1UCJ8AjLsSyLTW23oASX1E7Ov3Rg4ThBLBt5B1OCT1Qlgq1HFQibYGH
	 ccmQaqGHTGxr92xvW88V7r9JZR8a14j2Y/cNdo39K+ZbK6xmsj6TkSHGX7KePvHv6c
	 ihtiLfbjko7S4s8soIoyAK3qxfQqWtVid7y+JPo9FQJ/ax6v1g2SN0iuMmfG2O7q+E
	 KnPzfxsZPiLDYzQ/h9TYiGhEsWK8LzV9tlozPFuAD6FvL3BQdibXk/Hu+8H2lJFNU7
	 ruhgGE0Svpa3A==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908-qpic-snand-unnecessary-cast-v1-1-26df1cdd4bb6@gmail.com>
References: <20260908-qpic-snand-unnecessary-cast-v1-1-26df1cdd4bb6@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove unnecessary cast to
 '__le32 *'
Message-Id: <178934236523.1239410.314374999041718654.b4-ty@b4>
Date: Mon, 14 Sep 2026 00:32:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Tue, 08 Sep 2026 21:53:16 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'
      https://git.kernel.org/broonie/spi/c/4b258adc049d

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

