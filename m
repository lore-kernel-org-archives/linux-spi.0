Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080778;
	b=E7TQ4XG0J5+Zi0KlQJ8+s3r3H3fnp4uduU+JlDd7ITf96KqLz6X/u45+buSsWVEvU8Mh
	 xaGYHCD6TM0W+RnZzuM34n93sf/7vbH3rEzgixYjCKQ5Oeh79PL63+prV3xZCyAmcmlmv
	 PHvderxsfALMLvztGpH0Dg7wVtWbRREaXbowxEGauVGx7Bep/OgKjB09lhLee7p5QsA4v
	 o9DrN1G50xLtiNCrBRRwXJHiIARdApaKtGFMp5oZvxaCMZ0zx4yRD18wwWJ+pa40bDTjR
	 xUCJPrJAr5/VoYtKax7o8Po9bCTLbgRJ4J0V1u3oCtvD9ygy879S09jvvwRerCKK85A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080778;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=HZf5oo3qFsUbEA4PvsgJ2FXHJ3MvDXzJFHGo3uSdeTA=;
	b=1DpMPRk5fHLIHDhRA1tpN7SaGsEYtscK2AoR7apM9wrCa7FSRI0tzdaD4uCJ/YPreMzQ
	 HbZm1i/67ExtOCH4t0ub9TC6hNfFVkSdBmSgP60/6LmTOOvEyaEJhmw1OcPjEu+/GsA7V
	 S3K840OgNyBJqKwkNf4b2N8NbluflejzS/P/qDjZcENIBdPKzXcHwQQo/y+Bsrm4ZTPM6
	 KsNAmeTl/7gMEBotMuLqxlxr1xdVpwvwhJvGW3EPZ+cdPwTlmpFcXlobLH2qDTFnFCxEp
	 v/IxZiRLURMXkHYCxvkl7RtARBuW+M8IUEEHOrfalFefAcQl/MsesxyTaOua7x0yX3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R72p9maW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0469606A31A
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R72p9maW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEBD1F01825;
	Tue, 27 Oct 2026 05:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793080778;
	bh=HZf5oo3qFsUbEA4PvsgJ2FXHJ3MvDXzJFHGo3uSdeTA=;
	h=Subject:From:Date:To;
	b=R72p9maWFH6nakoNAgtupAYdwKXZKuSU2O7Ewda/8EH2Wb45Y2xACIhLhlqawo92n
	 epoDTRyfjxfj0ml3VaJ74yGgLK9EY3fvoKodDNZqpsw0FkQ8RhvyqykZavPGxELudb
	 2/rsYeUv9Ig+OumdPg/4FmTHCcvp5paDN5t0etb16Y86OXdllcW+csxK/t4vuXZah5
	 al73l+J3cQgzvnyw9HRocBsDhJJtIjJlVoVejupEKQlEwXrUWEwwbAQG+z47xdqLXR
	 taO/XnKvjCMinIb+uS8yokPFUt2uak1jKXFmJlsWdgF/n8V+yKHEo8iGImVhd0aXlb
	 IqJqSmbKfkvqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4474E3AA8FC5;
	Tue, 27 Oct 2026 05:59:38 +0000 (UTC)
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
 <179308077675.3591830.10716697764728782514.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Oct 2026 05:59:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] rust: helpers: add SPI helpers (2026-10-27T05:42:07)
  Superseding: [v5] rust: helpers: add SPI helpers (2026-10-27T03:03:51):
    [v5,1/3] rust: helpers: add SPI helpers
    [v5,2/3] rust: spi: add SPI driver abstractions
    [v5,3/3] samples: rust: add SPI driver sample

Checked 198 series in 4.22 seconds.
This project currently has 16842 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

