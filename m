Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438E1C6FF5;
	Thu,  7 May 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118951; cv=none; b=SX1CGl6GP3T0urQl8ZBfcLEP4ohGEY+zW61ruCstybNS75vfnbxFMruILiv5a2ht24g/B2YACmVSxlJ8ogwVP2uqbWDhZqP6vC3no1c2NIwm5kmbqnP0H7g23RErcnXmIKo3ErEFa/aMAqHAQ+XuanNq4pB9YXiktFD4gujEqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118951; c=relaxed/simple;
	bh=HmSssX1mkmHZczuAQsHC8mpZvxjJ8ykpKqPzUDK6R8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0m6yCnk+q9xGWkRNIfaOXq3Sc/6mKOL5wYXzkAgSGtAZSq3JFXyVz0WU2SFMAGHg/bgjr9SgzMfJUdXbSn4dM0dw6pVlyJkIgaao7564PrXHym/uy2t4nGkGIanqUJqMiYF4ex0Gy8a3S7ooe1IPYTk3/uhl6Audk4i9HFJ/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7E72tRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7E72tRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F5CC2BCB0;
	Thu,  7 May 2026 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118950;
	bh=HmSssX1mkmHZczuAQsHC8mpZvxjJ8ykpKqPzUDK6R8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s7E72tRfcpgr6klSGp/xQF8CXOa2Yr3ciYm2R3qmVK7PIXH+5vvbHvNOuyimAGGm9
	 PLLnosaUmwCqEfxH9ux94q9IoqxKJILYjL0vs2P19wKxC6bq7vJou0OeQu6iWY9qUa
	 19iCXoyhqZed4b7063deHKSh1YunU0Sc8+N/kf6TShC4n+J409YH5O21wyjAb0gEvr
	 ICn3Dtat/b9PdvFBK/g5/BOeO+EdRMnpzfYK1H2t+hIzJi1XzUMMcI9QkAJENfP/GL
	 D9mJjGe6DIIVXgy/KfQaiqaQRNskqrXgyd2CrDXplUrOHxFvogYjo4sUn8SlLmqSNX
	 qWHBER3uhJQOQ==
From: Yixun Lan <dlan@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guodong Xu <guodong@riscstar.com>
Cc: Yixun Lan <dlan@kernel.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Elder <elder@riscstar.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: (subset) [PATCH v10 0/3] spi: support the SpacemiT K1 SPI controller
Date: Thu,  7 May 2026 01:55:39 +0000
Message-ID: <177811891149.2316511.8217429551447102118.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com>
References: <20260502-spi-spacemit-k1-v10-0-f412e1ae8a34@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 02 May 2026 21:30:50 -0400, Guodong Xu wrote:
> This series adds support for the SPI controller found in the SpacemiT
> K1 SoC.  The driver currently supports only master mode.  The controller
> has two 32-entry FIFOs and supports PIO and DMA for transfers.
> 
> Starting with v8, I am taking over from Alex Elder to shepherd this
> series upstream.  Alex developed versions 1 through 7.
> 
> [...]

Applied, thanks!

[3/3] riscv: dts: spacemit: define a SPI controller node
      https://github.com/spacemit-com/linux/commit/c580774185426ea316396b1dc3f1737a3ad3800a

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
