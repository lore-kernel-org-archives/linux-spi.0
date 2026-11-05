Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793842206;
	b=Kh7kf2yBk5ONOFGoGbt5lIvZ33bMtAeY8nUNcL1KgMeE/Rgt3F9+MBkQSPbBYnURdzN0
	 DmCAg8dhW3xik/dTqOKh3dbxmHLgQIYy19ZN/ZbzDekdREAFsfA3qyEaTOkqxG8JzFjFf
	 m7LqMpZgZMEMCul3EFh+eRZVyoX8lKGPF9HcRUCsm9w3u7A4k8igkKtLYIOEywO0LD5CF
	 nTtDAcMQa3oMxSeFNAFIMXpmWWxUhv1HfNHZ2FgGcIR8xdXNY9erli5Ori0jWW53mTzBn
	 CwDYuJ614gabHphVsjTCJkNajMXBfr8WGqbw10TDZwV9XK9JXAutJoH8H3E8Glg36XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793842206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Ex6R6iNdZcbnLdkjqLZGg/qaiD3DzFljIkAsec/pgOs=;
	b=ZJ0pWzrdXJmKhCpw9l9e6a4Us+jbylLIIdUxPp0YbIu994DGfJySt8KSLmqXxMwYS1RB
	 PU4xe/32JdY8V5r1yRpARRZiRTOyDCKtU11RrTyo09Or0I4qWAPULRvwWmKP8q0BANn/h
	 nNyGxBS5hXoH/yYw9SJGjne/+QBD8G4zCO8xCGC4PTNyVTlNHyy5Vq1k9vu42mQNxZr+F
	 wJ7OguqjSVSeVekN991W5e+QzZMxyUDOoJno/FDvCwWtX6nc6/9RdvXxdH+Co7ktpcLYX
	 7+e+pki8ouv6gTTuDEaqkfkISvSzvHLb9Jf+9p/SX/frWMvWUCZA1X9wiBpDZT2hWKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3fJnCC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABC606A32C
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3fJnCC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4B1F000C1;
	Thu,  5 Nov 2026 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793842206;
	bh=Ex6R6iNdZcbnLdkjqLZGg/qaiD3DzFljIkAsec/pgOs=;
	h=Subject:From:Date:To;
	b=m3fJnCC9CVWXf0uVLy5BunFu5kfXHLv0Vc1roP1BiQM9iuRkYraPi4m+VHRSBpN4K
	 3kLvTWNEXDa2KKiIL1oVK+RUich3uCdcnbWGg53eNeowYkYKLQqGmMQDNw3yUkqy6T
	 N3RgDcAzUJUXdbhyBe2XMsllAFDzepTJmfmxNyq6zV3P62APUDoquaZz+Ya5u3q4Qe
	 A8VT37iBqg8yX3R4N8Wdljw7XkGRsA8TYZ1RqShNa7Q2xGjC66o1mXE8G9PGwBti6y
	 UQqgsWBcMsXxxYd3DZUm6GU33N9hJZPLKp0PoFM+hR+mpENWpBfwa0xW6yTlneIs2E
	 UOsyMgcb4XBbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0590B38003F7;
	Thu,  5 Nov 2026 01:30:06 +0000 (UTC)
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
 <179384220461.3342012.3194926231397920529.git-patchwork-summary@kernel.org>
Date: Thu, 05 Nov 2026 01:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-quadspi: Fix race between DMA completion and transfer start
  Submitter: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1201390/
  Lore link: https://lore.kernel.org/r/20261104071958.2405117-1-radhey.shyam.pandey@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


