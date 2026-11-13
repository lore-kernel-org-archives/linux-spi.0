Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549529;
	b=wHdUvpHK6gvUOZS1WMKycfkUSObDSCCzUanFeZFB2udCpJAKrcireXmfc6iA7EJxdzsn
	 d2qjmVYXFpeS+piq2HzRpq+55zQ0WYEYy0brHuKMnufNPHkqAGUOyU45eOjWMQTOtDL35
	 ocni3+gGsVkZLrI/MFekAmog+VXXNt2F9Jzo4ccoZN9STw1yLPdxJj+psYmnoDlvuKdJy
	 xCFVAfORQ5eVO4QFGEZXbU4OZTJZ1HDJY8JNkkWbEgEnHCOMvO4cFVKzl95zkEwDOoq8B
	 OiS6Mcta0jjBNdhfMVZ7HJZEeILIZiN3SccvUljSCcleryXeavNqxqwuSKn1jvZkueQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549529;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=3ShSsQUr3mLkHYFJEz2BhDKiDLcssJ41KhdouQmu6mo=;
	b=tiUpHkqV4cKVQ5aOZ/EUhylsj4dO0DXnCgzjquDWFXQgzvZVCdwkeEQi+64noS8FiEGT
	 0mQR4A3mVam99NG9Vne2JkHg1BXcarbiF/NfCfc+J1taqMzWvDfocRMxNjwqpkerZ7lQK
	 0HsQgpOY1ZkutqUsD1FhS68VcwGTHX0E7N4zvr6Olm2cu80tIDzoekCm0gM4omAvybquI
	 SKjrjj+DGCJMgr+5+R8X9NuonMS/PCxO9LyXyVjQVrXbJzZ2D3y8lMaBBv3mWECgiOxNb
	 sDrCg+Q2IU58fBiQAESEiwnh+6PEs2m0ZwDpzqyv9enSR4j/FwMKq9rL3SQdNSwR+cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmsbxsEy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E36606A31C
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AmsbxsEy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE64D1F000C4;
	Fri, 13 Nov 2026 05:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549528;
	bh=3ShSsQUr3mLkHYFJEz2BhDKiDLcssJ41KhdouQmu6mo=;
	h=Subject:From:Date:To;
	b=AmsbxsEy713tKNR72TsfzcvTtpAz6GbfumfbCA1uHSGkXnYoRN5A14i7u6EDRiUQb
	 toJAhS2lXqNIo8HYT1UJnYtJdK9DX/lTmuuXrTXpk3g+jOQo38rhKgT8YnkR0q/4CJ
	 wUMAtY1Bi7TqEnhkSsq65Ry1y2GhG5qjHmDBUWRK9E0i6a0R9YjA+iu5Q1R0fRqhsh
	 w+e6HU+jvCvJJX7yc4JtLdkFhPbKAvY3wI6z92V28G2dYwMsIriz5LFp+YLP/wzb/l
	 c7tGndcP2V8Jjx5QJRtOHmUSb1BSYbkflHnhwbwyOVVu8+TTYPUg90mmFcRhPPZyW9
	 n02w1ygf0CUGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45CB39263AF;
	Fri, 13 Nov 2026 05:58:48 +0000 (UTC)
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
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179454952732.824414.15701618296256595320.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Nov 2026 05:58:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: loongson: Fixes, cleanup and IRQ support (2026-11-13T05:42:22)
  Superseding: [v1] spi: loongson: Fixes, cleanup and IRQ support (2026-11-03T07:07:47):
    [1/8] spi: loongson: Fix incorrect SPI mode caching logic
    [2/8] spi: loongson: Fix CS idle state for SPI_CS_HIGH devices
    [3/8] spi: loongson: Make suspend/resume registers PM-specific
    [4/8] spi: loongson: Fix clock divider calculation with explicit table
    [5/8] spi: loongson: Support ACPI clock-frequency and add error handling
    [6/8] spi: loongson: Move private definitions into the core driver
    [7/8] spi: loongson: Convert to regmap API
    [8/8] spi: loongson: Add interrupt support for SPI controller

Checked 217 series in 4.18 seconds.
This project currently has 17052 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

