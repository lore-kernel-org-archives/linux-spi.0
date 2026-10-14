Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1994E73A2
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981675; cv=none; b=Ze6ODL2/VhBdFRHW444CGZHb0+59UOW8VzFcEVxgrxKe8wgRN6OIWbeo5F6U/PnWHUKGyO2gjvE5Q+jcOZGUT1S820ze/m5hCfIGm8mCfWJ+M3gEgHyInk7UP5hcGnttW3FGPXCA98P7N+/VXyjZAS/67K7mIgN2UdK7WvWI/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981675; c=relaxed/simple;
	bh=lK8wRYJ+AYqo2LGH0BO63nJiMWgl09XhIwZHu37kNNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puw26nTIKwqK6CbLaGjx/e4SpB2FVMsVZqr3ITYnuf53vHWyqUtJQqdN8Gwa7wsc9jb37qvqEr16kmN3pjZIzSl7aBa7iyx/JlVIfSKi483LOAyQYpPrwiFuBr7XyM8h83yTXiVCp+2NIyMCj4wQSxKJAdDv2e6NY/azLF9TrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=KBet5xZ+; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="KBet5xZ+"
Received: from spam01.horizon.auto (localhost [127.0.0.2] (may be forged))
	by spam01.horizon.auto with ESMTP id 69E9aIm1021205
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 17:36:18 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from spam01.horizon.auto ([10.9.15.111])
	by spam01.horizon.auto with ESMTPS id 69E9Z8cC019411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
	Wed, 14 Oct 2026 17:35:08 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by exchange002.hobot.cc
 (10.9.15.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Wed, 14 Oct 2026
 17:35:09 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
CC: <nuno.sa@analog.com>, <miquel.raynal@bootlin.com>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RFC PATCH 0/4] spi: cadence-xspi: add ACMD PIO support for NAND and NOR
Date: Wed, 14 Oct 2026 17:34:53 +0800
Message-ID: <20261014093453.688565-1-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
References: <20260921093701.1341766-1-fei.xie@horizon.auto> <arOwdePAmoghlakj@nsa> <20260928055005.3987624-1-fei.xie@horizon.auto> <arp-E1MDFLfV1ASq@nsa> <87bj99lef4.fsf@bootlin.com> <c79f5f39a5656fa838e424ad2ca72fe74a1d31a8.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To exchange002.hobot.cc
 (10.9.15.111)
X-DKIM-Results: [10.9.15.111]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 69E9aIm1021205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1791970518;
	bh=lK8wRYJ+AYqo2LGH0BO63nJiMWgl09XhIwZHu37kNNc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KBet5xZ+SYMzcjpDMyHl1AZPMN/KLJHChUmaUEuu1/Ezo0XCz2TmtEE4ePiF4gUcs
	 H5tD6dspkAN2Olc0Yy0vF3Max9ZR2BDZv5SXeZx4iuWnFoja0YwkuTRlvMg54/5yfd
	 /qjKMj5HK9A4gOS/6WCnvuGFJaUif2RiYz8SSmLtaypDMPz9nvvdPtcj6yJNEbA5No
	 J/v/P934KzMetQ2ZQyAFYy/3kcUakKjNOfXIqrvPE3HDkZwGCjHJ+gkZa9E04s/Dxw
	 OKEHcANxkH3ElCBBRqIBLJez8E+jglfVtr3csoN7gZOVRclug9oZmEqlCCaCvJ+UsU
	 cLIRFrw32HElg==

Hi Nuno,

Thanks for proposing this. I agree that starting with your simpler ACMD
support makes sense. Please go ahead with that approach. I would be happy
to help test it on our Horizon J6B board.

To clarify my earlier benchmarks, "sequential read" referred to reading
consecutive addresses from /dev/mtd18 using dd, not the NAND device's
continuous-read mode. Our GD5F4GM8RE datasheet describes page-based reads
with cache output wrapping within the current page, and its SPI-NAND
driver entry does not advertise continuous-read support.

Could you point me to the version you would recommend testing? I can
compare it against the optimized STIG path and our combined NAND
read-sequence implementation under the same conditions, checking data
integrity, throughput and CPU usage.

That should help establish whether combining page-read, ready-poll and
read-cache operations provides enough additional benefit on this device
to justify further interface changes. We can then use those results to
decide what, if anything, should be built on top of the simpler ACMD
support.

I also agree that program and erase can remain on the STIG path, given
our results.

Thanks,
Fei
