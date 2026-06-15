Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B1128816
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781492260; cv=none; b=IDm0eaAF4Ta4wk1Xkojzmc6Rm5rg1RE+O6eoafgSNWIR/5lZN1CpGjKDfWK2fCZCnn/k43PGmBriovXKbOTJKwLQ/fSxriM/n0bkU2uGm3motAQVs6py2i6kQPa3Xo3+VqROsyc5o39bj7pXAxplvth+NAEaxEnmuw68QQszOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781492260; c=relaxed/simple;
	bh=zAzfgPgw9rJrmAFkOMTMWiHCGv6dqjM3MdhvD8e0bUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I2LxZ1FrzTQlVFIvwM95F9gMEGm/YVup53CvQQCcbIFTqDUxH1LngKgwmvtS87Ru7m097I+AmHpWveltjV8eRbenfKcXtcno/NGL+3jr6OGo3UmZVAI9AysRL2mfw4taYpD1VjdiJbVrSXMPM1O7EThWArYKRotZQu5zCMUEu9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQQjqKCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQQjqKCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96881F000E9;
	Mon, 15 Jun 2026 02:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781492258;
	bh=P8JbLL6fcmprzR0u/Oj/v/3W3UQzz7gYywYvVTK6PDU=;
	h=Subject:From:Date:To;
	b=CQQjqKCupIWby7eyVCEZ0XHBzEz20+bjVs3dm+5m83P8S64XZKqLHnNIucVa84CwO
	 DO9n+7qJGqQlllX8+zwedV1Lm/9vHi6La7ao5VLBOLqxdc9mBZY7BfcWSK6drW1AR4
	 UnyMFqQO21Nw3r/vxcGaFpfea0fXPXjWgj93qGzamgENLVe0llbGlbpZWL3V/PKgfs
	 Nmpe63t4bJ4TGMTXZ21Xyu0m005I30ACqWjaWWB6Nq4Ob6JoDcksEA3BDl2izhLffy
	 tXw0P82tA3a6qUBQts7LJClCuqVsRa3PRoLt9b8FzSQlLFgmKX2BiFtvWdjvcgI2JY
	 EoGc7zAVOEN0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9629D3A566D3;
	Mon, 15 Jun 2026 02:57:35 +0000 (UTC)
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
 <178149225412.2397070.17304886678607824735.git-patchwork-housekeeping@kernel.org>
Date: Mon, 15 Jun 2026 02:57:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: uniphier: Fix completion initialization order before devm_request_irq() (2026-06-15T02:34:15)
  Superseding: [v1] spi: uniphier: Fix completion initialization order before devm_request_irq() (2026-06-11T11:31:37):
    spi: uniphier: Fix completion initialization order before devm_request_irq()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

