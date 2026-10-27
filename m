Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793073580;
	b=L7GoabW1tM1fA+kqf27ZEYL1Qq6sxqcxIDwyaTWSEj+JXpuJiuN6pxqZ64JkU4k4bkwV
	 n60qPnW1MhpaooM4L/GSIloEyKgjdnjbyhDRjl52UVnO6RluuzDWOmRyMP4u8xEvPbSd8
	 yy/JsVxsPK2gqevlo0Jxnkcn6OmIAM/8nkSET9HtFl/91vJackf1199yf3ZTYPE8jTJJ5
	 3Mnp7TXov8sWVkAYZtliqAfnAlv2dULPwWOS9YwJFJeNQ612jKf0QoHRMknhoxn41ELjg
	 YBW/dxtmJzTtjRbHj7EGri7qlZo4FSDn42bLyA2ItSdGdTloBz53gZy+ho5AX2vl5Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793073580;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Ifkbjg7DWMSb8A+L9LBz+8/YMXFr8i6BlKDUG5HqaN0=;
	b=DGkf2BciUn7CO3Uv8GBB0tE4++wiqQ3TbgbzcXHcIAZ4DE8KgTV2U7Cr27SJTwxwo8x7
	 VXhIMewdcjAHjjj7yXtlKV/qC+pZ9K/7nd/wloRlEJT6zWWnh/1XwJnP/qjd0iULGnPm9
	 Y4H22xt7FL4N6Hb+OCZSae7ZkOB+VS/8wX4kNSWdN4+MxVXPVjPqqpTJnoB5DFzFKeACw
	 ehalrda/CM/V8eBejpuGpxZayCe8U80PdeV7ux/z3rHRnvszXu5lg0Gztju+fEozZVUmS
	 YbXsXx/D0iWnnR6FpFziAyu5wBfDCPMVhvpJpqZ2hLzrmnTvd1GMgEUC2kFnRYAvVig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO3eGUvL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40104606A31A
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO3eGUvL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE911F01825;
	Tue, 27 Oct 2026 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793073579;
	bh=Ifkbjg7DWMSb8A+L9LBz+8/YMXFr8i6BlKDUG5HqaN0=;
	h=Subject:From:Date:To;
	b=gO3eGUvLReEcPgZ3pytHi83jv77pcPmImiMvLeO5167m4Ek66QPtCLivQu1mxjkXk
	 vuNFPOcYlXTfbTyAfJidfvOGaPzcisU0DYqmx4RG+SZAvt7C6bSWi9H+ipeH5yy0p0
	 JMLNay6GC0XE8bo1J9iJUmpKzla3X5XPy9Mv7uzWo/Dofe7Fct+tEEPmw3D3BYoMLq
	 lh14rtoeZ4JR3xacY4z4osH6j77g5oSc1wbak6L69VSvAJzk4AAzv/JKAhVD/KrQO7
	 9ddI4f+dIv86wvZ2wkiRSQTrDjdEXSir8yYSlrgKU9qvrmCuFOJ9HGa+UgL2JJ72Ct
	 p7Cnz82aLxikw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9B3AA80F1;
	Tue, 27 Oct 2026 03:59:39 +0000 (UTC)
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
 <179307357856.3553161.10930656373763345908.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Oct 2026 03:59:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] rust: helpers: add SPI helpers (2026-10-27T03:03:51)
  Superseding: [v4] rust: helpers: add SPI helpers (2026-10-27T02:13:30):
    [v4,1/3] rust: helpers: add SPI helpers
    [v4,2/3] rust: spi: add SPI driver abstractions
    [v4,3/3] samples: rust: add SPI driver sample

Checked 199 series in 9.51 seconds.
This project currently has 16839 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

