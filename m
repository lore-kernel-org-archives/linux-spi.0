Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C391030EF68
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189508; cv=none; b=Fg0cYALIuaF5lqtV0M7xgGCCO5Fs17uEUUskChurXpdcFq35XzoeL5YFI4YNULxSJ7+xDUceneI7xC/fVbAZ8QxkNmqT8U4ycE6Ddck4ViuC8rw9SdQkBSc2RLwRALcLcBqKzql9VshQfb/X99bQGI+E5niR/WipADozFHaG/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189508; c=relaxed/simple;
	bh=3NVIOJJi31HRvZkemX6U2SheO45WyDU8+bARJRpnOdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=l61uhbiYepfCpp3PzuTV0kLTn/F+9pi/+6t4Go8g4EqMkxfiTsDDZ7KcpoZiXI7Xg3/Byf8lh0cnFKkfnbhcpV6Q9GlqQXRYH5lUX8PcKK6nTMvrq67rf0j22mocfbbzd0kdqNJmp/UCvlH/iwofr/OAUcyjA+p7cuMO2S5pZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKdiXK7g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKdiXK7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659F5C19425;
	Tue, 14 Apr 2026 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776189508;
	bh=3NVIOJJi31HRvZkemX6U2SheO45WyDU8+bARJRpnOdY=;
	h=Subject:From:Date:To:From;
	b=mKdiXK7gTo+gV/B95YQ5qWKXlhWeLCX6VVxck01Q+Mp6iYNxVebfa+ojucCnstHjc
	 dOUqRvgkdiFqbXvpfMoHfmsLHV1CjRRCjh3Rp1MtYZbnrJLm7JFhTGa8tNkYqmot6p
	 hwbdzEULvBdvAHOsTr8u5b2gYEPQx2HSod+xpyGF86Fu+PGFU5lLjBBigvDQb3nbfi
	 AO/4DPcXe3tBZQ88DdtqiGNlm6RuorxKKWUE/kMC2rG+MwuSV4Hc4CEmAa6i7/kBLx
	 ja5vP9x23JpxY/lCJgaFePrvT6CWnEz61vjjsJ/5nicKuJVeKj6MyshJFl4QOvvbVt
	 fZsvrXTEM08Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 043553809A0A;
	Tue, 14 Apr 2026 17:58:00 +0000 (UTC)
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
 <177618947856.1401994.2799118589933760254.git-patchwork-housekeeping@kernel.org>
Date: Tue, 14 Apr 2026 17:57:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add QSPI support for QCS615 and improve interconnect handling (2026-04-14T17:08:18)
  Superseding: [v1] Add QSPI support for QCS615 and improve interconnect handling (2026-03-24T13:13:17):
    [v1,1/6] spi: dt-bindings: qcom-qspi: Add QCS615 compatible
    [v1,2/6] spi: spi-qcom-qspi: Add interconnect support for memory path
    [v1,3/6] arm64: dts: qcom: talos: Add QSPI support
    [v1,4/6] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR flash
    [v1,5/6] arm64: dts: qcom: kodiak: Add QSPI memory interconnect path
    [v1,6/6] arm64: dts: qcom: sc7180: Add QSPI memory interconnect path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

