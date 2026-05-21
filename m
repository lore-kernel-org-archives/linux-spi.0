Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4526F2BF
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375470; cv=none; b=s+L0EdAreQR+TZGek5EgvIWTQFn34Dsr9mrLSkfi4ZcCm2yTKENzsgB/JUuekLL+hJ2tKC5d67QFL/fcObSfttpSJs2l4z+6CrYdp4s3D9e3qppzF1PO5na4WkX563HF2Am+DrBojivIq/3A5HIfS3exOp38tXx+QuWKftpn6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375470; c=relaxed/simple;
	bh=a/GUCuQ5Ba7ce3BLFVhIQzlGHMp6rGWVrpIWJ6ZqYhQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ivw0GTlFUgBHcReGXYe2GtiARot2yFtb+/K151UGoLe+by+aGcHZLAF8nhVW49B8uxAndF5698PDmwUIcq0RSgm7XFSMj7qg1uaoypAtZQYwf826z8Qgh8absCR/AqqlzNe5tP8ues8BVl4UmOWMaaCwtYvbMvnqhx7Et4RPDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCUb59ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCUb59ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1491F000E9;
	Thu, 21 May 2026 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375468;
	bh=ZY7+MWZFDLYd8/ToZVL6n+d/+mhGwpLBCn/KChJ1IrQ=;
	h=Subject:From:Date:To;
	b=DCUb59ve/DtXfWe+vOEYHGRvSRx3a9R5Jzus6gXFxtXI51vNDKyqQ64M4HACdvNr0
	 bxzY94CSXaXToOdBFIXnW/1r32OE7TjAPAUsWWu5yUvlc4Chi20LDmcjhDKcFNxqmh
	 KJlule8ilHNV2Kg7jT+fzSCZ8GfhaqI/qeyld9x9/FVkcQffxUzS0mDnJ4QMlsniTc
	 egKPuDXEixlbcpjuDSCKLD/8GbWM8ldfrKNchyLNKiXtS5unjTt4egumrJEiSqzjhX
	 YsvtQi3ZcIJjLXxwsAvPWbBI7X/vZaOQlFl1vwnEl3XbzTfeZDRH6ClzQIYRbEEtKB
	 +/y16qWTZAHsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09C03930DF1;
	Thu, 21 May 2026 14:57:59 +0000 (UTC)
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
 <177937547840.365571.6562537395249424436.git-patchwork-housekeeping@kernel.org>
Date: Thu, 21 May 2026 14:57:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: enable the SpacemiT K3 SoC QSPI (2026-05-21T14:44:44)
  Superseding: [v1] spi: enable the SpacemiT K3 SoC QSPI (2026-05-19T06:15:54):
    [1/3] spi: dt-bindings: fsl-qspi: support SpacemiT K3
    [2/3] spi: fsl-qspi: add SpacemiT K3 support
    [3/3] riscv: dts: spacemit: add QSPI support for K3 Pico-ITX


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

