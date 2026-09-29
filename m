Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4164D178C
	for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676621; cv=none; b=DKMd3mrRmFBueycuMjTMOFdOPeejlxUVp2jOcFiKaWl8EOaig73FpfqL66l4QbU6AC2dWRYDWCQ+2cUrwutclTuiFwTO9Uv30GzHCcx15pHQzwvpn16tnUlENt+E4jNhemgsnHm63t6YKzvwj5W3ZAXGYdbruM1Uh1khBgrl4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676621; c=relaxed/simple;
	bh=XS4fFppN6qE1zeZjDZ0wY1LPdJLkFw8Im2FmSSQTQVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RxiI/DQ3EOJHA96ihzu3q1TkF0AC7fjQJAeqa2Yz8sTD+ydjAdWyRTz7C119TS62YaE/0ji6L+YeE2HWas/MTf6l0ojzX2BB9H0MGVGSjU1xfSrY9tAlyPP6oGYfkeWQTqsK9dlIUjkVqCx1j/jN+lEimFKO+mb+ZR1DSz1zzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsC2GgIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsC2GgIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D481F0089A;
	Tue, 29 Sep 2026 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676609;
	bh=iKdYvudiGOWtTn44DUS1e9z+ICM8SVFQYPk0pLma7HQ=;
	h=Subject:From:Date:To;
	b=fsC2GgIovP8uy1Kq5ycfatJ/0JOqSwEb9XZ4kdGbCZKtWE82L58CF4lcPr0R/Adi2
	 GaJ0HnKkdkFv2v2SAJaxDqHn+fN1jeBKTxWbNoZzK7dJVPL6cYeNB8I8VEYilDm6Pz
	 AKn4jTuVVHKQ9lbzTg3WBxaEsjgHhmZe1PCAoqKqmhSoJfc8wElgi3rzQ+gGPX6y49
	 iHpA5yra+roLE5AXUFmXm4iWgtjfED66iDh+Hyp7B4VnxKBhi54eaOqhAbDOIYe442
	 IUvypmQbCbVDEk8mKIR/XGeIHIwCeo8stPlox4jiIbeoPyEe6haf2/wngWqT1bpRAI
	 73mXLhoTztZ8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6DB0392639F;
	Tue, 29 Sep 2026 10:10:09 +0000 (UTC)
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
 <179067660821.399852.13385781672825667772.git-patchwork-summary@kernel.org>
Date: Tue, 29 Sep 2026 10:10:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v5] spi: dt-bindings: microchip,pic32mzda-spi: Convert to DT schema
  Submitter: Udaya Kiran Challa <challauday369@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1151629/
  Lore link: https://lore.kernel.org/r/20260825162257.77042-1-challauday369@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


