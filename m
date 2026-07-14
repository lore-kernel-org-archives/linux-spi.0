Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734541D5174
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064054; cv=none; b=HttByFFSiolmwSfV2A/YhiU8kqGsvTHCy3HbyE5jJ7yc25KIuW+HoaBHbhe878nOrSV0TrPjJJpm2Nj5ROya/Mizmgt9JZiay4yL5N/hEJXVEdDno5dOdwSwW//dBdudQehI8/d/p1u9I6fVQqx5qRTmgIu+zt7iet3aL0p1qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064054; c=relaxed/simple;
	bh=9Q0/bd0MPa60BazelPns4nD9jxYnvGJjYOIMz7BFAF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fjB3oDwkJS7WRWmFvRO3XR2nRukKEXdCO5XnJsXraVrKPktAeWQetkTQtZ+m2TqJE5L2vDm0II7XKEWgAdCfkF6jkmo1CUanNVyYkZj6h8zgwHSbYkyJU024v6SWVTo3rOLy1k4RfsS6cqXwXDbL7ZB9eCU6z4ig9SxaFYKgLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlsYekVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlsYekVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2B51F000E9;
	Tue, 14 Jul 2026 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064053;
	bh=c32Lr29m6thqePAxKEP39CRoAT3zIPPol2c8Tfy/EA4=;
	h=Subject:From:Date:To;
	b=WlsYekVDbe1s1v0qMrRSqqp1YpTXq5fFSD+BmL3yJgTiN80D/MeF6x5OmXOxXcO8s
	 H+oZ6rj6VhYwnAFvPGA6mVvdjqppUcyAIMxACHXU13D29sb8Iq5YDYjVA6C3pLTQ8p
	 jPoRCusMIWaD/aZff/D0Nzel+7Rta3DufBGGk3k+5uNqFOOLKTZg1/mtMwFhY/MaM0
	 OXNo9G8Shs+RukNVTmqcczSSUKuV/EHZ29nDTE6bpVbA6mIFvYn4tSSftUs64aFgaf
	 AyCNvXbMsi7Xv0Io/ZMMt8DjdFbIzNWkSXSegeYhs0AOIiY2VCNlL/58NTWbTi+LQ/
	 yeJgxk9lwFuAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 964A03926277;
	Tue, 14 Jul 2026 21:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178406402705.3783353.7498089905047874494.git-patchwork-summary@kernel.org>
Date: Tue, 14 Jul 2026 21:20:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/3] spi: atmel-quadspi: Simplify probe() with local 'dev' variable
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1121858
  Lore link: https://lore.kernel.org/r/20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com
    Patches: [1/3] spi: atmel-quadspi: Simplify probe() with local 'dev' variable
             [2/3] spi: atmel-quadspi: Simplify with dev_err_probe()
             [3/3] spi: altera: Simplify with dev_err_probe()

Patch: spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1123540
  Lore link: https://lore.kernel.org/r/20260708045148.2993313-1-srikanth.boyapally@amd.com

Patch: spi: dw-dma: Wait for controller idle before completing Tx
  Submitter: Wang YuWei <1973615295@qq.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1121991
  Lore link: https://lore.kernel.org/r/tencent_4EA7B5C94669ED4C38A5F6C1C9126E5D9106@qq.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


