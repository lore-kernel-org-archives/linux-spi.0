Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0B3EAC80
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796764; cv=none; b=sqrE7ijKVArwwFB9xiZiv8nzlQBiCKUjNYPUp2+nTOiWqzmyfNWTGiNkP5GjhNHB5kiTLPE8FY6VZWLHBc7lAyDHpH+KzDfmGrBHUV4eq/cuXGGlUsyMwayBtMGglwkSafStnYqYq4WO5f3+/qbDDuVlPPzRclE+RcgqbvVwPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796764; c=relaxed/simple;
	bh=g64SGcYtRhrvr++IXXBAjYTIenmvoonypL07U9BI3KQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HK8SL3JyxLDxytWKfqGLvJ5I1BDIADRs07lbOCYPXI3sa78WGo2iMWb80jZLhwOM3FlU12WtnjoXEZfBlPFsnU8DrIHuU5uMdWx89suMDdUtMVHIblxQkdeEEPYN8N/Sh6FlYrRyJ6pgzll4Mh1H05ILo9D1l3cS2c3kBGVBF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdrpxZ2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdrpxZ2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733161F00A3A;
	Mon,  7 Sep 2026 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788796762;
	bh=6o5fQY8mQP9Eug2oYxC0nrkX3Nt/ewXy8aMDdG6/MTc=;
	h=Subject:From:Date:To;
	b=EdrpxZ2Svzi5ogMuFQfmYAjPNSacMTDG78m2LdJe8j1XfAkUKLjt0jc7Wuvy667oi
	 vGe+HjA0YyOUkkaIMkf6rJ6O7eQAwg14mY3SYA/khm0ENyknk5863HYtuXjCbrkogr
	 RQctrh4ANd0nCpJbZzsTKbucI5wKRReVyCTukes7zOOGMaY+hJOn6t4aznq0G9fL9N
	 JI76hRezNvGwFH3Ef8sWRPMHRVv1RYKkTTByXo0s3APH8M3t4WWdk9L22s0LWzuAen
	 cQZ+Tckr/wnU8MuAa8m5kvJMS6vMMDLOxBV4nRhUOQqr+ibqO3KxT2h9EHkY1TI4qY
	 oTjgtxAIwEBlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D6A39E4DB6;
	Mon,  7 Sep 2026 15:58:22 +0000 (UTC)
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
 <178879670143.3053406.2078306096940025341.git-patchwork-housekeeping@kernel.org>
Date: Mon, 07 Sep 2026 15:58:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-sun4i: assorted fixes (2026-09-07T15:31:40)
  Superseding: [v1] spi: spi-sun4i: assorted fixes (2026-09-02T15:35:45):
    [1/5] spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
    [2/5] spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
    [3/5] spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
    [4/5] spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
    [5/5] spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

Checked 166 series in 3.85 seconds.
This project currently has 16449 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

