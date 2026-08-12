Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F07218592
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571948; cv=none; b=DT2SM2ks20ipd+il9VI2GTIOQ4fpMSsTpE696dWV69jRdV+wbETUEhyXgPi4JFnrWNT6zcWGC6/adCUviXTfYtIGlje/+Wt/sOEugdYP0l8bFO1UhaDAlitPYen/FZHsVkFF5aFd1LpP0lkbAJqDHRFZB+ICTiHiKwVnHFk50fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571948; c=relaxed/simple;
	bh=55iWkUAO9w7X+bCYNZ/9ReAnOdDGVAMs52Yeoq56y0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JHSDMeJFn0c9f0RQSEW6KlNz5OxEHIXdI03JvKPqgMB8KX6L3TFMsWC0Srentp3PmaxSo9uGU/0m2Z3JGsHXA/6Dq0HdQtF98Xm4TbZ+kNq37SI5bMV/rhU4UKmyXHNRYu9784rhKXETsOA1r5wXbk4hAhcIExwS8fgtOcDqYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaoWS4am; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaoWS4am"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9838E1F000E9;
	Wed, 12 Aug 2026 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571946;
	bh=jXuEvlJiF4nR584J3HrQv4fVxu+VkAiOlUL4lx8wMbk=;
	h=Subject:From:Date:To;
	b=OaoWS4amd3JgilAnzc9460c0QA/MUhC38P2MnEVuW6aO9rLHxEbi1dKXqJaoHQww0
	 voQMuUsXpDHzQeo0UTGM8dGaW3U6zJ/0qvAudr3ENlGJYYjqHE/xI/5pIfwuiq1n8S
	 x8fyBCuBwxmlRfL23fGB1OXxqiSTG/gWFupavSAMBC/SRt+No8/H/XFRqfO0+TDtZ+
	 2i7K4SJTRw+ZF2ISyoaG05uFEIc+T0Sk3WTrDtXceac7JPNdgYvkMOPafQuJ61anra
	 767sDexrAGt1qGFCPJOJ77NrQLbVC0wVsizeqKS2VnowiqdzYBTbjx94Y4rf7cnMuj
	 c2b0eUdPMy1Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A17380CEC9;
	Wed, 12 Aug 2026 21:58:23 +0000 (UTC)
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
 <178657190172.2119039.13889320455508743352.git-patchwork-housekeeping@kernel.org>
Date: Wed, 12 Aug 2026 21:58:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers (2026-08-12T21:02:02)
  Superseding: [v1] spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers (2026-08-05T13:53:26):
    spi: dt-bindings: sun6i: Add compatibles for A733's SPI controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

