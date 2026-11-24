Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534206;
	b=o5pjFmQALAPctHlfA24qb0u2MVkCs1WDwAtE9iOXxjkGK+8rZ7CclZC7nv83mAp8xQGM
	 0+67ltPIH5wti0RtGVWQB7tF7oqrydvU1co4eOnsQ+jWAz5gWgxJQIHPU7AqwS9ex2N6u
	 6a5H5NwD65AYBmrKzd+yf/ugFyr6HFig7rfInLe7jPWRhkP64Rh59dK6pc6UqDEC5PToS
	 qaHYKSczQeQZyzqX5xA9JbiWgdkB6DsSE7EkS14k7WihTIQDbtWjorEED81H9CDEKfL4+
	 SHkdnOUvLa1zCsiuN4kTzOj8sqIBhkdDHnoDS2f9QOijwZpLwbRC1fMFFy5QLxP+v1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=MGM1SIM6bDPv9w+KP9qgy9G+SG1F+u3UCqc3fdL899c=;
	b=ulcQq2FeS0xv1OHzp/gVpkZUJIXLM3gwUwZ/IBM79W+mJrcyWszHCh21GY4MsxjZ9DFT
	 YGL9FaBEaQ+BpUkUIB9rN/0LOkMeoZe8MVxMZB1tac11uhEQq+S6gndYmjLxvfW8ToyN8
	 +FFqFG1URoTIMg/uQ/KTuUfefrslW7K4CNMCbN1/M1kDlnovrBYEPvcWeEfqpm9EnPsk6
	 eZjNq/Gnb8CPIgL5CO8r9rJN60OzzJIDi15/43Gl24Rqip427QVogM3vmmWuDdwDJk1zE
	 aK8R2nWuhsKA9pz5PskpQ6Vj7+iAVIeHMd3lM45hCa9UHYK13DR7SKKMBU6cWYvA0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJpkWKii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E9606A32A
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJpkWKii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9DB1F000D0;
	Tue, 24 Nov 2026 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534205;
	bh=MGM1SIM6bDPv9w+KP9qgy9G+SG1F+u3UCqc3fdL899c=;
	h=Subject:From:Date:To;
	b=QJpkWKii5Yun6Tyvug0ZG/bdtV3HQcNtSDizSHxgM4f1q5DloU2Wh6x6zzM2hbZH4
	 KNK48Q+gJY/kw26MMfMLkm9EacqOnnZusBW8ih8z1OpfZexx0U5jhWLnh97S9R1e6n
	 bsXQU8Bj+EVecCD2l6RPrtilJdDCYusY/OJJ2lUfK38S83av9ivjqaAnGfkmKhCp2A
	 +xVWkLF/41pLyE/kM7q8ygd29ZU5S0PECQ/Q8aZ/1hSy8ZRLYolqycXBy9cVl69Dpc
	 ENcpGgj+6i7qpCNNe3GC+M7QzDeT0N5c6OgsEGoR4iaNMPN+By0uAg6QDMAKowF6M6
	 b5rf9EUewqnlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C8243931129;
	Tue, 24 Nov 2026 15:30:05 +0000 (UTC)
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
 <179553420367.3602143.17569338099224444902.git-patchwork-summary@kernel.org>
Date: Tue, 24 Nov 2026 15:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw-mmio: handle clock and reset failures on resume
  Submitter: Luo Yifan <luoyifan@cmss.chinamobile.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1213320/
  Lore link: https://lore.kernel.org/r/20261117020557.20019-1-luoyifan@cmss.chinamobile.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


