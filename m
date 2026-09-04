Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D24DBD67
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552766; cv=none; b=VLJRVuzfUhBHZBVbgUJoD0Ux3k9Om/0Tg1soqwe6efNHaPoYRStIWiPOPQZcC3qxW6K4pSzCpmmcC4Ti3uu1l7PrNHDGB1/IGp7cTMuix3VOoyYo8fSzK5yeBhKoBg4VSGsRoTLr39gKyQTfwCDGHk4lmoGsF+0PYg3ixu2nyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552766; c=relaxed/simple;
	bh=9NNiNkIhkWioxv54G8qMXV7N2CmJ8UHysUOt8WjPS6E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OwrgEMYyPBG+oden16WkwhmnE+FqGCnhuTDkfLKwHvTP9FomeHE60mlIy7lOZm3X+2wylV6jnAPWuv81Exrtcz7fKHh/Y5yfJFQ8D7p1pnNTJU2BPqulcmuECtTVrxg2kv9lW0eU2+QxAC70pD+JVDbj7mQJU+lFe1z4cw83TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg3YaQh8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg3YaQh8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C154B1F00A3E;
	Fri,  4 Sep 2026 20:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552754;
	bh=lbT1VLDIS80UBAzC8yx9HtCTeNwNwTpzzQk3VWwmyyo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hg3YaQh8sb4xeRkcp2NOeZZFgQqcO1jOd9zcKjr3bsQqpv/d+JnnUlHIeZ82GVczI
	 W3KusPXZraaxOEhVwO+HCEO6FqBXeVwx82kWM8GIXec2XiioYlJ5dN8XotmH8blSW/
	 4ihFmADP/eWDNWtAfi9f7dHhLygPo1MTHJ3nMs0PROiAbSAynnARmgaXqwZLEuFSc9
	 Z6jr83uc8vWdNPY688R3CeGvuRJ6oVjD2QNLBexs6pv75IzI/5LGY2EI/wHYWUTwDP
	 5KPIjaOJ22sJySnTk2aa18jCyhyq1ASgisisKoseYhUWh99OhifQ/r4jFK6KW2HAqZ
	 bN3SvVIdG1tlA==
From: Mark Brown <broonie@kernel.org>
To: ychuang3@nuvoton.com, schung@nuvoton.com, 
 Li Youhong <dayou5941@163.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Li Youhong <liyouhong@kylinos.cn>
In-Reply-To: <20260901025129.359960-1-dayou5941@163.com>
References: <20260901025129.359960-1-dayou5941@163.com>
Subject: Re: [PATCH] spi: ma35d1-qspi: assert reset on probe error paths
Message-Id: <178854594307.632048.12009363322377734268.b4-ty@b4>
Date: Fri, 04 Sep 2026 19:19:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9NNiNkIhkWioxv54G8qMXV7N2CmJ8UHysUOt8WjPS6E=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqzZanpz7WqSbSyq8kOFLfzyug4YdbzQFg5YNPNRxjOd9
 sdF2lydjMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBE6prY/6nZMUpMCZzaYBM5
 Q1/mRcBapbyFiz723il69yrec2LjEQ6e6sB9m3I51ORPX+K/dlbN0F0pavs0hozZhnuBJvnayJu
 FauYf+xi7ojO9bt17ruCfffI965Y/PcR6Wkj2V67zte3OLcJWv0oi7snVrYgX1I9YtujyGiFjCc
 33Jt9+N2aoZcjNupRfxxpYuvrJc95/UvPuBB2xU3iXb9O3w0Ps3MrmiO9FrYIlF5T81Y8bNRbZ/
 7u4yXnDASdN0fsXAlmtMw//e73Ax2La7hUbpjFq2oruLDDccebaobe1u25yKQZ8KDCavFqzVbZ8
 js3lwMLCT+F3GdUTGxas/fVj4yfvic0dc58/+3ZjM+sCAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 01 Sep 2026 10:51:29 +0800, Li Youhong wrote:
> spi: ma35d1-qspi: assert reset on probe error paths

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: ma35d1-qspi: assert reset on probe error paths
      https://git.kernel.org/broonie/spi/c/8992169e7ac6

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

