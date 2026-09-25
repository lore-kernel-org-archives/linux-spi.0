Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8E54AD7F4
	for <linux-spi@vger.kernel.org>; Fri, 25 Sep 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347287; cv=none; b=WEW/amDjSdUzXQ3/D+oF1sEpL7ZHk3GpS346eFAimJu8KrrZvGwGLbQDC9wL3M4/UQpphkLtoVMRfsG5BFRBdWw5wVbBQ6uxY4a/UDWX8hFh6athY9EybG/vFOhxzHgok4Q0uLSgZnOmHC+uwdWbun3QTYuVfsVCUDww9lNT5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347287; c=relaxed/simple;
	bh=SsB0qYFSXrhNuVZqVPYONjAGogG40Mg+lbNgapl3fIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HBvTdoi6pK5dojB/J0sUfe2DT+PGx62oJzeXap3ZkrdbzOuMUX1c5J0/1nGK1ElhGkc2xOOgDX+UwTZOZwaP2V9NCofoLenV0xZAFHNQOGDmpCNNyQKvSnY0enZEIcYr+cBLtkuG6FQn/Woy1nNK7EzHPYIBuax5CWadA22DbBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByH52Y5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByH52Y5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD501F000FF;
	Fri, 25 Sep 2026 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347278;
	bh=f/PmjVtC3DYmtHZY53PQX7hoifRZwr3o45xTUCx89BI=;
	h=Subject:From:Date:To;
	b=ByH52Y5vtCUot8D1XMPdVlUorBouyQo9UXMlvASBq5g+s2NtM5gzABgqV4ReCAD+/
	 9SioOzCeiWNRz+U5YB+MicYP0pl2GRRfigPCQ1oJM58JcoTqONeC9Va0ay+friUUBC
	 CZEj4Hqo0oQ5AiY4NKQ/XwQ4n7SVe4FhTSAtU5CEij2BmzjXfhWfmgo9ynLJUcCP9h
	 yTP9xJBdWsu+oMWl24OHH+aAryXcrDHv1uh/74I472n7/KwT2zLy36oUjZScOL+Xxd
	 B/t2h8iYvDMce2Pyj0mbuA+Ak3X93cCrocmEptNOs2K6v8OPHRFEqb+jZ9LK4Rktuc
	 zIRj4Su95Kv+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198423AA6A6B;
	Fri, 25 Sep 2026 14:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179034720656.2539599.18281814253058834197.git-patchwork-summary@kernel.org>
Date: Fri, 25 Sep 2026 14:40:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: rockchip-sfc: skip DMA cleanup in PIO mode
  Submitter: Myeonghun Pak <mhun512@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163583/
  Lore link: https://lore.kernel.org/r/20260912190056.42192-1-mhun512@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


