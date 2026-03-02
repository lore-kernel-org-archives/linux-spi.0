Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3A282F04
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492231; cv=none; b=T7N5ltA1olO6NXsqJ0wpD9/us6SFEFY6B9ZvssGSbfyhASR8FeQ6qk053QbCWo16xcdNpyN656uTOo54iXSTu3skIxvSn2VL8Gy6Fxc+d3WefURUwo91nnmMDoFKTGIBqLoA9JxQa8obGnS4RdOQgbP/cb3DsoQWZ9ucM45v+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492231; c=relaxed/simple;
	bh=zDO8vtez2mvBHiuArvKibRlrI5uUxlBKmArEeyLgPXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HFNhVz8Nju58v+kCXdq3undLcPUueJesDz1XTn46qWzuff8R2OKpzxtU2SIyTV/U+3rbjc3Zt0O7Eng0/COCQ8zlk3aRX4dcT634yAaFEzPKmquR48h7dfi1iQ1NE4mAAP6fdFfflC7CMJpnRndkswBnxPkBt0575uPgP9g96zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tczCSvna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tczCSvna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C25C2BC9E;
	Mon,  2 Mar 2026 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772492230;
	bh=zDO8vtez2mvBHiuArvKibRlrI5uUxlBKmArEeyLgPXY=;
	h=Subject:From:Date:To:From;
	b=tczCSvnaHog5uni9NEgbmw4/UMdMXdZ3/Xj1UrwJITrXQ+rgIhvVhrFmEqxm4NGwZ
	 vaN/HQaQ8ZgF92J2OKir4mBZscj5Ax98sGtZttq2bwmIX3cy70TRcfUWvdDp1C8N+q
	 wOPD3VlmquPouw3UwNEVo5pbpiv+X4iWDZsnaN2q0CtNDXPnVF3pR4wBN5qz1AI178
	 rZVpOJjx3Baj8G0ho0dIEqywJei2AQ4glMTkq7oYaFKuvf9y8xae3k/6UpklliXfJY
	 1Pc3NES651HwpLaHnCFETqS1eXxTkT3BxWBi2IVe7jmqtilKqgG1X1diW+apAm7wma
	 RFxd3Kr0Zg9MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BB6973809A80;
	Mon,  2 Mar 2026 22:57:13 +0000 (UTC)
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
 <177249223230.566966.12402248614294810717.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Mar 2026 22:57:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-dw-dma: fix print error log when wait finish transaction (2026-03-02T22:20:16)
  Superseding: [v1] spi: spi-dw-dma: fix print error log when wait finish transaction (2026-03-02T11:32:33):
    spi: spi-dw-dma: fix print error log when wait finish transaction


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

