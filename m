Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810406;
	b=B+n76mf7WUXG9iGI3URiAIOeLacS5q5PGhSOj5pQ2wsNYuGfhFyykgNDGjvVv/fokTEv
	 sTbTuFe62tg561ITuZ7dga/qfJSM5tjU87sH2Xj20j0t3+GdZ8pdIAAPZ2nEvjDOvJWYO
	 7WW+69Q/FX9zQE8gK3zfOUn8YnaXDkOhMRHMb+XktuwJAVJvtLJiF40MzwMtk73V07XAy
	 x4mKdzyDiT19RZ6fI1m6HTojo4sR7X+3NbbbGrqUjvJuu21OzVH2vHi82djXtlZevstSx
	 s1jMN5PgDqFk1OVD0Q9jCEdpz4ibP72Kdyy7MJDb2vJheEVoAiBPOg6eCJ4KSrf194Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=eItgYOXukZjoENEeov0VZ2n0A6fgOiEvH9LO3OYOw2w=;
	b=CGg1X5JXyN3DIpZOl8vBYPQadJqQ2Gs6SVO09NAji60mig6Hsuj/onMsLyUIcn2/oPmb
	 eaDaUfs8+e5uKIhst+VdJFeitYrxNQIUtX/gZNW8Y7dW13KvI8alMyTZmcNza+WSV2nte
	 Cz+Pl2t5o63cdjtu3yk+7b4lcw94mN8aZfc9nAextJTSB8cZm8ixvW6f+ESM9Cp81hr9d
	 0/FXliHEu3cNawkgl7F0HSo6Rny0TsFgHaLJ+JXyi6ry1wTIQo2s7gScQnycBdRYM2kL/
	 yczoG9PfxQoHI6kYFPpRrZ9mFoOJk0pCd+nmMvFXZfEbPi9VaMJI+f6HdzfvussGCxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItdkNLlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCB606A328
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItdkNLlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D511F00A02;
	Wed,  4 Nov 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810406;
	bh=eItgYOXukZjoENEeov0VZ2n0A6fgOiEvH9LO3OYOw2w=;
	h=Subject:From:Date:To;
	b=ItdkNLlG6IKa1hyQMdjs7kBnPbpNcj++5dRxWLGzRB+3kaMoDvRnVGZYYCG2lYG4N
	 Hx25+iW5NTx4vWaQJR5DBo3T10xI40AlPHsckSoUvuwvnHkcTGbNJ7NG32EnbBI59h
	 rsBczoHJD/Rgk79Wh8ilXqUvktDIA5okGM1swgV7jUase4Yw2get0gVZzjHLcKAK2y
	 PNyH4BFquXmNVIz/LbkApgz83TDbPhFy7B8s10oBy2+iRDGgcBAs9qjoD0h99+6Wa4
	 OMvKWrBaL4hCChboMcU4p3E/RFhbX3FdAWmaNxugcPTP8AIMs9LjxULzyiGw3P3CBR
	 N61xzdx/HgIfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4269039E8A5B;
	Wed,  4 Nov 2026 16:40:06 +0000 (UTC)
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
 <179381040493.2936092.1961189749982168620.git-patchwork-summary@kernel.org>
Date: Wed, 04 Nov 2026 16:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ljca: Don't require data in write replies
  Submitter: Arpith Alexander <arpith99@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1200367/
  Lore link: https://lore.kernel.org/r/20261103131435.21838-1-arpith99@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


