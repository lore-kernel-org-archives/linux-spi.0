Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFB533C1B4
	for <linux-spi@vger.kernel.org>; Thu, 27 Aug 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857148; cv=none; b=hM8Ompd25XKo+SEX2tm5xS5+uqNaXCme45W4qe0nrhg/K73Xu04S8fW55O5cKhDFJLBqkeB2I7yLVw4o1p15MMIzgGsYIf2UWuBuBc5WlhVkvCWIsE/qBlqqBflewWWeNyUelk6/hFzpeJ1n71xXk9EWYDnUM3CVYXWOiEqF9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857148; c=relaxed/simple;
	bh=0+zXbxOWMFantRfxhOVQAAhi5Zs9PzeN8cMiLJ33uRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EJPhafuJ3YGqK/SpLzvWIkaJGC4AjG5tJJ4MBCqHgFcX1ekqpJLxUbaafu69ilFiCXd98Y0F9h7HJAqpKID7RFOf6ry5pUcti0pg+KDWOl6Mom96pTQUhLF8IrIZQZV650gWBUOPWriWlIC1m2xGkLa88ohblHC1KDQ0VdoYiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhzbd/jt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhzbd/jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52F1F000E9;
	Thu, 27 Aug 2026 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857146;
	bh=pwYg4ohbU3bWfO5et5X9eXgYumpdjjWC8hRtAh0l3/k=;
	h=Subject:From:Date:To;
	b=Uhzbd/jt/sPu+VC9b+M1rcds2LW4YiFvSZW1lHwsxmC0HADOEUOgdFyc+oyNPJPE5
	 lnr8CuQJSQpAIgXUo1M/ab7QjGwTZ039HGsZXx/wIDO4U4ZhOCNMKCQskZDatvFaaU
	 aTOg46S0UNQllYalFybRxSQtwb+k8KHEFKu8NRWaoIiQuob/tlew5FYC6TykPJhjN/
	 spPs6ZaSfop65ZMkj0hFd7OOeOkL/y8p4pMVpO0rD9daMLr/+vfV6M1xprcwk55fdK
	 JPKRNP+CClPleQFlF+pt9buxu46j2XRqTGMbh0/H5ldBBiU94YwTVgorj0i5SHATRa
	 l5BkISuBs3J+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398A3809A8D;
	Thu, 27 Aug 2026 18:58:13 +0000 (UTC)
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
 <178785709224.1800306.14086050079203494090.git-patchwork-housekeeping@kernel.org>
Date: Thu, 27 Aug 2026 18:58:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] soc: qcom: geni: Derive SE clock configuration from OPP table on SA8255P (2026-08-27T17:59:17)
  Superseding: [v1] soc: qcom: geni: Derive SE clock configuration from OPP table on SA8255P (2026-08-04T19:57:38):
    [1/7] pmdomain: arm: Fix -EINVAL from scmi_pd_set_perf_state() on state 0
    [2/7] soc: qcom: geni-se: Populate clk_perf_tbl with SE source clock frequencies from perf OPP table
    [3/7] soc: qcom: geni-se: Add helper to set SE clock rate via OPP
    [4/7] serial: qcom-geni: Use geni_se_set_rate() for source clock configuration
    [5/7] spi: qcom-geni: Use geni_se_set_rate() for setting source clock frequency
    [6/7] i2c: qcom-geni: Use common GENI resource initialization helper
    [7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting source clock frequency

Checked 162 series in 4.22 seconds.
This project currently has 16409 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

