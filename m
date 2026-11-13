Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538716;
	b=hR1lCYHADvNzeYKk9z8jmG6AXYc6oSWoByNJmvNQzSKjWItAtbxHA7yaUtrDFFTsW3Dj
	 I182aoVtOL+lEXCYRcKU/PaPFVsBnISwmJhsjVqfJx2Fq1eQzRdFQBQI3Cl6geqDhfIcO
	 9paheT0n18pgaqgwv5Bfa+0NHTgFGO7qJPXeEJj6OfDbU6gtQBxxoko19YxI0AykpiSZG
	 4OWUMLJ65U5dtBJV3IGAPCTXUK2aDjl47f4Esz1DK+Zr6kNlYPEt8HeDj4KPtDHAd7F8G
	 5DXp7aUxPM5ok/g34dahY+6be2f3obJNXu6DLuYxCPYST6v/pYNehbgMwYCrs4kKrlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538716;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=nPr+YTa1Gnih4ozNxdeLFaUP0EvHj7tboZXTJyqEBow=;
	b=GbqanEKdHo9ZPc+23k1EZLZieW9hVH5MDT2OKmS0ES/u4iIBbJpsVTHWAcirO4FnBtvB
	 T31VSE1StL1sR2IY7pIJo8aMVCbR/+no5U6alYX0bWtOQre1E+FJlGesTCCJALJGXPerL
	 6vXU+Hr2VfIGdXFxvnIQGtbEVEwcmlOo6qvHQYUgGt0aRqt5wcIhpCFVTRYS2IH7hlzOa
	 YBWsmbC1viNdF2vk4yF8KcatR4hcW1OgaFYYjUzu/whCZFlTgy1yH4zOofOZ6WTbZoPJz
	 c26XX2mGqjLKlCLOO1srPTWDXm4OY2dHFpPeWA41nMrZGzKcnvK7J2/V+fz3hBLXp5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SP2hR734;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647C606A31C
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SP2hR734
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E2D1F000C4;
	Fri, 13 Nov 2026 02:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538716;
	bh=nPr+YTa1Gnih4ozNxdeLFaUP0EvHj7tboZXTJyqEBow=;
	h=Subject:From:Date:To;
	b=SP2hR734JmNHD9+QRalN/NQZl6LkuxERXW1d2bR/zZQtQZhSdHMGjJ9MY8eqUPGao
	 RFBIMS9pvBhIAL/FJWZHzZgPapSy820+CT/bwSvykKrCp+aS/flWKZJSZs/CxpZoSt
	 X/hSv9NEV3XtZlgZiTQrGeNigCPlphVe7Wdi5bsrODKQ+Cu/aZ8p+d81fnH7MtlCT5
	 7oY3g8Pgm2y5YpH+WaE9BR2JvcZj+FSolCAfwVOAobRrD/YrS59QtqoZ5u3MnORyHb
	 LL0hv//XL84ZY25yb1ZVI62j3yP2TwRCZOBp3rV7TDzKpxziPc4Jj6qszKLKHB+p8+
	 vcwq8pEZYhvuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7740B392638E;
	Fri, 13 Nov 2026 02:58:36 +0000 (UTC)
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
 <179453871512.773030.13010661882254799954.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Nov 2026 02:58:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: unoptimize message when queuing it fails (2026-11-13T02:03:50)
  Superseding: [v2] spi: unoptimize message when queuing it fails (2026-11-03T22:47:51):
    [v2,1/2] spi: unoptimize message when queuing it fails
    [v2,2/2] spi: add KUnit tests for message optimize state on queue errors

Checked 217 series in 3.41 seconds.
This project currently has 17045 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

