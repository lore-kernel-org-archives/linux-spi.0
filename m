Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7002D12EC
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061929; cv=none; b=qDDzfU1d30fMMg/a2GE0DiwwErsHxDQhCwy4g49NGgQHigaxrZI9jQqMWKrtII4V5PDvPEfnheNCoigTIpqtQXMy2eVwUes3kPUdUGuT6GVgi5s1akoI4rMGLuCpx03II600Oh9NH9ZdJkSkkQ7oBWJeAQnX7+L/ypmRIP+c+QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061929; c=relaxed/simple;
	bh=ewqVQuhq6Ji7qpd6H1IbTQDWimGbfNBbl7BOnbula/k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hecLs+XMj86lzf7KmZ9tAX8p5i45/xNKJFLjmmZNmqBfwYFgBWSdQtFbEem5t+wvZir1CubfAv3/i6g8eiOv2f2cNHdnQMqgsRAx0HXE7VUBLejOlZqZAa6LL4rqhy+clxuxEPz+QeVonn2AqC0fX+vn9IgEZbRRWR6sT7vtlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiITB1Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiITB1Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3D61F000E9;
	Tue, 18 Aug 2026 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787061928;
	bh=GJ30exXgHnmCyDKOf/AWef578dt/UojSDZoIVf+H6NU=;
	h=Subject:From:Date:To;
	b=HiITB1RrTBkb5/UvVAJodKxYpIpGTMY6+h51O/eGs1SzIkG5Duo4R6KyVERKPMLZS
	 tgO4Nii4XRD1h1dWfUswujiWZs2UHsbcLrpuakGPU9sCAe133G1OZ9fZAIVlVDp7uS
	 DDC43hr03ogEBychh513cz25wNR9bq5mleua2NyQ9cbQnHdM8AEy54HmGx/cYsBpha
	 LNwMstDnSFfQHm2TRjEOArUBqUXa6Gqcmamew+la9E+4tw+KUZ7M7SAvKbvvPBhamr
	 UwfrePrGAcgb1Bw7GGzrsvSxAzrjP0s9NPbT1QV2znD6gUMeDWl65bHsZTr2QYFCIp
	 zS0oAxP9KoGPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C2693926667;
	Tue, 18 Aug 2026 14:04:41 +0000 (UTC)
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
 <178706187961.2099143.9407879552177278957.git-patchwork-housekeeping@kernel.org>
Date: Tue, 18 Aug 2026 14:04:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: qcom-geni: Add shutdown and panic notifier support (2026-08-18T13:28:06)
  Superseding: [v2] spi: qcom-geni: Add shutdown and panic notifier support (2026-08-18T10:45:53):
    [v2,1/2] spi: qcom-geni: Add shutdown callback to quiesce hardware on reboot
    [v2,2/2] spi: qcom-geni: Add panic notifier to cancel and reset DMA during panic

Latest series: [v3] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-18T13:38:09)
  Superseding: [v2] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-17T16:16:51):
    [v2,1/2] dt-bindings: spi: qcom-geni: Document ready-gpios property
    [v2,2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

