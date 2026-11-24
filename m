Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531029;
	b=BNSeBiZDF93nSSduJ2kb2hakR0QyPqorCEGABXiKNC1mM9tPPoBxuoSWfqMNtCDMxgV2
	 biwC2j0VrEsX6wbQ53iB15K+mM0eYGjmd6iq5cbf9PVIssvUKYIQyAJ7jpL459s0D7rXJ
	 59R4Hc79JnrYKK3U8wyN9N0A9DaVCmUrePQuoExs437ajdUF7wwVlA6dGnyz95YsYG8P8
	 NcQWXeQWce4sMqLSODOpV1vW4PZKR86o4bOSZwVAlkvW0brm8E035Pr9OE6wxZsV9ggqM
	 cWV5p1bTcowsWdg19sonqraJvuLMtEz27tYe/X7FdND9eIIlZaUR2aOC0GEqgzV++XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531029;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JHie8fWAj6A2BHLBsAbT3FIVRK6/99JunGJpILvdj+8=;
	b=FTSSLQYUBxGRGUSk3BVD0lxpNxb/A//ZOkAxAzn3Y9kGVEb2lyLrRk2NX+09VoUJy38X
	 wGu2ySDAFuGjuw3Bzgj/h4trM2hJV4zwdPSASXYm5zbvAm1EqFXPWMvOlqsfC1bw1jR2Y
	 aHzvNfenKhpQsql33bz1Qnrc6Ya0R41b+F5F1qNpPTAMIMHGTtvR9n6MZm/vDfU6lhj+J
	 aUsR60yhxnrDTXOzzGBkovtuHjgiqcivfy6bm5U41G2Mwz2eZqzfjRx51cSKoivIgTghW
	 X97A3jYY+NVRk/b6PihrSiYC3Fi6N0WP2BPIfe6iQpsI8/Dy3oK9MeZktRjLMsHn4dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXPlAhNs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F4606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXPlAhNs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DEB1F000C6;
	Tue, 24 Nov 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795531028;
	bh=JHie8fWAj6A2BHLBsAbT3FIVRK6/99JunGJpILvdj+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QXPlAhNsEiSSNiRdS5i2OhxZ6sNUb9bPkzdxMrxP7oHG7I3MyYWoxYB6anTCZ76w8
	 kgtKEkpHYcgL0c/sIIcQwnLDMDwPq1agxxmEr/+nXjGiecD3uzbLtn8jn/b2iFTATD
	 sJRVFQNnz7jp8eGDqvlxKSsAQqQ7Mf3DkS9ZWTOCzXSBIRGjX8dyMECSSpDje9p0eE
	 WJ8oc8DIEd66H+hIIBI/sVcd4DYWshpLZ+1yNKgQsNGQyHGx8RTC0e/zDv5oVu3d+k
	 MLd4qPzBbUge0piJI6CeORLAhDn5dCC9LR/ME/NTDY/dOirN0Q3bwEK33DQcGgDi5Y
	 BwZt68rj7jYGg==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linusw@kernel.org>, linux-spi@vger.kernel.org, 
 Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261117020646.20111-1-luoyifan@cmss.chinamobile.com>
References: <20261117020646.20111-1-luoyifan@cmss.chinamobile.com>
Subject: Re: [PATCH] spi: orion: handle clock failures on runtime resume
Message-Id: <179552765811.264265.12160006862599570767.b4-ty@b4>
Date: Tue, 24 Nov 2026 13:40:58 +0000
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=broonie@kernel.org;
 h=from:subject:message-id; bh=xpScwKVrQjm4gon7V/Z3meCGOFMtuSLdbczoP8wZZkE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJZFwqaOaQkakyZe/Dw2+ZFF+bGs7WlXNyalmA+Q9Pnl
 cEO99dXO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjAR5R8Mf3gDWwL27tq13M+5
 LPTyofXnrujc8fbYVe5WLycb9SFh6xOGfxZy5c/39fE/ctiy6b5k0C61F0e/GLTPa752L2LFom0
 GRxgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 17 Nov 2026 10:06:46 +0800, Luo Yifan wrote:
> spi: orion: handle clock failures on runtime resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: orion: handle clock failures on runtime resume
      https://git.kernel.org/broonie/spi/c/b6f9117472ca

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

