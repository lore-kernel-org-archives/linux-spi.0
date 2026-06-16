Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F930C632
	for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575069; cv=none; b=s2ZjiKcUFvIBs+y2MFmNXVk2LktQkfHj0WNXYB2UT8f0PCkh4MChEOxFq+NkJO/cGFoqsWGBUcG+7Gtc5XVzGHe+XHn95mvR1qfQT713//wNan26jYpPLzQLYLWsxqp5AM+4BQvAQSviN4+4OwPaS1I9W7HEJJsZd8R0+K9t3DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575069; c=relaxed/simple;
	bh=umWulZhYZvOv1xB7NMY46U26MLg6ADHOj2v1+1vB93k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OrYv9v1A6BQE8sti7PnF4i+673YSVVkPZZP5FVOkE8XvFbb4Z+yCjgIbOOXdhA1WAhCk7n80/JCwcnx0zZrBsP+tEiX2gt2B8kBRI+D/0QITekvS4IaUwBZ5M68Vj/kgq60PieI/K6rBBiEvCMkbDwc16ZkUvUVUN6vGE3EM+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNSc1p3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNSc1p3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B05B1F000E9;
	Tue, 16 Jun 2026 01:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575068;
	bh=pqvaLSzL6/d4SZSiGcHiP3q1LTk25Y1vnfD5vqr6Fww=;
	h=Subject:From:Date:To;
	b=JNSc1p3naADS2zVIi/m7kyf449/Dy6HSCbNVT5UVJfs1ZQ2k3qUuukkmStwqTNfcm
	 P/guX01Qur/wMZ0TJY8OT1ocZ+v+xc6rgBra1VBs3BLkTM2LovP5F6GkNAbcVL0cjC
	 1cIqzlxBY3DPXjtctMTln/bct0BLQf14bciWAlk9KLCwfiLpdy6rTZkTjJzaWw4qXG
	 Yh/NEIV3JEY8VeR36tEFjURpKJGqpEqYuSaX0SAgtvJRG+vRFzXI8HYwIcWHiBOXkG
	 gvzdg+z6dZ2TvPG8jVyPhzKdzMKhT0vYkS7BVswz5gzUHdcyocPoTYQVHvmB1QbLHH
	 MjAlpEQYcgZVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ACC3839A26;
	Tue, 16 Jun 2026 01:57:44 +0000 (UTC)
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
 <178157506320.384734.14269865626068290921.git-patchwork-housekeeping@kernel.org>
Date: Tue, 16 Jun 2026 01:57:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: uniphier: Fix completion initialization order before devm_request_irq() (2026-06-16T01:12:23)
  Superseding: [v1] spi: uniphier: Fix completion initialization order before devm_request_irq() (2026-06-15T02:34:15):
    [RESEND,v1] spi: uniphier: Fix completion initialization order before devm_request_irq()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

