Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050486;
	b=hAGqUV22++0AEoHXPExOCk6KoJpmGDXFWuCtppdw8lLNjt3WtD7H8ddron95VmHSeelj
	 xru2yrnlkHFVuN2IG3NSCpgLfJhl2AuDLjKehI07U58oC/cRjMLMvMbHDiHLIes9kX5mD
	 JonU8OTOgSwmB6/1P8AVFJGmj6Vmn14AMTRitlrtg7r/ltwYabG7si43yF6U/FnSAX94H
	 u7jWsIQZ8p+HKKrWDD+i3U8gQnzjBXuCpI67aeUsow3eHC6Mx5M1HCOqyvjz0TAYT8lVL
	 z2eGn+6690NC4YdnpkXCg+t3cvedUy/eVwMFv0WMwNdZVZn4rGzYU/TvC5EtShPPsTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050486;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=2+q1YYA4vO4SsJIvsabeKvjeoQQ177/52wq8uLUFStw=;
	b=zV0nzUJ83tX40uDJLXCVqEFzRZ+SgmwfGvc7NeCFuPo+aNWIcdqmi8ao6NLTFVJEStPE
	 Vp1rml/wKntN0Z78xMvDESeCs6OBICwQVAoxrVdIoH8tkMQgWAK8DaVm7yBM8e8BCaqxr
	 t4dXOR+skCCmr4BdcE/xHl34CT7rPIZa5dfy+FztSZh7Eutgopn3MG370D7UAEsq2Lu6P
	 uXItpqHHlKJgj9X7PbMCDfKx6gf0hKxlsv72d11L7LVN+MZew85Q0NXzERbtpNFaGUHwr
	 CiEtxL9NRDjrnJ5ciXQOu3q1V1i1MIvuJZkEu5dl9+yvz/aFvRTimCRnCs+TTV1hDWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuF9vh4f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8D606A31A;
	Mon, 26 Oct 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuF9vh4f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAA31F01825;
	Mon, 26 Oct 2026 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050485;
	bh=2+q1YYA4vO4SsJIvsabeKvjeoQQ177/52wq8uLUFStw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KuF9vh4fl33t7X0z5U07koeYQW0U9pYmcfU7B8oU9Cd4/4bUmZeNFt2KmOe7ESLrB
	 imCnhJ3gD97SR0IZ/1KscjmdiZ5MmCgFPLg8U26IXCYQ4f542hgABmMLVnBWxvTHp6
	 zOrsvRIJPVE7Z5Y3tPmp2bZFcIsisvfXOaUut+P1e1bVzNEOLnc57WRbSjUA9SIOG3
	 FOlq1rJ3pd643lzNuKHY3iZaqPzLe6gq3fquTOx9IdSs7Ggqqp7Vw57OdAgKMX16i6
	 hLXW7ARfmCIMl8LKdrHmp9MLaf0J5+mogQEeIkVxqEtV0GpgTaSe/N1vIf6Eg0A06y
	 S55mqUl876T5w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id F0F151F421C2;
	Mon, 26 Oct 2026 21:34:28 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: rf@opensource.cirrus.com, david.rhodes@cirrus.com, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Rodon?= <jeremie.rodon@gmail.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-spi@vger.kernel.org
In-Reply-To: <20261025095037.18891-1-jeremie.rodon@gmail.com>
References: <20261025095037.18891-1-jeremie.rodon@gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Add speaker ID quirk for Dell XPS 13
 DX13260 SKU 0E54
Message-Id: <179303922317.199157.1921734785998960263.b4-ty@b4>
Date: Mon, 26 Oct 2026 18:27:03 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4Fd4Of6OcGnjJNJCeSIO1thbVPW9iR4juv012a4Q/uA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLuH0/pc9Rfce8RN/eTlYnmZ19a3S81SzPflOveLbvGd
 c3C85YdHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZiIUwDD/9gLX+zm/tbi/O15
 prGg5syJBVezElfEKIsmMDOU2t1S1GRkOP+X6VXikfL2pj83dVsaOlp67857JzbBbv6B5JbD8Q/
 Y2QA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 25 Oct 2026 10:50:37 +0100, Jérémie Rodon wrote:
> spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54
      https://git.kernel.org/broonie/spi/c/7da2aca12375

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

