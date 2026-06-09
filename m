Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AA36EAAC
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020707; cv=none; b=Itc3GeEdVo0usjStLlP5wJdRgcRhezDH/vyCairl2cehHTJ5Lawj1agjFabMoh6Jgsz4Gu0lTWQ+gmt8Nmbv1C9ONBjguhKWJmdvL8v3ptxpi/odMjfTsMt625BFlOtNDybZwbNe/dgTCVoNCI9koz+pLNF0l2HNAlfrjRoUoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020707; c=relaxed/simple;
	bh=AG/RMRBYHlyE+FnFXRo7oNWDZvHwtx9QUkE+iLiyjzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P1dgqzFZUgxWutOlxoP04vzXdWp3I120DjreooML1RRemtyUJki8gSRRtHqZdsEdhAozxPO5LFScnxuGEiFRv69eZ7y3xUbqaeh3nMB3mXV4Kr1pM6EMgz1vtedfswewOyFnALD7iL2VqZVjZZR+JwYSuZHoa4YI7jeKQpOh7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9PqdeUV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9PqdeUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B51F00893;
	Tue,  9 Jun 2026 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020706;
	bh=nViJS78Wy/4cJV4xcRxTCqtNzZisODflpOCuKCzUdjw=;
	h=Subject:From:Date:To;
	b=n9PqdeUVNi26oTKwTYb+7LDTaSRHPR6S0uDSwm5Qg0GXrkTbb2OwGhg7o0ZqIm6jB
	 4cZSTrx15b5S6DnR/hyukiWAr6ULNckPWu/cHuong5Zv6FlSxGLYaZPdnDrBvWtwOW
	 P+iQjT7F7LhhlyHFktnPpa4GAEWgxvNI9FRn8czEUSveqfdtIFLRIuY+o9+VGpWcFT
	 eCkNlfeEvZ0fVzsSccSa1ATVKsNCXvgWazOW57R563MEtgAVXNwKiuCBU/mj5Naf+O
	 /y+KSFFjn0RMFbd/aZgc+8mM6ayEOe2j3O/+w6ekN2xPLrGSy7Aa+tJVi4Ru+AP9WY
	 SrshA+zHVtcWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3489393091B;
	Tue,  9 Jun 2026 15:58:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178102070437.2110862.2839251252719785449.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jun 2026 15:58:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-09T15:54:35)
  Superseding: [v2] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-08T17:54:16):
    [v2,1/2] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
    [v2,2/2] spi: dt-bindings: nuvoton,npcm-fiu: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

