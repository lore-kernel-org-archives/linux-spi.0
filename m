Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064769;
	b=o9jnGhY8zdD/uIcU9JUe4iHD/LZxhIcfIqkAs8Q3/ZnUQ7g74yzY9thQ9Gmv9i6YtcsM
	 rMM+qUaEAYzuHwJqbKt0yQjvz5pIshH/lrCTHtFXzF8zu8OilKgR3mCNXl/Z1IjphWO3y
	 mkXfkh8VLskmzOqL0KIo5sjByRP+vUW+f6Z3hbhxomv9UGpSPnn0hf94X39vSzEUwtqQA
	 mdthEZ7ZY+MtsoZ03DMhm+gb4E1VJf+T6+KZY/XLdNy24PLaBhv6svjSLOkG6YXBNfmNa
	 7c+XFOV/CVjedN5hHU47PHHaiEi0H3bINDFxN5yM6jNU0I9XN1aiDtDK8fmK9R0bIVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064769;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=258GQipFsyTOXoUA2ByHEo7WeWVzLxapMXTt6kx2fyA=;
	b=GiFsaazjrtndNPSgheIWUC7x8HPgWnrWzKSPja7FEmTfCxespYQBdfnVnkhXVLQURqBF
	 2yxiFHvR+Gmm+ED33EN2WvzPnQt70yuXp2hVeY4AbISsPe2Ho+UGMCCpBiGwnZJJgD1Xi
	 iRsX9WSjqDqQb208LFCO264znM/mrhE8eX2xfVRxZyULtObTdIYSspUH4ODAbLJrC0IUP
	 Gc3e59ETT2ByiO8dioPobyHqbkhZRgAgkLMBk8Wl+vY/AYSKoVG7CQGka6miaE2QHVwJn
	 wFyFvr3VnABSr9nJ8Oepc/NW9p5kfhANtryXhGJzs3lf63QBprt78X1ZcBlW5Vh8zdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xgo2kU6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4F606A9E6;
	Sat,  7 Nov 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xgo2kU6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CF1F0089F;
	Sat,  7 Nov 2026 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064768;
	bh=258GQipFsyTOXoUA2ByHEo7WeWVzLxapMXTt6kx2fyA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Xgo2kU6BrJF85uNf2ydBeHc5WVewhtgdRgVneBNRk2GFI87HoPKGUnCYxgXK+kLaQ
	 2FPw7HkRpbYka8EGzJXqqHAXl1zdsVl1CR+8V7WDUSQdAFfpwRQM06bgZBidy64BB2
	 fgxv4gmc7LgxMSKaCPPWs9qAVdDVtimtSQnWbVOPNwrKhKgTXlBvQq43/v61YRc5rO
	 56LKgfTjl8OBebk8AUjEtljqPmz/Q4JjMnSZI6YVUUGEL1TNBcbeYpxThgfyFCuYxa
	 S8B5+gVLgE3DCVpF7fibkCQ7bsB2ZxpX2xPKDlXx2ZlWhYEa1PmXbL/6/7CMObkNcG
	 uXDTwtHQuz/Pg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id C0AB92AB32AB;
	Sat, 07 Nov 2026 15:19:26 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261104113405.1634275-1-peng.fan@oss.nxp.com>
References: <20261104113405.1634275-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] spi: Convert to subsys_platform_driver()
Message-Id: <179406122369.3424803.2354704707540163499.b4-ty@b4>
Date: Sat, 07 Nov 2026 14:20:23 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IsGdt/njLVLe0xHvqyi3tjPSeuC6ymg0tAUQ836nNnc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeO9btbpz5m92sNtxrmp+QisY3mV3ct4NyeB896050z
 K3acD24o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABP5msPwT+mA1Kw16/dcYP30
 O9v6R7qAcz+XhF4Jr/zjM09uuPCsSmJkeJwsKcMwV+2mKMfqdT93Hje/22NSLf2Y29cnn3dNYN1
 EdgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 04 Nov 2026 19:34:05 +0800, Peng Fan (OSS) wrote:
> spi: Convert to subsys_platform_driver()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: Convert to subsys_platform_driver()
      https://git.kernel.org/broonie/spi/c/4462c852b34a

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

