Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2A3E5A2A;
	Tue, 28 Jul 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238848; cv=none; b=F2TV2oIpD6sOILtsalCAOOqIbC1dP3t/n5UibByUnD90zCLP7hq84eokT2zRX54PF06AsIz1ELBbfdq2amyGoSaapnWH0hnvlCHayaR3XlBA4cfbDKZvfcy8H1KP76hb3ZiEq3TF23i+S+Znzday2tqGL6oXhgMstYnFiSZ/z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238848; c=relaxed/simple;
	bh=8pe0k7ldu5bkUFUiYhM/9qFDCo1PYWE1zU0SFKtRiCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L++iOzRPHnP8ANC4peDduK/5CijsR6Qh3GuJDAYizT/X/aB5TuC2lkkkGh49MezBgVT7MTudW5JbdsZDYAH8/6mErtMe0FLxqVhZI1DKLVJ1t/KRpcKaK9V9LJvngxSs7IrBIDax01hgrNKIzLvajEo3nsrYZ29PAOVDcIq7rmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OynG/Nt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OynG/Nt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D88D1F000E9;
	Tue, 28 Jul 2026 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238847;
	bh=eNeWYbTR74tZP7nHL7GdGElQBSXq6Vsaucp/Nwsmf7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OynG/Nt+c3Ep7wsaOFwFD57+iTBqHdirtUCye4OEcO6JdhCCbBcoXaYjvAYpTU1rm
	 9yDhQ0uU5gAeh1WS/zO6jwaAGkzZLH/DOFxlwt+35q4oHtm6P4SbgXInW4QYYW8JTY
	 4SrIkJW/ahu6r5XMFOUVfAb6vy8qdHAzumAjBf0kJJUTYOgO9VKNkTu877NSzhE6/q
	 QnUFhmOxcRE2ruqz2YqxKtphODCoDnxAyW1/cTgqUiP0xael3iiidSOsZDsQrPkrUW
	 PmZLjZBb/tT88EQBpZ/OotqsRI2/Fal6/7vo9tVODYhUR54od/MtQYqhS9CcCvfoKZ
	 bR2COLcrCFNZg==
From: Yixun Lan <dlan@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Brown <broonie@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Zhengyu He <hezhy472013@gmail.com>
Cc: Yixun Lan <dlan@kernel.org>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	wefu@redhat.com,
	liyeshan <yeshan.li@spacemit.com>,
	Guodong Xu <docular.xu@gmail.com>,
	Cody Kang <cody.kang.hk@outlook.com>
Subject: Re: (subset) [PATCH 0/4] spi: spacemit: support K3 SPI controllers
Date: Tue, 28 Jul 2026 11:40:36 +0000
Message-ID: <178523880270.625143.9262496497470921817.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
References: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Jul 2026 07:45:24 -0700, Zhengyu He wrote:
> This series adds K3 PDMA request numbers, documents the K3 SPI
> compatible, and enables SPI0 on the K3 CoM260-IFX.
> 
> This series is available here:
>   https://github.com/imguoguo/linux/tree/k3-com260-spi-v1
> 
> This series is based on v7.2-rc2.
> 
> [...]

Applied, thanks!

[1/4] riscv: dts: spacemit: add K3 PDMA request numbers
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=e57a4beb33df5b5b91e8af7c8abac5f49838d524
[3/4] riscv: dts: spacemit: add SPI controllers for K3
      https://git.kernel.org/pub/scm/linux/kernel/git/spacemit/linux.git/commit/?id=324c9c10839bec6da848b8947ca33e0b23d6b735

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
