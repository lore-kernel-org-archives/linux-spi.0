Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858F411692
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681134; cv=none; b=KAGsppz5iMWQYfFQnn4JBk/gdtsIgUgje/y7ai6gtpzVPbCjV5/gPYpl3zXx5HDAKc4rcdiVJyzns60OGHRzct0/CKx2sDaSb6CCzCp2mPTVSnmsU4V1P8uVFDXmPKdUvIQjsEAdvQu0mlesk+v8sUTb5LPvCRytGMWa1HPAyc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681134; c=relaxed/simple;
	bh=y41vdXFejJnkiegYE2W8vg76q/trGvVb/rs0WWDEHic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GcirEpqgmy9J9FLxCBazq25Mk0ZeIpZ1Dhcd0t7CBWQ+S+eEkSxxjgg76KARCBAyVguKuaFdVZsCVlFq/k5EwHvJAXkVeKMAe/WkgnfGiBHLv4h1sl7GdQvnAi97jjbhvxsZ4f23mII8OzCXsMxurjmH9U+lNMe7nrDgLizQD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhXctkpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhXctkpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DBE1F000E9;
	Fri, 10 Jul 2026 10:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783681131;
	bh=fR9y+0bv8YPmdrsJiC9Yn/WzGGVpWwar+sVQUBm8rGs=;
	h=Subject:From:Date:To;
	b=QhXctkpCG3u4Dj2p+1424nqvmxE1duguKrsreIgvCXC6643FLF1sDAqQ+3SRPSs4d
	 nLdfWaxTDgphaunYDU8fCYFqrvjQuenlSzxeyAqeTHDElgzOV2tpoYFVhqRgS7cVFk
	 cR7227c01Vmc5JJM2rN7oUnh0tgfaIpUr0S75HQGqTPaPfqleSd9JvZvq57Ow80SfN
	 kb7k1iidHh5RdkU71JZhewEldQSS5h9l4lqAhrFOwpXXmHOnCHqIVhHCMA8dspkkyl
	 ngBta09z//e83cufOiD6i0BbkHHGhmzwGO6KLuVtQBCQ02TZ96302n0P8bWe/jOaf7
	 JQ5iQlLY/OmVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4B3AA3924F85;
	Fri, 10 Jul 2026 10:58:30 +0000 (UTC)
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
 <178368110901.179902.4216171769408964215.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Jul 2026 10:58:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] PM: runtime: Fix sticky -EINVAL after resume callback failure (2026-07-10T10:12:42)
  Superseding: [v3] PM: runtime: Fix sticky -EINVAL after resume callback failure (2026-07-06T08:53:08):
    [v3,1/2] PM: runtime: Only set runtime_error on suspend callback failures
    [v3,2/2] spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

