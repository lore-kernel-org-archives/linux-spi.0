Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC03E0241
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784393923; cv=none; b=rb0hthXg3sq83t6wCBbe7/yaCUvwfPc0/sC8iNjxH21iV1EiRXJWZLnvayZwc+u574mIjGtZzef0D+HEQ2UL3E6SDdmkqjr3IxROzxxJDrrTwkSmrcS1Nu5w+TxvlHU61jhUG21d8hsg/f2LYdMKNvxjqd6UJU2CXC4yOwqHb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784393923; c=relaxed/simple;
	bh=oEUz4hGnmz7FRodqi3NeEc5D8JwwtI0wzzYIGRQz/mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q48YVQCJezVsJjgzjAbWntICWWG1V4DkP2hswO0n8RZf5fkm0fOmpNs4NPQLdKLc2HAqN+PBGJ6pcUb3QKH5qmccS9g6n/+tw1MAU7JRFVzZ6HDbpLF40GzLlu/wbZDm2q48UF2oadJM5qVbFhEkRR6iqjdGfk46EH+R+xb4GMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbSVV3oy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbSVV3oy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FDE1F000E9;
	Sat, 18 Jul 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784393922;
	bh=eiOmngXd8ZXW9hHr77YSi21iGM066XEalpSWmCZoDJo=;
	h=Subject:From:Date:To;
	b=MbSVV3oyZVLMJjwzfUPpG6i2SRqjyLJZBu5jEL30ywNA2BrP6XVPsVsaV/AVYiAgQ
	 PS9UcPIIxcnW40g45Dn28+Cj7yiDLOkFO27C4n0knHpxny+tq6EPp1OMltR8RojvWd
	 unMs/xyqbaHXT6i/CfG6O+KdWjReN3ycr5Scbr3yMX2dALck0QhouyTBG3T2/W1sg2
	 VKwA6k69moA2WmS3xF7yuLLRCoICl7U+MKD5VDA0tGmBzVYW9q6ELeeaqmap66UwXd
	 BbrPC5NYxHNA0iJDbHdmngiPwOaEhcuT0A2KXCMBm6B39ffIDIFPngRi7aooSdjR9W
	 m3HnDBOHqI+AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3C083811977;
	Sat, 18 Jul 2026 16:58:14 +0000 (UTC)
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
 <178439389343.2535854.1396778076346422981.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 16:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v14] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T16:06:59)
  Superseding: [v13] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T15:32:48):
    [v13,1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v13,2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
    [v13,3/3] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

