Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1938F22D
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386711; cv=none; b=SuR54oPZp7xt/YemYDBBEFS+XepQXESKp0h2jLDyzmlhwN6d4ex0yJ/Y4VeHoENQveNp7HU5zDEQYIzNZnjUREq/IIljgVoLhywGVb63ThXhuoQeKtnOuBMBM8P5w40JLEgQAr8jI7PUK5vXNS3ZS51rcn70TTg+FQHKOFZVp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386711; c=relaxed/simple;
	bh=3JiIvacJ+EFFEVlSYdyzAJnmCaO2AfYFr1TcpMUbwGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XWzzVBMg/Q1USO9tUZA20mt0EYbbv+cwDzz0KoTwqGLJFg33txBVYX0JbILa2Y7XKJgDMeFAX9yqVdWX8iGjclbFP8FZYjbCCTnLs+JkkSU/d+4fELMZ6OBHmvzgh7xfftTXfBgfw0TP2DulmNIPdJWUs0yIulXa7EOSDDiGlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW4/LTIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW4/LTIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9261F000E9;
	Sat, 18 Jul 2026 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784386710;
	bh=Qiq0Au81Wy5CbFML9Ryg+9ucKsONaKH+H5MIrxP80Kc=;
	h=Subject:From:Date:To;
	b=EW4/LTIqXzoON072v0XWTorP/vCfuPSYIhOlC6vjxd9N7mCf9treCra86pZfJgLPv
	 wx1YajkF0CbVSKwDrlxXtuMtuGndwM8worjUn248szVY0jzY29wuJxM+kI744GffQM
	 Tj7/J44IPIo58N7hjrug/OtjdE+2KldjaZM1uvaPhmR47TivI2Vd9WMxwBSvmL7YnG
	 nOPUjNsumOki+RhI0p7ip0CMZjOoHBh6YYlqurSkUCJMrbnQx+603bXCwPXdSXyOeF
	 jlu1cJcJeDjPcfd5aRtHG2mjS5gk/fz4psLQJ+gPCvFQsxzMqKisplf09995EzfciT
	 YtXzKv5xAzeig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 967853811967;
	Sat, 18 Jul 2026 14:58:03 +0000 (UTC)
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
 <178438668220.2512970.16503237480379910291.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 14:58:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v12] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T14:52:06)
  Superseding: [v10] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T13:14:28):
    [v10,1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v10,2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
    [v10,3/3] spi: pxa2xx: restore LPSS private register state on S3 resume
  Superseding: [v11] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T14:00:34):
    [v11,1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v11,2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
    [v11,3/3] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

