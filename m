Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792551569;
	b=ui8Cn5l8PZVICSJsx9PEj/ZAe4T+DsmkBZXOf5EpaCuCPejMTsmX1q+Fc04jR/dkq9TL
	 iQZYiNhAUZX60NHrIRAmMbDReJ+RQxMfhJFbC9a5ETcZRDnOM8s3bAm/UoKflxGybNAqN
	 fcf2Vn5BoPCrmJbpb3g/QzYTeCccapAlTD4jQIpVbWAxhVirkTov2TzCKe5KiqpeBf/1o
	 a40I9LpHq0ZbWKq0N3CNig//rdsjgphC1TJW9KusibetDmZ8YYqsigl5eJ1TiFBKVnzdX
	 JW8t42nUbSrWS+MeOoY2A/jOAt0nZUEulSy3X3eXMpB5MBTYuPZPP48WfVR09g5qD8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792551569;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=HuMIXEliHhKb903tEvzQGIo8gwUgPH2U0p2/Lesi/O8=;
	b=v7HIXb0BkvfB/tDhYu14Nak5JEaSvQPuhdezp9e7PZDfK4SCUlZnMm0m/CnH0emrj3En
	 rXJZD4Rq6tO9f3r0g0/qHk8wHo4/uItOLcEHAN+bDYUlwpT/Zh6NUFin5LgcNFS7nJq4W
	 D7s4sAEtqCWCh2J73+Ae4MM95PBGTFgZxMir1x3oavA9oAAYNj69NrHe9iYNsLj9GNxTg
	 eaGYzHsIU9TM+sdzkvctJkKP4Iv9RMVwtc8C9IdtYl/URdjrMt+xcKxF/JzA4b2zlWr9M
	 53zuKik7JiVC194iA6KgscjgX0dE/YguQgDDczQ6140q/6TQWGTJb06fE6nmIECsPQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpTlBRA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB8606A319
	for <linux-spi@vger.kernel.org>; Wed, 21 Oct 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpTlBRA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064F81F000C9;
	Wed, 21 Oct 2026 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792551569;
	bh=HuMIXEliHhKb903tEvzQGIo8gwUgPH2U0p2/Lesi/O8=;
	h=Subject:From:Date:To;
	b=LpTlBRA1jnBpH2wzNgsAhDh2F/kSReeySdSgtdDu+VK0vrfc0uW596C4I011WEOvv
	 55sySRAl6D2GfWfYfdjh4s2yt7M3OEIDWLFh9qxWXFnHuIw6ghjB374JDvy4NABheE
	 kVPtq0LUEm8vyIH/N6HTEqao8i3t0BPhKhkK/IQ2Q1P0WFLFvAhW65y3KJWQFotDGM
	 w93Z7/XUb/F+bFe8i2SvCzKxnHrnMWjqVIusazcKWMNlpwq8TS0OjcAVTtOCdcGvEr
	 HhATVPbpGRs8wCrO2mTkmO1WHP6OWPntA86LzglLxjECMqVb6T/Wc1M9JxKMH2I9kn
	 8Fct1Wx7tI7zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15ED3809A18;
	Wed, 21 Oct 2026 02:59:28 +0000 (UTC)
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
 <179255156755.348650.1847240228212660564.git-patchwork-housekeeping@kernel.org>
Date: Wed, 21 Oct 2026 02:59:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: add multi-CS and multi-chip aggregation support (2026-10-21T01:56:22)
  Superseding: [v3] spi: add multi-CS and multi-chip aggregation support (2026-08-17T23:32:10):
    [v3,1/6] dt-bindings: iio: adc: ad7768-1: Document multidevice support
    [v3,2/6] spi: support simultaneous assertion of multiple CS
    [v3,3/6] spi: expand device name to include all CS lines for multi-CS devices
    [v3,4/6] spi: introduce SPI ancillary device with lanes
    [v3,5/6] spi: spi-engine-ex: Add support for multi-CS devices
    [v3,6/6] iio: adc: ad7768-1: add support for multiple chip aggregation

Checked 198 series in 4.55 seconds.
This project currently has 16796 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

