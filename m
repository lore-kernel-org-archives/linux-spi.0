Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519805;
	b=VmfPa5qO5HPRixemD7mTYaVpHbdDccaqSY7ZhR6b2EwZ3CB42zTJmGfMCQfBW2Pzmsp4
	 heNmTMLcEOlmxb7KNWEtGDiaKyOMWX3PHsgK4bNq9etWsBGEVSN77bsx0MwJl5qf8lG/a
	 hYMp7xjcw4kCbHEBFXVHZxCZ2jTfXNNFSuB9HGmoXvK6j78Y1xRrG45YzX2bAFenj9es+
	 1TLFOgMjeg552UFsNPYuCduodwEG8tu4pVZlE8SvbhWodueGgpStkrFHa7I4+lwsCb1Vc
	 JCOfQILcdyrDfRKksJrVA8jUN3xA9zwwAbVTykJ2RUKrcUUQ200YOU/ZwTlxpE8ib0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519805;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=PJqhm8Xp88iLneOy8db9ftu1hy/GEfFtMJg3QEPPEWs=;
	b=M0t0H80t4oJOWU4R4XOV19Kpb3foOu3W4bs7x2DmwWX9SeTS5p5AUSE3dqu7LPsaVUIh
	 8JBXDxyQW+Llpos/k/uza0JM7Q94843SjcX/E7pI5E+ud32KyrMK8zWMh/QH1XSxX7kIh
	 fw+ygf8Q4XsSPmYtHVUoBP4ZKdP0oQjvs9/Gy2KX6NeMx/XQ0NCrFneql4W6JvlCGVPvS
	 TDqt4lNYVMFkH6iGrMi7h5yofvhvIkt5XHGu9BIvwlJd1jWkuO0DL4cDqOZBGpKO+kEZ0
	 pfvfrHdAOjg1NymKFmOpK8zuRe+3cniRYkHy4WF+/soRzocasWtSnjoKzNJ6lMU0Q1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKTCpMZ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD321606A327
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKTCpMZ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EB91F000CF;
	Tue, 24 Nov 2026 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519805;
	bh=PJqhm8Xp88iLneOy8db9ftu1hy/GEfFtMJg3QEPPEWs=;
	h=Subject:From:Date:To;
	b=EKTCpMZ8yGG2p6XbNJ3j4KFFstliSn5tklGq0ft++FLqEtEGL7CbT6oyIH8meZCrL
	 c6+LU7U15idFfY9a3sVIVKZwaFdLQYxoy3aHfgeeuoZnBbv2uf6PyTQc8qtZZGzE8N
	 f6JXoQTl1Y0IMr0xHPGhxXEtH3QPEpx9zInJPp1ObAKZBUVYoUVVxvPiZ7DwpdGdse
	 z99P96xQTndTcmRqMlukk5dvV36EpVRNsuTDiOcYj3acjFaTYKHben+dvKdvBfok5X
	 rZoFnc5AKC8dLdhSS8gMAlQ6+h7cIlzyhBPtb5OMN2Xpcv/F+MIl6AJWG+A9spQaFk
	 vRiDAAR4xNeEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C8E13931063;
	Tue, 24 Nov 2026 11:30:05 +0000 (UTC)
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
 <179551980382.3464308.13277001710501561491.git-patchwork-summary@kernel.org>
Date: Tue, 24 Nov 2026 11:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: geni-qcom: Fix sub-byte transfer packing and length calculation
  Submitter: Somesh Dey <somesh.dey@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1214989/
  Lore link: https://lore.kernel.org/r/20261118-spi-bpw-fix-v1-1-e475586ca8e8@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


