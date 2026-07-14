Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDB429CFE;
	Tue, 14 Jul 2026 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064270; cv=none; b=undU8EADWNflBb9bW82an1NO00zlCGlz8I7b7TVIWu43yALtkf0Zu1WdyHjY9VfC0OBBdzRFJlR6K19tjRMNQFV0dvlBMkB0kdCXBp8aTvjr+hJmxYAexS8pdZ9T0qoW6b2swhRwoW95PBZBPUgbwVyrCE7rwbxBgFBKpaLucg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064270; c=relaxed/simple;
	bh=DaWjsUSig4ErX2jVNCl3p/CRZv4im5Om+isUUFTp/bc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oSuxXg3gd6Mlb8xISmi2/eTHQzuiH061puQ+dLW2wSxC1FPsDkV86DvoU4HvF/u4ld9l3vKki6F16aCWAjrW5coPd7g3s6FUeoKpUswa78d7y2cg5pVI4BvUL04/ro7vn2bDt5FIOoP8ttjCfvz96pSmjqZg+2UZwU2zjwGUEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX4RwzW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX4RwzW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6DC1F000E9;
	Tue, 14 Jul 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064269;
	bh=ki0ZKuatrqzrI5gyrC/Pa7/LNR9OWwSLUnT+Kl1TNfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gX4RwzW4lbwQxR7XwlwOFwfDaGEcPHcTzPs1cbknLARJXF2KZwzSqpLWuskHd4QvL
	 IgxNSY1J5BOrB6vJuX38AkMAtS4j85lP3B5HcSxlwZ2mT4ZPCO6wQRuoSnOyYS7GB+
	 ynfmI+YxYM177HSEx3YKc0o+A/7ulYysAs3tShm7x4/by8pcyjgRgWpQqSUT0Z/Jc2
	 F+yIns0qlp6D9UhHuO+Y7bASJi+dkwsmWn7yJLoxnwjyxP8lRpxmUYLDPVhLkd5oJa
	 rBHZTvfMioTCNcM0rrfAuTX+NKzcPazyW/d774U6K01x7L2pRAHtlpXdKWmZAGINqw
	 hkT62FFdULrEw==
From: Mark Brown <broonie@kernel.org>
To: Wang YuWei <1973615295@qq.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <tencent_4EA7B5C94669ED4C38A5F6C1C9126E5D9106@qq.com>
References: <tencent_4EA7B5C94669ED4C38A5F6C1C9126E5D9106@qq.com>
Subject: Re: [PATCH] spi: dw-dma: Wait for controller idle before
 completing Tx
Message-Id: <178402778853.7661.3510403195238051791.b4-ty@b4>
Date: Tue, 14 Jul 2026 12:16:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DaWjsUSig4ErX2jVNCl3p/CRZv4im5Om+isUUFTp/bc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqVqkLxGczKv/0sJHl7k7NfhwZHEOKqPz79DgHh
 n1cTCGs20iJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalapCwAKCRAk1otyXVSH
 0ALaB/9MoFIwqpG/7ZYcfliNafp1Bg5ba4/oljhFC3ej9k0MT0Ii8EbcvTUx7UtWIT7qzavVaHc
 QDzj9diF/x9FvhpRiiK8v35MmUvS53F4jjNAohsWBUM+fKpnKUU8bzrM0DNa1OU19k3kHR80VOs
 /LKLN9mg8PEO5bLa3tFR2SMKOMKuEdaknYqC1fpb3VIgqTOq/SLYC8O2mbk1IqQrOv3VLejDWtF
 X2Xjl+jzkLDLE9aIwz97Zi5YdpvBivpnEx2sTyZL5LRK2OrM8mrvWV6ohnNI+WWNTjsZev91Ezy
 LpwSjCXJ4L5Yu2r6mAlnRL8DJVo5UOIG5GDTSr843Cn+QXZ+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 06 Jul 2026 11:33:13 +0800, Wang YuWei wrote:
> spi: dw-dma: Wait for controller idle before completing Tx

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: dw-dma: Wait for controller idle before completing Tx
      https://git.kernel.org/broonie/sound/c/0bcd59706aed

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

