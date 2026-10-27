Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793087955;
	b=b53WwRF0gSLxHjXa3XseHk+t9iB1K9v6xKLgR6zf3is+DwcK2Hgp1nZ43FOoCdvEetba
	 aCKgw/dimPoTWquitqYofEKRF78TYF4G917eTPm1Qv1cgKnN6I3nj2QgB2P5W3qa81UT0
	 tqbu0ZuDi0FYPGZNhlBgBeIgEsddlqHYdbsVm3kTpbiPwdfbMEPc+B0hZLFW6KC4YHIF/
	 QFZE4dD2c93YS75ugMmSNleZ4YQ8kSL0blfwtb+6dUUkLkTvEGtIne587p0LlZaeYpZ/6
	 NTBycc1imeq4v5L60xYzF1HPMgq2eTf55/wBdpjFD+jq4/EkVQYqcryvYX31MHq+2ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793087955;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Kyd95cnAqbaCHYEWjuiNU5nUq0XoGqV7qjXydNBnKAU=;
	b=GjbnJlbqMFMtWpsroNAcMkyqjmlZVm67H8OVkPhqfqK2cQDU1dbqImnbPF8F+My6nOkX
	 Kb500cjsuV5Em/3CWJsZvfjSZZCu55rB20YHQFMy0rbn48pUnSswU7t0Tmgv8AMZch06G
	 Qa5Xs4AZEBBHNbsr1Lzh7pz7SfNsDGJeAzu+gN+8t44Bv5ZohqQpVrEnGDwCdZJKp0C9/
	 IJyObVsIo6U760JRKWZ0l/FQoQHLzZ3e854V5dPX+XMVnHkPcFs0SZSV6LMkuElYrw8eI
	 K4S41ytfkBgDsSu5xppilqVHttNm8PA+Juu9HfB9H6J1TaRFpsVSBUQDSCwq94KXOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOhjTIHW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D6606A31A
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOhjTIHW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1431F01825;
	Tue, 27 Oct 2026 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793087954;
	bh=Kyd95cnAqbaCHYEWjuiNU5nUq0XoGqV7qjXydNBnKAU=;
	h=Subject:From:Date:To;
	b=iOhjTIHWQovctY95h9JBMVm9FARwB8sbRcf63lnBIGwrrVAITVJ5rA7JI3JT3YO+g
	 RhVi3/ZeQQUf8XENdyS8SEV2vUpglaAP888TyoXpO6fSW1n6IoINu10j9E9xGhJ5Xv
	 SB1Gesn8DYw1PUa1KiSyJ3YFu2/HPgJpQ/CCJDflX32m2g0J0yd/EHx/iYBQCfPYeH
	 5wlJkZksq3oNrbrxTJpdb0dA3xObAGWBbZxFgyng3d0RR/5VscKcZRl5lsra1uSPII
	 dmOtjgGjXPXVrqRz6cjAeX6NuFr6jZ+eMZWiFlVQhJXGrLqpiqYy3JFzdWjFWv1UGX
	 mvf05QNBIPldA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4482E3AA8FD1;
	Tue, 27 Oct 2026 07:59:14 +0000 (UTC)
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
 <179308795290.3636688.7079448345477958317.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Oct 2026 07:59:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add devicetree bindings for spi-virtio (2026-10-27T07:26:32)
  Superseding: [v1] Add devicetree bindings for spi-virtio (2026-09-29T16:41:54):
    [1/2] dt-bindings: spi: add bindings for spi-virtio
    [2/2] MAINTAINERS: add Francesco as spi-virtio reviewer

Checked 198 series in 17.62 seconds.
This project currently has 16844 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

