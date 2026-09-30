Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E6446BE0
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755552; cv=none; b=VVSORVzgvxj0C84hhXsn2ePGEJrT16Q7EcGzwdghenZhmK2+T6JfI/0YcaGcAbk2UBbt6dDZh8lACtWLiTF/czpRtQ0VCn1ZVaeWLJ9Ff6fhY6rQ9+d3eUOhIKPwfwBpfvagUcG5h2CYbtyDoJaJi6MxOESikwKsheP/EIJLXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755552; c=relaxed/simple;
	bh=k8RjQYDnmAG3nYGZ2atgybj5BUnDbm6VaGZPtw7mU7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=submoxXmGKRM92qqIgpVHBOqDi9+0j52rDUPKSg2Cg3u13YakpDl5fI35O9VdWItDMvhPnGgM/dS/CTVCgGI+ED+CSIPJl/BhqlcODTJqbq+OSY8lnvB+vDsPjy5l6xwDGG8f7hCu/uzoAIEcu2yaOaKmjpAa9tRpeU2HspFQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkB4AnEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkB4AnEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E4D1F000FF;
	Wed, 30 Sep 2026 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755551;
	bh=kHL4JXddIqhd/uPbxhQpZOfo7ypZO3Vof4aIrXtuE9I=;
	h=Subject:From:Date:To;
	b=UkB4AnEQm2/3EUoWE1tLGrwSaXSNZlQlWvPtR7R6iOQPsvFH4uxcrlK6DjtKX0Dgi
	 3ewZh6+mUlUowy4pBiQLV7XW5ZZONXmD0Ue2paz15pRE1beP5TvI3kf8BhPj2bGZ1x
	 n7FKSsScOAiQH+auHHUxBErEMlIla+SQLkZ8Nw8vNtXCL2E1zehWzT+pDN/7NwuzL8
	 TXFcfKEKWd+ZSzDBhhAlpMglUhTWnIs4/ySkjNo1HMh3Sscf3Io5qK474B4XHybV5M
	 YfkKM1Oom4cKg2XjSsGGzlSPfdB1itxF/wzXJjjOjjwT1Ems1dbC7mdZZZkCwGUeEF
	 kFVdJn+vatv8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15EB39E8A69;
	Wed, 30 Sep 2026 08:05:50 +0000 (UTC)
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
 <179075554963.1318500.13727875053544351924.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Sep 2026 08:05:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller (2026-09-30T06:59:45)
  Superseding: [v4] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller (2026-09-09T12:56:59):
    [v4,1/2] dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
    [v4,2/2] spi: spi-mem: Add Realtek SPI NOR flash controller driver

Latest series: [v2] Add enhance SPI DMA support for JHB100 SFC (2026-09-30T07:15:33)
  Superseding: [v1] Add enhance SPI DMA support for JHB100 SFC (2026-09-23T09:57:05):
    [v1,1/2] spi: dw: Request DMA channels at runtime instead of probe
    [v1,2/2] spi: dw: Add DMA support for enhanced memory operations

Checked 184 series in 5.03 seconds.
This project currently has 16660 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

