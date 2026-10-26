Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012403;
	b=PFVpKFtXz6FhsOkeRO//6yqezBBiCEGJhOhf6tmrAw+AYfVp+OVBmEMUQXSGhP3piQYK
	 75oPtE2w66RczWvLyzncMweib5WHdCaEinba1+lTuaVWZe3+msZKLTU05qwpaWaCYCXd8
	 HXRIupEmAfTKEc1eNHxtlXgxnGY8b2itGSV8uIu5maRMQuZF1Eive7F2jFxdC9cyOidaD
	 JiW4PPV4KuGwL4yjSV6BHDsvNu8YwKeQZhiuXCezI5rS8n0QCKkwmO0fIk/p3p8K5Ow26
	 RKd5XDoEk4RRWvJQhdTQ52udtI3V+SO0SA3n+LGB9Nes80XKNU8viFRsqSn1Nx0KFnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012403;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=FAGgNHUOCYOtRTWryl0I5i5axphTzD6m0t9YhpyVtOA=;
	b=WTg3Lhv6RsH6dRwtSgU1C1vuBEaNati8w2nDc4DkqIq+NeuaJCEmDV1opXfXykBnHETD
	 2a8mzc10mvFqjcwcZJfHuYnxm3mYZIhLYEoKRYCE3XanDVyBKyRdHmZxHJqVUdAcwZXEh
	 37AnJQSSIaX+d6AFQKd0GdQwkz+Xg6+BgzDxAIX5jaRGsCEAoDAIdWrGghKEhRJD9HhQh
	 OEjAMUcTlhzmXbDg6dFusZ+LffwAf8LYB4q/juOAJ644GwhIU0AWY/R2D8oXxMsvlzY/Z
	 a6MaizR3o8OJYXWNTfwgbYeiZVEUDNv4TIOlw+muFqMCvVVAIry/VzmW7B+5PL/1xqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YD8in0gu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B90606A31A
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YD8in0gu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3046E1F01825;
	Mon, 26 Oct 2026 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012403;
	bh=FAGgNHUOCYOtRTWryl0I5i5axphTzD6m0t9YhpyVtOA=;
	h=Subject:From:Date:To;
	b=YD8in0guaOx1Mhk8SQLWUJdy38k8AYaf4MCfpGQo+c0YKOEPOD2Hoz4+yiP9fLrSs
	 Ug/7Nv85tn/uMWhMhNOyKbiHUXRn2eeGrBdN8WcO962ayJrjLkeZYkmWP4NsmTvlwZ
	 OLLHNQff9AnS0jVdgZRBzYRD6S+jSqOifQ0gdPZXYY3ZtjdzEzLI3y2C/fApP+YUJW
	 Kqfv+8A8sO+XUtUsaXyVG/8eyUIQeDIASYZE0vemjUPUG/oL0d1HXovB+AyTGX9QTZ
	 iacURVofnm3yb3IFfHr1/lOZW9ynzO0/qAoidcrTRelSKQuQs7icsxbXt/c7xI15du
	 emNfsX+jET1Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074713A78B29;
	Mon, 26 Oct 2026 11:00:03 +0000 (UTC)
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
 <179301240172.2632113.17353070142427834969.git-patchwork-housekeeping@kernel.org>
Date: Mon, 26 Oct 2026 11:00:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] rust: helpers: add SPI helpers (2026-10-26T10:17:46)
  Superseding: [v1] rust: helpers: add SPI helpers (2026-10-26T06:29:03):
    [1/3] rust: helpers: add SPI helpers
    [2/3] rust: spi: add SPI driver abstractions
    [3/3] samples: rust: add SPI driver sample

Checked 197 series in 5.10 seconds.
This project currently has 16821 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

