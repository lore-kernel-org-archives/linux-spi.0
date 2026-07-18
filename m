Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A117BB21
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336324; cv=none; b=YE9At7443rJsT8pnY62+JX8aosH2iBSU6fsQzAZlebMmfoRpH3X2+T5gQVeM17Ui3kPySdfhFMo86Y7k+r2nW0IWoYfoBT+Flr78jraDkd4t8XhOFoNfwXwn+6zKfK8t2a68LFuJjg/R5W8wev7T9SP+YZybfwgiezwfMBYhKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336324; c=relaxed/simple;
	bh=I8sS0CNMZBIAo+UsDPoduxmH0iGnJT1qYwoq8L7Tmhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mv9rcQ2BtLvG/jiz/RAmoS54CS0bCQ/iI3L/qFJbEMQtjSe3vwYl4QQpQusH/7YYwVKUt5wBF5G5xJiu+UnKdbWFM64Fi7LTtxRES2ZqIqH1cgJcwhjxLBdu4bV4rrsOiSQF7dPtHBpwGTXHEFSN8UYVQCR1ukvbUxc/Gz/JaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIJFQj3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIJFQj3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CCF1F000E9;
	Sat, 18 Jul 2026 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336323;
	bh=EICMd/rx+Y3t6LlygjAV2ryqVYOeXCjLWvvE6axwEI4=;
	h=Subject:From:Date:To;
	b=RIJFQj3krb1VXWJhGl6KfHq5fLLHYrhQxOOfBQwKdF7xtGU/moseG3s6Ay4SG+ThS
	 3zNsG4hU2f4tUJDS+lyKI520PZ9gpWJvaUNW0sXe/hvzpq4yGW/mCcDP6VQIGZ1eee
	 IeTf6pbEroFufUPESnxGFKHTgu4u27c+hn9Iaqg/+pSKbDQjYe1M4Sj54VjSMKRvE9
	 iwXvfUlOcaCVS87YuAycrA5KALXx2LQVQgC/k5AHyzxkNheZRIeHqGCEOPKUE+xB1j
	 1Vc22rYR5/PkVG8TAXZkpbmyFuKrRVn02flE+Kz3rfYWN0ONadinNKbzuDbGGOP1QV
	 CLGAbrekIj9Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 595093810935;
	Sat, 18 Jul 2026 00:58:16 +0000 (UTC)
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
 <178433629491.2358934.6405069458100049260.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 00:58:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T00:38:19)
  Superseding: [v4] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-17T16:37:29):
    [v4,1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
    [v4,2/2] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

