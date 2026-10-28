Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192423;
	b=xzOXpWHMQvKfRTgo/+kW/zdMwJFc52mqdayPFT40+qOmZxT6JQCR/+8fWW3Bx9SRbrGo
	 T7NjEle5IjP/2gsguSzFnT712piCg16MvqMf1MQ29oEP4hcH8OmflmS9uLnAGitSbzvFw
	 V5eeeReoLFjQ1rc/CuUtwbaJ+xMSPJoGVYSRqoEV3F7bRisuwfVVcoPEvRPsy5DksmOIZ
	 9EvOnvXCYTCciGM5GDLR+Y6qYeNRjQXaF8a16m2DoblrXa6R9KUbohrLYbGu0NEzUXIDK
	 WJyaUc3e62cHZ0byATAYytbBCXq7onMbPB4/u0sGTKeO6VOfn57rNV5tcadgZpEbcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192423;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=MnorBW/YgblNELByi/047/IKshLNueNEhRtnYlXwDU8=;
	b=HfC7RN6zUrstmbM8HSTs9X6przaQMAick4aStp/wS47ASKBrP/YWnwsyTEje5Pp6+oNv
	 UVbdBMzK3DMk/s5g7xtgrzW2gM7UxaRtsD74LuQgdlFjJXGvljdCb72xMSQP9eIk9em3X
	 42cbAxLO39SrDS8yAQxgrTdcAflt87uRuWeEv0NGlwq/rMx9MaXGeKxvIneyygMVTFSir
	 p5uGqqc+hyu9yT/TeH0J7vvzNs1Z3cjKJYJVGnUTx26hjEBolnuXXmuEO4DCWtwDi/5jF
	 LDB/ze/bANOwmz5gMfDMLilOixQd5Mc4PA4dD2h9tmCPWbzldfL7ZrKUlAN8f7xqQyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4diZIrw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFB606A322
	for <linux-spi@vger.kernel.org>; Wed, 28 Oct 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4diZIrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B121F031E5;
	Wed, 28 Oct 2026 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793192423;
	bh=MnorBW/YgblNELByi/047/IKshLNueNEhRtnYlXwDU8=;
	h=Subject:From:Date:To;
	b=F4diZIrwvfT8HkqglNc3YK7jdBqRZ9zz2kw9ISANMh1ivUpwcrL/TKR0W6PtdVq56
	 6pCi1xAyTfOUNg9KmvYLH61HPYWYc0pYksZnmIQkn9l5VugaLw7FeRZA+s7L/gY/YG
	 hNMFnQAomAm9ayBSL+K5s4LIQ20VTgZjM3MQssTggANJHozgeNOSNaXbDPD2q11r4v
	 tW3QCvfg2WrIUXFmJf3DWZbsASa9c/CVOE8di6MzY1i7PW7obuyRALrP36DtUEMxcy
	 17tDhSBu1oVRZW5w+xaRY/kNuTdf7LxXMauRZ0IeZSQi4xE+1gRYr8stisnyl8aPXM
	 nb16IhJHV281A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0747B3AAA6E2;
	Wed, 28 Oct 2026 13:00:23 +0000 (UTC)
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
 <179319242164.704905.10010245070474287034.git-patchwork-housekeeping@kernel.org>
Date: Wed, 28 Oct 2026 13:00:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add DDR (Dual Data-Rate) support for DW SPI controller (2026-10-28T12:10:55)
  Superseding: [v1] Add DDR (Dual Data-Rate) support for DW SPI controller (2026-10-22T10:26:14):
    [v1,1/4] spi: dw: Add DDR (Dual Data-Rate) support for enhanced SPI mode
    [v1,2/4] mtd: spi-nor: Support mixed 1S-xD-xD DTR protocols in spi_nor_spimem_setup_op()
    [v1,3/4] mtd: spi-nor: debugfs: Correct DTR protocol names for 1S-xD-xD modes
    [v1,4/4] mtd: spi-nor: macronix: Add 1-4-4 DTR read support for MX66L1G45G

Checked 197 series in 25.20 seconds.
This project currently has 16849 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

