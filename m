Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A142857F0;
	Fri, 16 Oct 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116048; cv=none; b=W9/0VwpbKvFjg9obtKOAh/nCxQTB9UHei7UWdpnmtRXDDmFtCzWOzXy7qZLr7nYwMly0+MP0kAZ6oBzNgBybyVK/jRTbQWcFtRyAMyR0x9DQCwZQxcy6w00fxAy+qQcw9BkSVOxv8FFrBXnHFxpXxTFOaRm58TMIkRshtk0a3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116048; c=relaxed/simple;
	bh=BjhP1hXmHdGKb02kCAs8xnxuVNsiEch7JLv08myEd6w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:Message-ID; b=d6gYt6eZpmTI0kIlRUsOiYShNeCShaH2S5XCgDinKGvKq1+0IHILRUb75ENxzQdLj8xhApIftIXcxJ8gJ8zqQ3JW9KClpNB5VHWf+G1LHHkgn6HuNo0WpM2jO+VRs5zBE9llF0axIBSNhx7k9zqCPZ4fIsW3jxHRsGgv2606PPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=FZlEAbIg; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="FZlEAbIg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792116036; h=Subject:From:To:Date:Message-ID;
	bh=kuvrWPPmbPByeYe9dIfwCfztogrW14Sg+qB8cfHwIqk=;
	b=FZlEAbIgUX1CIqKbjZi6Hs055MWa+yiMYBSfyUf14+aUep0zptXox70Ku3iGY/JNUpmybbX3hrwIfXTNt07XM1pzCJdqYE4mh1B0p1j9aY4eRaHjfdUIr+4CHT0SD1ndHEuP7OE5/ZFI7oC+HNnihsnwRHDDzNoPuJcfpDHOmMQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1027633|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.35414-0.0102887-0.635571;FP=8850552909123859961|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.jfXqDjU_1792116035;
Received: from 127.0.0.1(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jfXqDjU_1792116035 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 16 Oct 2026 10:00:36 +0800
Subject: Re: [PATCH] spi: spi-pci1xxxx: quiesce DMA engines on transfer timeout
From: Weibin Liu <liuwb@xiaopeng.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thangaraj Samynathan <thangaraj.s@microchip.com>,
    linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
References: <20260929081156.42124-1-liuwb@xiaopeng.com>
           <a02880a9-f20f-45ad-b22b-c405fb7e74d0@sirena.org.uk>
Date: Fri, 16 Oct 2026 10:00:35 +0800
Message-ID: <179211603558.1333472.4954415856217564373@xiaopeng.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

On Wed, Oct 14, 2026 at 03:37:15PM +0000, Mark Brown wrote:

> Why is the sensible thing to reset both channels immediately rather than
> try to let the other one complete (or time out) if it's active?

The two engines are not two independent channels that could each
finish their own work: they are the two legs of the same transfer.
The RD engine moves the TX direction (host to device), the WR engine
moves the RX direction (device to host), both are tied together by
dma_completion_count, and complete() only fires on the WR engine's
done for the last rx_sgl.  When one engine is wedged, the other can
never reach the end of the transfer, so "letting it complete" has no
reachable exit in this state machine; it would only run into its own
100 ms timeout.

Waiting would also not be safe: once transfer_one() returns, the SPI
core is free to unmap or reuse the buffers, and an engine that is
still enabled keeps DMAing into that memory.  The timeout path has to
stop the engines itself, and stopping both immediately just ends that
window.  The stop sequence is the one the driver already uses for its
abort paths (disable, poll for the readback to clear, drain this
instance's pending status, synchronize_irq); only the trigger changes,
from an abort interrupt to a timeout with no interrupt at all.

The cost to be upfront about is that the engine enable bits are shared
between the two SPI instances, so a transfer in flight on the peer
instance is interrupted and sees one recoverable -ETIMEDOUT (its own
wait has the same 100 ms bound).  The abort paths write the same
direction-wide enable bits with the same blast radius, so this patch
does not introduce a new category of interference.  The interrupt
enables are likewise shared per direction, which is why the cleanup
drains only this instance's status bits instead of masking the lines.

I'll follow up with a v2 that makes the re-enable conditional: the
engines are turned back on only once both were confirmed to have
stopped, and are otherwise left disabled - matching the abort paths,
where a failed stop returns -ECANCELED and the engines stay disabled.
Unconditionally re-enabling an engine that failed to stop would cancel
the pending stop request.

I don't have this part on a board and QEMU has no model of it.  If
someone at Microchip could exercise the timeout recovery path on
hardware (in particular whether the 1 ms stop poll budget is enough
there), that would be much appreciated.
