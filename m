Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5E318ED6
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566727; cv=none; b=f/A7WH+ftlFU3WUh7Pi2mxaiSny0HnJEYNxkcpuiFs7rGZ2E9tnVAXtEzfgiMgvOLm/2LIRJg2WssWEQubAEsv5zPnh9vCjRWaatUBp0Rs9OSaielKlZOvXznaX5gQATt/hEB+RJQqpIBjoijFJr7CQxn+9XIV2CmAhuhPTpnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566727; c=relaxed/simple;
	bh=FV1Q/QrLE408DBtjrqUDIkl/7d3TQ747hgnzfra3lYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SyqAGoDT8o/zAiTb1gv2ubSVqN6BrZI8ogeXosWp6enoQvPbUq3NzpVj0eVDmW4mPpThq0yo/rzgaqRSx2yrf72WdG5ohZYMjR5gdpxsW8ZE9cryMZnK0SrYeAo/gYcQJWoPgDNtoz0d3gXQaDB58pAz2m/vBkKeQtaz6tWtJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6nY1GWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6nY1GWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0A1F000E9;
	Mon, 20 Jul 2026 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566726;
	bh=MqB+FjUuTQsKO+Txg7f544hreEmpVgHdE2zu4gQnqyc=;
	h=Subject:From:Date:To;
	b=j6nY1GWFlM6bXgvAIQYQG7bJdA83sansqehQOnDzeB0C9x7B1gV6HrZTUw0m/Inzh
	 PYHNWpHDY6jaBxFifnn3vHGG7IiLWv4HPkxHIHLDLY/h81Y/c3sg1qvO4U6JRLSJwA
	 4kIuWwySyQLIM9pGxN64GQfuIWC2Uqkzd4t4VMCjCqbMhHMbkWw8xGkIOGxEAIdBbU
	 ce824Q5ufLlYjpMrr+0xCAdmcH2VPDg+6CTIv2ldY8Rd4ma6pRD9/7bAy5HrxJtJEx
	 H8QeGzyVU5nKlE5+h4ML29WY7ES2BnntUTREc59EafiG6f1kq37GI8c4oMsOD8nKdk
	 Yon2GdgwtEWKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D35F539244C6;
	Mon, 20 Jul 2026 16:58:17 +0000 (UTC)
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
 <178456669635.4079702.8448900049045754148.git-patchwork-housekeeping@kernel.org>
Date: Mon, 20 Jul 2026 16:58:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v16] spi: pxa2xx: Fix PM and interrupt issues on Intel LPSS SPI (2026-07-20T16:21:09)
  Superseding: [v15] spi: pxa2xx: Fix PM and interrupt issues on Intel LPSS SPI (2026-07-20T10:40:22):
    [v15,1/7] spi: pxa2xx: introduce clock enable and disable helper functions
    [v15,2/7] spi: pxa2xx: introduce suspended flag for interrupt synchronization
    [v15,3/7] spi: pxa2xx: overhaul teardown and suspend sequence using pxa2xx_spi_off
    [v15,4/7] spi: pxa2xx: lock out runtime autosuspend for Intel LPSS SPI in PIO mode
    [v15,5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v15,6/7] spi: pxa2xx: restore LPSS private register state on S3 resume
    [v15,7/7] spi: pxa2xx: rename local status variable to ret


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

