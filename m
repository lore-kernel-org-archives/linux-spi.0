Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15E2EC0BF
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201790; cv=none; b=tAcOO+Qc91PgPp7D5thiAW/F2rcqARtHSoud99QWHFsPmRv7lZDFKlci8eAmznmdGo2FfYVjIaE41Eqxrku9EImMsyrjGVJwv+WxgkzcFoQJK8a60+OGZvJ+sCCD4AjR5pKnpP81TecqrEUUKiC9PY6WvxjL5AXYsFizIgBs3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201790; c=relaxed/simple;
	bh=XzwgQ8PtobCNaBJmVI68bZuZ55CiXkwxhCZN7lDG3Og=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=igWg+xm3BGcsKrlSb9lvTzX9YLyTcpC2m3EeODRDoBmaJLicM+f/hB2oXFIbcx7v0P+/UR3q+MJqK5yjJdsdN8vQCMyNpCvSF5ttMDbGV3Xs5oyES1jOlOUOuywBXJVP7MWeAzTz7HVLpqixRn/pSNEUBZuhzcMdrou9FZgGSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry+DFpKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry+DFpKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA59C4CEF1;
	Fri, 23 Jan 2026 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769201790;
	bh=XzwgQ8PtobCNaBJmVI68bZuZ55CiXkwxhCZN7lDG3Og=;
	h=Subject:From:Date:To:From;
	b=Ry+DFpKP2vBYAT4PG3OENJxFGZ/GdtAo5yXha4O7xh86/X3GVayqN1YPYqKUFI+zL
	 HqNW7pe1tZaJWzjPpSUp7zYOAyxOda5AtSdUxmU+WxYD7iEP1ATR2/+iIqr9Q4CCoE
	 StSyOnBhpxyP6YnhKQ9VdbW04GYSwlwMtETYO+E3ipWsaQSZXeYMIN3991zZbltWqu
	 PrGS17q+iE5t4pngTOmD9MEAm+qmJiIndWn4/cvygTtqAZYVw9ShpC+bD/EdiGBCCs
	 EEUbe5SBSiWm5dt4y9uf0cboay2COcstL86euyhdg79Y1C8u9kuXIf3avNgA5ku5jh
	 nQyRSUEPznMzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A913808200;
	Fri, 23 Jan 2026 20:56:27 +0000 (UTC)
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
 <176920178571.2713484.13855787953998465838.git-patchwork-housekeeping@kernel.org>
Date: Fri, 23 Jan 2026 20:56:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: add multi-lane support (2026-01-23T20:37:23)
  Superseding: [v5] spi: add multi-lane support (2026-01-12T17:45:18):
    [v5,1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
    [v5,2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map properties
    [v5,3/9] spi: support controllers with multiple data lanes
    [v5,4/9] spi: add multi_lane_mode field to struct spi_transfer
    [v5,5/9] spi: Documentation: add page on multi-lane support
    [v5,6/9] spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
    [v5,7/9] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
    [v5,8/9] dt-bindings: iio: adc: adi,ad7380: add spi-rx-bus-width property
    [v5,9/9] iio: adc: ad7380: add support for multiple SPI lanes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

