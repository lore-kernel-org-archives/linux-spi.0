Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769883;
	b=Kr0XN9s/iJxqurHhgmXztqJMKQCAimkBhW2LneUiMZXt0uAsNk1I0bz3V4jp6z5jXRnh
	 E79Qbz6kqrJKWbB57gaf4aBYwuMiOTyBB0MwAo/VZlHH3Hf4UqEAr3fOC7QYoWexP+JKJ
	 gusWCYowndl0AqrvJKm6x/6G4Q/dYf4eMPf+bL5kfmONaHtFur4BM1YUAc8syyH/tKhjn
	 swhXe/tOY8hkHtMiHZHShkWQTvC9ljE8EgVWW6M3DBtXIOAP+2/EvK0rNHNkIXFtVCJg0
	 cqaohEJkclLTmy5ZYoJLZYpdzndAnXeHYUPDud35uo06J6G2bpD+6hSdGCt2JE60NEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769883;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=oZ3UYMXk/J0mcosB4BTgDfh0Iay6Sy88uv4XsQvmZ+U=;
	b=D1jDTh6v3yTSSzbWxIBQnuTBQSIcwEVxo+KSnw3cZHw43hEpoMvRgmGk71XwvgVBtnTt
	 EB5yfkWi6BO8thxcQ53lOyrozouvYqOs4Zid0aVt0KRvy6OVsunmac8zT8h9PMw+LK2ZJ
	 KAs5y8Gyr6Lt3/QKolPMe/sM8+6GuuRlcuS9F6CSWbZcFwDxJfHNCcfPl4ONDy+8jvltY
	 WiC6FcGC13gj4Pt1+I1LlM104jnCU3A0snPyGaAPR28uBTS6Rud5bNH7ts8a1zkSpf9N5
	 aigQFoePa9xFis/+HnsqF6WxNVbIXKtNJdJyac3M3ioIOSUK/lngS01GCdKwlpQRD3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/sJyoqy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DF606A331
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/sJyoqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478F01F00925;
	Fri, 27 Nov 2026 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795769882;
	bh=oZ3UYMXk/J0mcosB4BTgDfh0Iay6Sy88uv4XsQvmZ+U=;
	h=Subject:From:Date:To;
	b=W/sJyoqyA+FmjsqWKX9Yw1j4i8Def0sUlBg68ij//jScTojyofiYeHDAwE2dCuuH4
	 IsntfuVPMchRl8G4/ONXXrH+L2RSnuBLYxjRm6bZLcoE1gk1KuxDo6722RqLw808/x
	 TbOMZeK+1UOX2twwYNtktv/ZuothzUSIfaQXU76RJosn+2zPQ9KllAeRJyfMWk3BYz
	 EpcCh+faWjjMw7Aif2DD9ORkpXHKjw1NnyEvgdXe8RKug9YODXLJUbKRy5Qk/wdBD/
	 ohpjOLWgQWrtRHI/SccvzBI0ZbtQj+TVO1FXloMRcDMtYcC9/BMsJwdzcXiTYiDlpB
	 7mkZZmJ4C+bSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 36F7D380044F;
	Fri, 27 Nov 2026 08:58:02 +0000 (UTC)
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
 <179576988110.847303.5031316168716721235.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Nov 2026 08:58:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: omap2-mcspi: skip the TX drain wait in duplex (2026-11-27T08:09:49)
  Superseding: [v1] spi: omap2-mcspi: skip the TX drain wait in duplex (2026-11-25T16:20:45):
    spi: omap2-mcspi: skip the TX drain wait in duplex

Checked 244 series in 2.55 seconds.
This project currently has 17224 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

