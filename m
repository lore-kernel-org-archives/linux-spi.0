Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3B3783D4
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769125; cv=none; b=i0bj0J6YyUIsZrvf6PLMou1o93BCtsdL7sL6XgRpl051ilwJiX97oQtzRvvsnUqXhyC7T7rpcN0rNfsXNh7TJnvp25lj1UVtShDRD0DsKu1Tlu9QlnY/lk/1NlGaBzrX6t9NINI0EDmW7wi2316Be/PJ5Rmi7Jgvq284Iu4sTFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769125; c=relaxed/simple;
	bh=k+KSTh0tkj+x3/gSZydiFMJvSLd5o6dmlLP6yFFh8OE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ackneO2XExePehZOXqtU5uznAqu80NxrNGz3HK5CKzDSt7c5+RucoXeYKm48wN3sG8FJYgo2OpJS59OFHQq8Ntg7woi683LlEcoEs+FYiW9wgv/B+fD8ivEnnTtaqMmKaAKBZPLQnqjBniced5JSdkwduW3bIYjYjQYHJpxJrAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8OEyEeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8OEyEeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D5A1F000E9;
	Mon,  3 Aug 2026 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785769124;
	bh=+P2KgvJS4KrOtGYBDMgUgDAaoI30WufCdo8VGUrv2hY=;
	h=Subject:From:Date:To;
	b=i8OEyEePnCeyj56KwcnDPaINlkUoND/toW9c2zFOS4dslUtz0uRdvmDCbHXrbhr+d
	 wUf54xpXks3wBdcpI44SvNkbkHqUujWZOCUEot3GY69jVYyEKQDXceab4u7VS99R9O
	 H2V8HaWHN3Alx4c9LTidUj/JXodwJXgQr7KVuy/BjNFysKVmjB92UUaqGpUGiOw06x
	 /vOi6rCxY4u6ygYoIfENgp3kWtD0ho+znxlDIv67F1l+FlY3CsFHao9L0F3m+M1Fmo
	 kmkTCmapBaroE2VUSNFwwwEwTprIG5KbLBnafFVI0h8zLEs1XsaC86x8hjDgaXqIaF
	 qozhm5X7iVSww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A65380A961;
	Mon,  3 Aug 2026 14:58:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178576908516.2256331.2503632137054068329.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Aug 2026 14:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dw: use threaded interrupt (2026-08-03T14:06:46)
  Superseding: [v1] spi: dw: use threaded interrupt (2026-06-15T04:40:34):
    [1/5] spi: dw: fix first spi transfer with dma always fallback to PIO
    [2/5] spi: dw: use the correct error msg if request_irq() fails
    [3/5] spi: dw: use DW_SPI_ISR directly
    [4/5] spi: dw: use DW_SPI_INT_MASK instead of hardcoded 0xff
    [5/5] spi: dw: use threaded interrupt and optimize the threaded ISR


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

