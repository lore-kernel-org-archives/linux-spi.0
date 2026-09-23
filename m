Received: from spam01.horizon.auto (spam01.horizon.auto [42.62.85.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BA331ED7;
	Wed, 23 Sep 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144143; cv=none; b=X5lKjzAADxGnaO62flqzfasfSyF2G5EZWbBRZKp+YKKmHR0b4cNeNA2/gRwFL28/GUPXMFfmYIFr13cNycoqE8LrkgAhdmxSe4vGyqGoKYmn0zoz3bAVIJhUCVf5/vI6A7XidIRWEbrT1uG4/UDXyJqvNBiMfwTUXbRyhJOqe3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144143; c=relaxed/simple;
	bh=bCUCYlEaXgZNmby4tA1+BtoGfMqjNJTX72dC0mvaqRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cY+mhuMSelG1XvKzlW9dAyOLPFOrx/PoRiqmKTOpwP7qCalFgwbw8cV3AouQl1fhteA/GQC+rWkZwEoIxkm3rYDzhEHVamITo8rtDH9TY3qwdduJFkwqNuQJAySUZG7e6hDEja8vg452FUimTjn7H7NElXYdeNP8l+FOJh78eEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=hKfO3SBG; arc=none smtp.client-ip=42.62.85.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="hKfO3SBG"
Received: from spam01.horizon.auto (bogon [10.9.15.211] (may be forged))
	by spam01.horizon.auto with ESMTPS id 68N6CHuS018985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 23 Sep 2026 14:12:17 +0800 (+08)
	(envelope-from fei.xie@horizon.auto)
Received: from server227.horizon.auto (10.9.0.252) by robotics002.hobot.cc
 (10.9.15.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 23 Sep
 2026 14:12:17 +0800
From: Fei Xie <fei.xie@horizon.auto>
To: Mark Brown <broonie@kernel.org>
CC: Fei Xie <fei.xie@horizon.auto>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Parshuram Thombare
	<pthombar@cadence.com>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] spi: cadence-xspi: add ACMD support for SPI NAND
Date: Wed, 23 Sep 2026 14:12:11 +0800
Message-ID: <20260923061211.1608907-1-fei.xie@horizon.auto>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <arFEjzkHGMbecWWV@sirena.co.uk>
References: <20260921093701.1341766-1-fei.xie@horizon.auto> <20260921093701.1341766-3-fei.xie@horizon.auto> <arFEjzkHGMbecWWV@sirena.co.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange005.hobot.cc (10.9.15.212) To robotics002.hobot.cc
 (10.9.15.211)
X-DKIM-Results: [10.9.15.211]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:spam01.horizon.auto 68N6CHuS018985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horizon.auto;
	s=auto; t=1790143945;
	bh=bCUCYlEaXgZNmby4tA1+BtoGfMqjNJTX72dC0mvaqRg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hKfO3SBG9GrxjrtfmIdjL5LUpvxoUXI5EsGIi8+DYl8pG6726oYNJM8/DGN4CS1kD
	 d7qE7ybuzlPB7QLjwADTC1OtF4C6bBR8swpP2Bv7Ke8VZMd43sV4Kvhs1w8wi2ojoW
	 ephl0kfugh3Tzye10h/1hTNFWMUpAiD5gXqEVAejLKP3lMYf2QCmi74MP+yHd4nfur
	 n4jvfBI+tDDi06dkbZpfr3qEnjpWmp3haVmRkyhmdoeBdU9UWToDTfvJqgaMYWAzqH
	 H54AfukLW11jDPBlb2egDfkI/eXVnFieXgjA1rEwQblOD+DZiTVCq7pxdiuQfPnIQv
	 aLPOkLFD2EtOQ==

Hi Mark,

Thanks for the review.

I agree that the controller should not interpret the child driver's
private data and that this dependency should be removed.

The difficulty is that the hardware ACMD sequencer needs the complete
multi-operation sequence to be described before it is started. For
example, the SPI NAND core currently submits PAGE READ, status polling
and READ CACHE as separate spi_mem_exec_op() calls. The STIG path can
execute those operations individually, while the ACMD hardware combines
them into one programmed sequence.

Would an SPI-mem operation-sequence interface be a reasonable direction
to explore? The NAND core could describe the ordered operations and
polling condition, and the controller could either execute the sequence
in hardware or fall back to the existing individual operations. This
would keep NAND-specific knowledge out of the controller driver.

I would appreciate your guidance on the interface direction before
reworking the implementation for v2.

The implementation issues you identified, including use of the interrupt
callback, timeout cleanup, DMA handling and short transfers, will also be
addressed in the next revision.

Thanks,
Fei
