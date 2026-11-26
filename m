Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726689;
	b=CKiJ0mvMUSNVKTK/axys6b7IhcX/7GJ10zGK4TlohMq5M2kRf7oejz8835BM1nuUWpc6
	 sONdivl/+P1v7s1ijMeF9WaFVtc3YFAyM909m84iQPYglZkM8G9grIW3ORX4QGqQaQc1Q
	 FzP3sU575zN6FIjErMbQ0h3u8jJhI1/v8gaXvGuPm7++wOCHEp77HO8mWsgSU2x5iXnx7
	 BoYUMBY+0gHj0IaiYapm/sFrATlifLVDciqw/ZuB2dDoNi4R5D/EeRWLt86+QW7Lm/xch
	 nbYot8VdvCHCdE7tFMlR82vkaqbazNjUlp5aAM26aSmR5xgYRDp3D3H6YwwQ5e65u0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726689;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=ULpaDOsVWadbDOqcqnWuOV8GR4bNwt0jZXK0HexESRo=;
	b=pUZILWuEoBJhYe4uEvYAiNtp7tRGLI/8Na//pSNv4TrbzWCjcJ/f71ZO0yI955TyEnS2
	 KvWM1tU7DGSX4Lck/2+/d3m+ZkpgW+paDPfCsLqkRS490HmNfIL4fq1ZGTdpDn0MgORzC
	 mjFcITevwhOaZ+LOXd6S4OyjTtSpah9cCk570aAOcvGt9wv7NBNi2oDwvqPgW7AIGtQ0E
	 ZJkfDkXsuJFm/NbzQP1CNtY6oWMd3Yj4fHBDr+wS4CNph1VJCdNkQLwZjwT0k9uP1oqD/
	 47cAFNZKM87T0FNuMseR+/T3Cd9aQN/hXqvNzy8+bhD77SXLkS1ynWKp/fHojhbxgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jaQp/AS4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D8606A326
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jaQp/AS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DE81F00893;
	Thu, 26 Nov 2026 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726689;
	bh=ULpaDOsVWadbDOqcqnWuOV8GR4bNwt0jZXK0HexESRo=;
	h=Subject:From:Date:To;
	b=jaQp/AS42Mk2VVARiyRxqUM8S0Fju8z3lQnBUS2PnQPkGG6s11RkiA0gkJWUWWExk
	 merXJFGP5LE2FsTAhQxvSo3PNTLCJKnRYGXuyPjKlzQabYO2pVM9a9Zfhtzat2SYrK
	 YGhnld8unwj6ZkmxGUaGwpvTU5NlbBe2ygJQ/1VJb9mB0woeA/vUE8xS9Vu22g3Qv5
	 0DdcY4IRJA51IaJgg8oXU0yV3HJBRbHaadE8Q5HVvroTDEtfsF7kERjj2G+bj1K1Bi
	 x9vT8EepK3zT7SDgR4BYH1s3wg+jGfLU9X9E2/FSOBc8y7MuXSkDU91+EYka4b73nG
	 5F7CqDXqoJxLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDDB33803326;
	Thu, 26 Nov 2026 20:58:08 +0000 (UTC)
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
 <179572668756.616100.3454654388112044381.git-patchwork-housekeeping@kernel.org>
Date: Thu, 26 Nov 2026 20:58:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: ljca: Do not wait for an ack after every write chunk (2026-11-26T20:13:42)
  Superseding: [v1] spi: ljca: Do not wait for an ack after every write chunk (2026-11-25T13:49:38):
    spi: ljca: Do not wait for an ack after every write chunk

Checked 239 series in 2.53 seconds.
This project currently has 17215 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

