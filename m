Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578321;
	b=fx/ZUaj/LZsDmGKGZmsvKWCcUNtL1EbtaLXvXhmAtw2+g13sCRgi1con0YbkJXwrtaUK
	 8KzTQGTUrCdmNE411RFg9hhdiP3UJEeM3oeWOyl5LmyskyyTGB1eB9OpsOynelWc/Lhh+
	 x3i+tWDvSnWAvmSlkwzmnDf5wdN5YC3LdMuKaQD+yXHGG7CUCeaH0ht/UVzMC+7g41xNw
	 Septsj92VbFYGJcCITk/KQ3p5TZJV2p90MqL9ebvs7J1aQgd9YThB+EWBihWy2eeYTC9n
	 tTxCx+oOduUag4iotXKtnldXr0sTGr9yDD1a4cNifYjMtxUs0zsXdqoha7YEkcgUuWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578321;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Q/VGrMRuUTguKieTlbMIxTYEKC257MtQRObRYSjLDwA=;
	b=MmZezqxH3B/Q1D6aMSWRxd5opL84TtoNSp1w1IhcHYVwDywCfrcEzL/djjP9I6okS3Zh
	 w5ZFCYPARUyYiqVasCdydbDTlAkzRP/pfnXCNuw7nJbPaDCc0NTNGV/5xX080rNwgxmzV
	 BoHgl7TcIMt52aUGqLxG4mlRvyYwFT2E1uzn6w7az2vsbfAkMxIfrUa62ug0vCyqaATWL
	 /DpmPK0yvLfz19EwNCLbXl3rDJXS+YHvoygb/i7IGiaTkD0DQDZmzEa6ZwnLJqR5VCgoX
	 37xhkjoGxt7HtKe5t4/q5jPfTKPig0wlyucVvcR4FbsaywReH2VIQnN/dDh2Lehfz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CiJsd/3Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40B606A330
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiJsd/3Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9E81F000C4;
	Fri, 13 Nov 2026 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578321;
	bh=Q/VGrMRuUTguKieTlbMIxTYEKC257MtQRObRYSjLDwA=;
	h=Subject:From:Date:To;
	b=CiJsd/3YXVtm4cgDNh4zj7hjbo8H9WCAQcrUYNYkb944gGN3gP6RJbub49TgITMey
	 Rh/BRwTLLOW879HvOXgLYCwU7oke7TiNj9uKHnTzgxX3G1IVbszKhA9qtjmywhUW5e
	 lO8hkjWVgzGMjTaOVcvU2XPp1bVax7CB3un/KDXc6NWPHAbADDCjSbTgGbcAElHeTz
	 fMDwl0pN62qf1xhxxy3/sLqm4l9eHj3xz7b7i24+HyNRHzLwBYYZJ8X9UsRASvbRUD
	 9s2iuAuRyp7B84rtijeu46iaZvuFfu4G25C90s5WPFJs3bWo5dXAQ0PuQCl3tsQhg8
	 fVtKJtLqun06w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F166B3927075;
	Fri, 13 Nov 2026 13:58:40 +0000 (UTC)
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
 <179457831960.1064767.13881484372473384092.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Nov 2026 13:58:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Implement a atomic transfer as a last resort (2026-11-13T13:50:15)
  Superseding: [v1] spi: Implement a atomic transfer as a last resort (2026-11-06T18:18:21):
    [1/2] spi: Add infrastructure for atomic sync transfers
    [2/2] spi: rockchip: add an atomic transfer function

Checked 218 series in 3.42 seconds.
This project currently has 17059 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

