Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674935E944
	for <linux-spi@vger.kernel.org>; Fri, 14 Aug 2026 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679946; cv=none; b=XpZoA7NvJKVCFSQt6NC4zMHeHq13pckaqHbvftJtNUHKToRt51SV6tojx+7MCdzPMb1/sYBIqJM75WmiAXnSz0OkGUfka1tq3HHGB0IsjAQBXTaqWulm13KfBFsF3qrlNIMB/gObfWaOlPbZC6ioUWvPUx65uZLMDszbfZXJOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679946; c=relaxed/simple;
	bh=rWx8/HCT/MVNJya7T0L/2ovoCON1dE1xX9tX94vuClM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ue9SyDCzX4nx0D2h5GTpx3D4xAdrdvnApaJyFv+ydEnkUg7Ag6cbwIfszvYgmmvfoz2D4bMtiWUnjGM0WlUyNtUVGGgaILCQiRjnU1HVO3IBPJL0RgnF8RZ4nXCZXYkRe6e/+rnSffn0OPjsx+1zuFsoFGkmBYAXz8NegBlWEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR+HOc/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR+HOc/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C891F000E9;
	Fri, 14 Aug 2026 03:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786679944;
	bh=Mo9CPrFJ50G+iB1ypREFJ6vBV6MSB5LaHo2WcviIe8U=;
	h=Subject:From:Date:To;
	b=QR+HOc/4tDAaSlpUBGhEkZDfjC4HPmGnynFnhaw+ZzBGyMc1XOtcTCaN8aom38K6J
	 EZklwJ+k9qAA5iCamqIPXXfSfQ1Cys8VTwdv25htDVBnPlDzKkfLXfDpe2Oxm8hhzi
	 XRPgsmsLDpEIdUVEvMuhexv37wylP4MoTPXLClIGkdEolQeiLoZDSoVa6hTi/XLSXC
	 FFm5/XFCpeZ8HLDgrntZYy8/J+jKvBmDE1p1Z36QdeNLTDAaXDe4G6bh/YmDzA6/bD
	 83bEsaDKAnXznvuJVgggB2M+CzXrMvmgjvwxd8BoJ6FeFSsqb111gDRjeJ01WfeItQ
	 G0DM3eBAlb0cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A93810900;
	Fri, 14 Aug 2026 03:58:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178667989940.3159157.734890192222854764.git-patchwork-housekeeping@kernel.org>
Date: Fri, 14 Aug 2026 03:58:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Fix DMA mapping ownership on partial map failure (2026-08-14T03:14:14)
  Superseding: [v1] spi: Fix DMA mapping ownership on partial map failure (2026-08-05T15:14:55):
    [1/2] spi: Fix DMA mapping ownership on partial map failure
    [2/2] spi: Add KUnit coverage for DMA mapping error paths


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

