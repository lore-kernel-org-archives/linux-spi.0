Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149017;
	b=IOJSa0hOq4Z+wWuYqKUj0kpWxoXtVNVjE9J9RMdsoq/hmNKQ7j/upN8ysKZvfWfJHuoD
	 Tai/B+TaTC8+M0Hgzqfc3LnHtHYm4HE4Lw4kWz2avvLznfsHC7oe+Sgrbq9eEcQUNt7XV
	 zmBtFotK4q/6rGpFUlMOtom1fSgcHCe9XWymeXeygU4hfSKxQ56YnM2LcIT39lTC4vOlU
	 q7Eafx+bK/91MT4sFK5nPsGkTrRJUVFszTbrWjde5wCgSgRB8neSOgS7AODb8KdDmkWgu
	 qfDIPB2jSOoCVS3VFlytMQD2TRUYOXNYxDL4JN1bxUIz/wVLxRLAeGeTaFb1bmKluHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149017;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+tm4BTgPIBAp6plHBDahXEWTBlRuFrOeb/xwJ8hxjCg=;
	b=4E4PRyQQ1RIERow6/QTwiwtAK3xtYM1N96znIPM0VdjkBQiLliFY1e846e/dChpD5vLq
	 D/b+MO0waiOczGQWujksn7zAVGrGJHJ4pCzd/RIxczaMzLLsWln4QqGJTpm8R+U/4l0wG
	 d4KNVHIy6pqnpebwwj5BWqAPROn8Md+0LWbP3MdnwS25lAh+GJMXERnG18pP0FZxMFc5M
	 z43uW0891Cr4Vo1E0sfgPLb7mRa4hxGeyN4AA/JPKu5e2Tb9pmWc+eTuA+Lom2Ob5XpBu
	 1zwR0cp9c6CSqE2sJVAkrtJX2ecjtjP+sr+Q3Ew6PNPI9HESs5iGjnI1eNk2jK7iZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGiSysfj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBEB606A32A;
	Sun,  8 Nov 2026 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGiSysfj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4CD1F0089F;
	Sun,  8 Nov 2026 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794149017;
	bh=+tm4BTgPIBAp6plHBDahXEWTBlRuFrOeb/xwJ8hxjCg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kGiSysfj8kybVExITvIa+Rgny3CtFnYPEHPOMdnhj22NbAlhnmy6lZgGJbZeLuE68
	 grHW2l5ETugYjbqt+olg0hmCxMet4DY9rcqoblhoGP5rQzdf5L4VSK9i79FxqtCYPh
	 UvxBu/oPZejSjxcC7fp522TVbY2NiIyIply5YT3LqBn9MaRuKd/ws574umzmPm7Ete
	 druprc/WJ+WFFWdzFWPokJ5MfMogoAy0Y4vbIkl+KRxYCRaC7h6uatklEB/W7IrY4s
	 Z3ahnI2cJsA0vBb5645z1v1TlQO6UP60UIsO/Pctn//txxC90ubq6AOQsTIoehfBk+
	 4ms8nbsz1ZQSA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id AA0E22CCC443;
	Sun, 08 Nov 2026 14:43:34 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 0/2] spi: zynq-qspi: use a flash larger than 16 MiB
From: Mark Brown <broonie@kernel.org>
To: Mario Behn <mario.behn@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261105203734.979168-1-mario.behn@gmail.com>
References: <20261105203734.979168-1-mario.behn@gmail.com>
Date: Sun, 08 Nov 2026 14:43:32 +0000
Message-Id: <179414901284.3711751.10991353733886072058.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=364; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pqc5RxFKFgQ0bMGkW74l/iVdEQnONDkkAA36niVKYPg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+dE07pszyzk46L8Jkdm5wRuvue1+Uk/7ZNFXfKq92F
 1KQcDzWUcrCIMbFICumyBKXxf2yvuT1Gr6DC9tg5rAygQxh4OIUgImsamP4p7H4fkXu18t56z8c
 adxxm1E4zr1AfnG4wd/2AqE5QSc53BgZ3v5xkpX3++v7sVm00zNCfUboleDsyds5Pz77xbW9LpG
 fCQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The Zynq-7000 QSPI controller sends at most 3 address bytes. spi-nor
> needs 4-byte addresses for a flash larger than 16 MiB, so on a board
> with a 32 MiB W25Q256 (the ADALM-PLUTO+ has one) the probe fails with
> -EINVAL and no mtd device appears.

This doesn't apply against current code, please check and resend.

-- 
Mark Brown <broonie@kernel.org>
