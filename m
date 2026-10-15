Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530152E046
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072709; cv=none; b=YN5E5FejR4Jjn6NfEW/lCllvGqezphc+2HeHILWw5BnQ3F1rdt4Fb/obKmJ3vjMVzktuhxqGkIJJGRRzPd5gDFnPnQykOTA2t1gNs6/veZPSYO+wv/Tdtqh3Z9DcFrLITBRzxzCl2ex0DZmdFbwApz0x84+fg5bLMb8U0tw6Ufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072709; c=relaxed/simple;
	bh=6BWN76EmDgPLR54K0EnvTGsiWCDd37QpeO83N/lx57c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NEMmUW5DNtHKhS6JCLi1aF3/a7Mi1SgciQWFFKf0E1zu+E+MUopDsScbfxst+W7I1BndT+8C68VKCKH4BwMsECQyohz7TiVYdpFdIyO5eeHEpgPgOiM4K9QEDJf6FXy+7WdRdSJIhqCsaiP6JAsf3Xwa3zsX0KUz1EV12y1Is6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdOgHJ5m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdOgHJ5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9AF1F000C5;
	Thu, 15 Oct 2026 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072707;
	bh=0HB0uTW3kch1dqxtWB8nXk7H9fvFSGVJ95Rkz7OMf4c=;
	h=Subject:From:Date:To;
	b=mdOgHJ5mct7VFh/XO77lFq94ikkOmTgcz2laRSR1/6gJrDX5yud4Rvq6wsPRpTnnr
	 5OOeq+0rk06QF+fPJI1VmX0uDg4bE0RR376sqTqQbRSdKv/fgDytdLh1j/O/zgnKuA
	 abxbwHrcV41tMzVN9SFU7JM8gQ0FhjNaqQLKbqS3lNKRiRkq6fgtUp4JVlwoeRIVS7
	 2QGe5HrwDT8nlkaYf3DbCfgAxeQbT7b7DrvoihX3k+LHXX2Q6GNPWhcPSveTuAsWtQ
	 6HilYqwgpAd8/xTD5+vss5GqXKEAnoyKYumfE8WUoq+0y2uSTwebMkTb/Ufwz+CuoE
	 RpBHx669IrvZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B455E392EB0A;
	Thu, 15 Oct 2026 13:58:27 +0000 (UTC)
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
 <179207270619.3447946.12705715788921983874.git-patchwork-housekeeping@kernel.org>
Date: Thu, 15 Oct 2026 13:58:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] soc: qcom: geni: Derive SE clock configuration from OPP table on SA8255P (2026-10-15T12:58:20)
  Superseding: [v2] soc: qcom: geni: Derive SE clock configuration from OPP table on SA8255P (2026-08-27T17:59:17):
    [v2,1/9] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
    [v2,2/9] soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
    [v2,3/9] soc: qcom: geni-se: Add helper to set SE clock rate via OPP
    [v2,4/9] soc: qcom: geni-se: Remove OPP rate reset from resource deactivation
    [v2,5/9] serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
    [v2,6/9] spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
    [v2,7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
    [v2,8/9] i2c: qcom-geni: Use common GENI resource initialization helper
    [v2,9/9] i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

Checked 204 series in 3.90 seconds.
This project currently has 16778 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

