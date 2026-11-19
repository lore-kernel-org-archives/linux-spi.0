Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118405;
	b=bCtphT13Q/W2wb+4mftFIGM9wnifK0Z4Mm5ykWCUJYoesfFTds+7j8tD5RizkL3Pl1YM
	 V1cFaRB8I1kGViI/74Ob5BjOiPFR6T6L5UjHatDVdmJK7Yo0HAtAogTggdKwkNkYlamw6
	 qAhb3LW+Hw9MMdJPv+pHFukLcXyALeZDFbHqh9jpA1bnvCjiu+zmoh5rE0Qnen9sUEr9b
	 qBSvl13dJaQPP1cdLVL1RPzjJzOdhHYK1BuLlUJ781vd5ruNuuTDee/b+v+ruvltIXWZP
	 BK8GAxx/xVKjoU29Fdk6k0pSbAHyBEFsGjQUwv2NxUfb+3DcElsD4rbJQaUnNv7EnNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118405;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=vBmJNm5Uod1YaBpXohSaLi6ZtS6QqM6Dj/ej3Uw77mM=;
	b=t5yl2hAyia/Pps/tOdHiYwSMTWXB3AHbh22VKoAMBNNSywyx+wv4SfZuTnfHhXcVA3o5
	 wbVNhFcmv/CktFClONlGDLLAhKXNT2E+RQa9t4z/7t4MotbIlGWnBAm1fHsYDWIDzyByQ
	 64tgcKjRdO/nIJRBxFsHvb20KB7VK0rbMcOzwrktAeTHN/Twiq1rSYYm618xfRsxBVe/q
	 nQpYq0nz0QZbW3PungEAAtadAcMyel4Hbgm4Gw5b8EoHEIdcrfd8fc/pPYczYWrDIK4ST
	 7jLyqQ1rELFNcAYVWXrCQRqbQzNbWTFzkZq8Xx+ZSKZpRb41GrD334LOTuysse1gTlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDotPOyj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E60606A326
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDotPOyj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660071F000C4;
	Thu, 19 Nov 2026 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118405;
	bh=vBmJNm5Uod1YaBpXohSaLi6ZtS6QqM6Dj/ej3Uw77mM=;
	h=Subject:From:Date:To;
	b=JDotPOyjEDUKjNvgzNDZD80wtk8b0pc68FSZDiSXtCqG1CkfjwK0bHNuK/VUKcarK
	 k/YwGzb4WggRqWeZuDH5owyATse5d3ATY1NjS3YTbbojuZKDrRcQYDCfGLuXT/z1J3
	 C84uYan0dKYd2kSKyPn/K7dpVuXjWwuuLmMiUwm/KAAgurUFh5Y5ZWmi6/5mmE9dqt
	 dc6ET98Epbn2Z0sKHnhmrX4Rd6ROGicTTG69PW5mmYdyuaxh9PrKPhwZTqBb6lOMmU
	 tnfw1jvCDWObPY/DW6aDYLTn4U4jX9bpRbyT7WksRIp7ya/TRB6FVtdhQCo60nTXCU
	 Ra0QVqTgxujbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3C92E3808210;
	Thu, 19 Nov 2026 20:00:05 +0000 (UTC)
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
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179511840386.3781407.15304979542699845988.git-patchwork-summary@kernel.org>
Date: Thu, 19 Nov 2026 20:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits
  Submitter: Carlos Song <carlos.song@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1215994/
  Lore link: https://lore.kernel.org/r/20261119101539.2536367-1-carlos.song@oss.nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


