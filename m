Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520405;
	b=tIOwhaDlaH8y6iu5bJrX2nAY5fb2qFVtXZuGNK9YNsN6DJo1lot2TfgLq36CU8BkuJ0V
	 4BF5p1Z0QY/QWlypBoUHT6o6cDAzs1/rSCqjAftovmo8uu1q9VieFlze3t9zHClMsQOKO
	 OaXt7CP6+LSJvCB/SPek06fFPVUYWxCMOzfQoTma9CUbaPdo1Q+qFBsHOPuYQ+FqLLeyv
	 bsXh5i8M2+1a45NroHtytBFr+l23GJACGz6uOFDcP757JHXZXqLKeD8g/fZg+Keo/84WC
	 fY8IoqhWdeA1kEVwPjd7f2xpJEIiFcXdFV+SmQqoORUewcXgTdKQQnYL35bb6Kfbmlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520405;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=wcaup1zib/sxVTglI9kiBLdzkBPnbeXkKjcKTMyvd4A=;
	b=jroAOlpRRP2R6zkFEPjHmwCpMIHVJDHFD3PKMMZYvyCqGml9xHCoWC8kPWvKp2llNslp
	 NxCGC+NY5HFPzbpvTAEmxteQyn07J8C7s78jlcrIqYb8u+Te0SFjqMDH76rMcMmF+YGtd
	 qj3DRHoxl55bBtqA+rpwTGPx4WCO/VWggfa00cN6u2GO0oAaA+ZjycTkb165EWZrmyPRI
	 Dhi1jVb7WhwhcU31S5v/ll1DU011lEnSx07pxh5hNKo2+4L4JVf8sQvCgRTuVgxtIgof0
	 MZN6ssYbLDFEdyZew3IclKnqGs+DEKNUPRb6iOD5uR2KoMhHWX+MEqFETRjQD1JcWKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6Fw6qc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E4606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6Fw6qc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AA31F000C4;
	Tue, 24 Nov 2026 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795520404;
	bh=wcaup1zib/sxVTglI9kiBLdzkBPnbeXkKjcKTMyvd4A=;
	h=Subject:From:Date:To;
	b=h6Fw6qc32sDzTzYLI76hiQxx1Z5blwmLPvvOIH2t6p1wf+ZGDiNSIcR1ohSEt79Do
	 dnDk5MLNqpHH0u7nfQZGbNcHBLMfMcmP1BF6pgOv7+KbZV5H6bjZRQUYDviub8OzAP
	 MkIZKDHdQiLlQ4ytQJc4o+UzTgyGI+J6jU8ZNsdYgaSzwQwcyv0+yhzScuLUHY5W9M
	 eGArj7Qy0Y7uyuCgVGkd5uC9iW5Vh5aiskZhAD9iC2SOyC5H7a94z6afWhvy2Jdp6o
	 Yp4LiZe06q0EXRCeOEQj6vN1o+j1OWhJO8CgSRqJhArBxIhd9/H2oa7PLpPMzx71UT
	 PGU0SZVB/YwbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79CB33931063;
	Tue, 24 Nov 2026 11:40:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179552040301.3468865.16482346723661721231.git-patchwork-summary@kernel.org>
Date: Tue, 24 Nov 2026 11:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: atmel: poll short PIO transfers
  Submitter: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1210675/
  Lore link: https://lore.kernel.org/r/20261113-spi-atmel-poll-short-pio-transfers-v2-1-f280762685e2@microchip.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


