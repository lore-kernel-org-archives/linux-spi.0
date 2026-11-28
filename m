Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795841882;
	b=LOBQ7Rtais3DE3ukOD5Kzb40FHUzLYhx3GntHQHTN35Zs/oLu9C9bh8CtCet820aknTl
	 O20LRIA83QvXpzlh4ZK/sY2FSxTEI8YTcXhfLspqtLR05R2GGVteqtfAqiROHMghWZMjs
	 AJzTBgKSBY9tbfcOvFERQy7joeLK7oxTKsINF8ot0na70Wtww2Xt30Zrl76blYBBEOeQF
	 LueXIAzt+7/KLmesW1iDom71SLh4mjABuM+ji0ofiCXxIUHCxhZw7f0jjblzwRkGGzSYg
	 S+UqUa0f8F6Qx7NP0RokE38AJRyIoFWFpWigpxPR9BAwzBPsrRHS2UIyDLrZ5SV4m9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795841882;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=OghLIpO72jAqF7GSGca/qpTVRCp2J9hF8TlXwNdTnis=;
	b=pnok9uKY7acKW7lc48tA1MP7J0sd6gfkFb12rhz/aHJiruW0xvyH3GSfu4kpHQDy2Bsl
	 0ZZDXjELNHRI3zhFEhD0awYfU85/YLyHgRlvZeZjTaZlF2QNragc0JyEUvmS8JSklHrR4
	 T9pqGEpjVp55dziVWOmPymngBmzN1ESYRv4V7MG3vVvBtYk9V9/rNyJR9M6V1daiPgW+d
	 /n57y6v6JNhX5AkijnJkLM9Y4RD+1qnvum2vWis2XpDXrIOKzY7+a+cstZr++6lfotFEW
	 YORVSJ7SKnV1mpF0WGCj6182UQ59ezT8R834KCT3pmCej2K6neo4uFoIqSTKpLvq/cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBgscXrI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB9606A31C
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBgscXrI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7E01F000C1;
	Sat, 28 Nov 2026 04:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795841882;
	bh=OghLIpO72jAqF7GSGca/qpTVRCp2J9hF8TlXwNdTnis=;
	h=Subject:From:Date:To;
	b=nBgscXrIzUJQQZmC5ZfFp1bWlqT0PJbWog50FYauJotm5GQ8cTM2Qo2nZep4cpxb8
	 QED7+rAVdqaIHFNl2ksMzTwttLVcc+OJ/h7tZnBpfUTOXibrfqX1TBYGkX5E1f7gFR
	 zKxdxBE698Q4uMRS1V0NwSr3OpjVL4Ed9iTvpzRZJ4XufmlvvHbYOxurYmT8bU9bh5
	 WwKhdG1ObsxIJo/cujDf0LdKENLCkiwDkWbXnMJBaHLB7ib2Fou6r3QTRyndN5CA6d
	 81epatpn8UnpBgYovNB8zliLTNuiRTaUuNCI1YbOp6stZAwpOXnfmuzS0cw6Kb1oko
	 4rXG/2l+toOeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37C7A392706C;
	Sat, 28 Nov 2026 04:58:02 +0000 (UTC)
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
 <179584188073.1817446.6941255938024668548.git-patchwork-housekeeping@kernel.org>
Date: Sat, 28 Nov 2026 04:58:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: fsl-lpspi: add atomic transfer support (2026-11-28T04:20:18)
  Superseding: [v4] spi: fsl-lpspi: add atomic transfer support (2026-11-27T14:02:28):
    [RFC,v4] spi: fsl-lpspi: add atomic transfer support

Checked 247 series in 2.71 seconds.
This project currently has 17279 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

