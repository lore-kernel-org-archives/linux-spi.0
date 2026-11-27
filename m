Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787892;
	b=cB63f4iWeAvw7PlFiB0WOiYqoOwi/NTEJ3xrbzVPrvxcTTqDGcv8dxxQHULF/zKjU8wI
	 usyWyeVvAYGm8+fwP+4u6oUcXhVT/bTRpAaa/+wGF0OhUeb0nT8DKOOU9c90Lbfc2VE5K
	 eqtG35jgtDVuy/mYS3r2P1vMwYpPOqu9EmTDXaZ3ypJ5TgdAYeifMeLjMPwvKYSRs/0QV
	 Z8Em1babUW3E4vUEHk2kGUTIG9t9qC8EhRPrHWPcjKxcCTLV59jbM+1yZIjvmHtmHDOKq
	 3mub+HVy+a/Jysmzx9y64gmhXGZNKWeUyxPf6E5bP+lnxsVwGyBgX8J241ywB69bY8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787892;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=5DLqUBwAG9IM3Nf9oehHOHuV7FovDr4OoUTPCPYnlPM=;
	b=vrixV8ENfi19FfaCR/3ZGfGJ5eqSRif4P3kIBvwQnTKl3VaUSlvrgQFPc2U8Cz4oPnOW
	 PAqXbfXTAfAp8QtGJhlYFOWqmE2BDqGJxSqrChu7vNHXtYyacB292f0gbCNbkyRtUdmXf
	 5CgL2vp729Fn4tIGg2NF9JRuUnHUwPXUebOI5bk7q+me+gQyBEkONOT3qIwSgYvL2bmVB
	 cD3pFPauKbfQnVt376sj0uvsWh9nFcQYJaUYe0tpWlD07FFGwkqCXL8E4bpUtp4aMFxuQ
	 elmtq+fqznhpbsSGrbE3CPhJ/IQfhH/uC1+ugrtG+M9vJ53XZr6IYxsbVvGWBQ7g9rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aru/OSV6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C8606A31F
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aru/OSV6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0121A1F00898;
	Fri, 27 Nov 2026 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795787892;
	bh=5DLqUBwAG9IM3Nf9oehHOHuV7FovDr4OoUTPCPYnlPM=;
	h=Subject:From:Date:To;
	b=aru/OSV6KKFiLSXhlOxPMV2QiKRVfU3JXCPJyY9vle8RPzZtFD5KK0cz79FTtJK73
	 66lbLeBPhJjQdccBgkaRyPK8PyUXGZ08rGNngpvuKsspICQVIhZJZsYyj3xTDZ145y
	 rGPnHQIsFj4GxudNcWlksknsARjN3GDzhqeEDKPwSlbAdqQ2QY3JjY960Z5kxRg8KH
	 ecv8rVJCqaZoKo06VrdghY+1q/X0X03xUOT6hEHGd34p7S1tUNi6oRZ/SzeSSwIKFf
	 U0WwvQXK1gmDBYQk78z3NrrDff9r6mQ42BCDniuFyE2y0qtGhp/HgeJU6W+ylgzFfs
	 Xq0iYsDkMpByQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB882391B042;
	Fri, 27 Nov 2026 13:58:11 +0000 (UTC)
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
 <179578789052.1003863.1384739606709773619.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Nov 2026 13:58:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: fsl-lpspi: add atomic transfer support (2026-11-27T12:58:27)
  Superseding: [v2] spi: fsl-lpspi: add atomic transfer support (2026-11-27T07:34:53):
    [RFC,v2,1/1] spi: fsl-lpspi: add atomic transfer support

Checked 244 series in 2.51 seconds.
This project currently has 17226 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

