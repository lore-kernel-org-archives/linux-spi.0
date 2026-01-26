Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0D3446A9
	for <linux-spi@vger.kernel.org>; Mon, 26 Jan 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769450203; cv=none; b=E2tG6lVgmoj+oplL6QZ92BEQIaYL0qm3e7BIt2NOCEhlMYAPdeWdEAc4OUsevG0u07/3Bbvm58hunTFrdlEhBgx+xerTWy0C8vBNm0uDlUXPG26walH0MVib6YRoEFBU4JjlJtV07qiURyFZ0YH2bGJYS4aw8KwLfyRzb0JEEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769450203; c=relaxed/simple;
	bh=E2yJ97K7DSbzZRw+/nEc3+vvU/y2QNShhes3dsK8fHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=D0/94aAze8ure/V/swCCkVdd91TfcX4JTZCFOtjVGDyGciKIRRJ++8GH5lQGzfLIQ6HyGw1cKakaE9YO+9Csk4fbjLrJ8Pzr/f5UEuy4hXS60BgPzeDBgJL1v5MmdIGe4hELcw83BBMuwWQMQ7exHhOvnr1uJwo2cNN7OiuwF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1xjEXCm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1xjEXCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BDFC116C6;
	Mon, 26 Jan 2026 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769450203;
	bh=E2yJ97K7DSbzZRw+/nEc3+vvU/y2QNShhes3dsK8fHs=;
	h=Subject:From:Date:To:From;
	b=o1xjEXCmf493iL9w6RWXTm8COoKit1BimA//9upraSLX4VC6I6jElJW5zei7r+ap8
	 cUOsqpxxb1TGpeAIUYflDzQZ+e0JHkia/xc2LiPHiOHfFVLAPUDVt94b6ct3jPNBS2
	 cPhY21WbKB1r9OLDHhXKn5aDLksorhxyi3Q+ku0twfquoThtEVo4m4u/kVQavYH+xH
	 CCSbiF5ZLKFAANms/YD8aBscsXiJnJLoDxagJL6aMCwE3JLN5QCMReWVcglFKi5ZOT
	 zUWlp05yl9FMesr2ZAP+PXY3OegvpHZgGs+7I48D/CNB+C5LQIIOzGQIZJZxr27gh/
	 H4A5DCd4JwQTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D1C380A94A;
	Mon, 26 Jan 2026 17:56:38 +0000 (UTC)
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
 <176945019754.120487.5462033065409525051.git-patchwork-housekeeping@kernel.org>
Date: Mon, 26 Jan 2026 17:56:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: tegra-qspi: Fix race condition causing NULL pointer dereference and spurious IRQ (2026-01-26T17:50:25)
  Superseding: [v1] spi: tegra-qspi: Fix race condition causing NULL pointer dereference and spurious IRQ (2026-01-16T10:41:41):
    [1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
    [2/6] spi: tegra210-quad: Move curr_xfer read inside spinlock
    [3/6] spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
    [4/6] spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
    [5/6] spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
    [6/6] spi: tegra210-quad: Protect curr_xfer check in IRQ handler


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

