Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E928A3FA
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343518; cv=none; b=pOC9PI0vr2Ouw3LUYb+coDau8ydPILK9miyMr+WFkJWTJGckkT8T+zhKt6VFUvCVPK3Au9hNor9E83Fl0TJ7LmAdLE2NtGSu+BKRb2Wxeh3SI8tzeUz8Evdrs8FNT87F1opnSYDfvB1d38n6d4lQpPCxVZbLsV0V6hM+oQNw628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343518; c=relaxed/simple;
	bh=iqS7gs2VEk69lWcztGM9rMacq4njAu/94GuacvTQ+X4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ml7CSjDp8VH8jYtuem/krBa47WMAxS1JxQ9sxHn5sPwOeZ4i/YqesavyusbqnsM6Dmlymgmw3ExWkJmkgA28bE0bJfzzUxxqR2fFhhUoy7qkSglzL9bmOlq67c4/wjFILy60CzrH9uPem+xoEScsVTI0Xw3H/FIhYu8TgYapH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGUjkpNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGUjkpNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510B41F000E9;
	Sat, 18 Jul 2026 02:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784343517;
	bh=NZMX8FOvaXuBVSS22JL/qj6oVHqKrjUwodnhXp8NKNs=;
	h=Subject:From:Date:To;
	b=HGUjkpNAZmr3Ex/lfBlMhkmxbDzxVH/KYsBrcjTZ8pd+I68FfwtSVZr5diaoYx8qh
	 JpXVBiwXGM/sweTwKBD9k2Iq8NJB1ZgVsrauPuIsY1BqqqwErxTVfEYR6F+aL15Msl
	 Er6qQOPpOgYZjvtM94/OqbkaV3YrJpKS9PweCdfeusIcK/YnZLMWAlAxUklYJ0ZMVn
	 VLuEKENTXTFXL7UgUIshbmBEzbEA8vsaUv7zTuoNcAPfvUGNk4/Kkh9Ipg4jEu8W/2
	 /yajIrUKl4+DjJcB7EOc5MmQbsaVnhRgfzEZW+JgVQWdc0vgzeNdXALwxJHGrisVW5
	 cjKNXFO52LD1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4D3810936;
	Sat, 18 Jul 2026 02:58:10 +0000 (UTC)
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
 <178434348924.2383927.12719215311485707523.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 02:58:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T02:09:13)
  Superseding: [v6] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T01:24:29):
    [v6,1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
    [v6,2/2] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

