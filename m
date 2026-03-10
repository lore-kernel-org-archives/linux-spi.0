Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637635836A;
	Tue, 10 Mar 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171669; cv=none; b=fRMcFF6wED+iTZCF8EKFSLw2kYFlI0jKclmuHjMhm5jMkxJjjabIcTDy+CmeCQj4EnboPpvlpCXAaxsEL+GkQmemumfg5nXxBhUP3yDpCUrQKEWx4Y6HUCNxs8/UYq/6Xd5USkMNFlpk5JJWpJmqyOQmCFYMmNaho1aiTGR8IpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171669; c=relaxed/simple;
	bh=uRuTui0xDsqEK6tmEHWYymsoNQxWbfPW1yTO/F4Fpfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nlhFJNXG3m0PgngampslsztT4mOsuIeYnyhkGQocrukUlFt92C34RViAGkb9ulNs9yshXFAZMcBJhzmBhPc+v03vpW1JrOX31GxShqTjAfW3Tu7i6nahoY8kdCnByVlXnncwCySc41tWIJy9qKki//JgXG2+aDdqmCpPKJG5xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9pyI3B0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9pyI3B0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CBCC19423;
	Tue, 10 Mar 2026 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773171669;
	bh=uRuTui0xDsqEK6tmEHWYymsoNQxWbfPW1yTO/F4Fpfw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P9pyI3B0o0kr1YSj6A7xUWAiervv+2glz9ZVyWFtQZvl42Zs5tdmmBEkGSR9Rs1au
	 K7U4og2f6wLlckHdZc1bo/WmaUr/pgwIo84EJQgiYDe2+/blYLrx+7i3SliM30WK5D
	 KPH4E1fQ2LGWEJ5f8CBzx2X5HG5oQlslz4ldboj7FF+kuvHOcaRS/CF3tb54DDxz/e
	 zgl1kCoJ7hd2X2SkzSJlhExQDGYaROgJR1JDk2s+LoD2i41SWoq+W/EwngPC/cIezk
	 auWwrio2KAqSCqJC9jXpXX98hfSTNpwmy7sSwLIUS7JNJgRMtlfFgTZ8psU1VarOHo
	 SpGgE+PI2FYVg==
From: Chen-Yu Tsai <wens@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302153559.3199783-1-wens@kernel.org>
References: <20260302153559.3199783-1-wens@kernel.org>
Subject: Re: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add
 SPI NAND
Message-Id: <177317166704.379398.1719490251066452420.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 03:41:07 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 02 Mar 2026 23:35:55 +0800, Chen-Yu Tsai wrote:
> This is v2 of my Avaota A1 SPI NAND enablement series.
> 
> Changes since v1:
> - DT bindings (Krzysztof)
>   - Moved "allOf:" block after "required:" block
>   - Dropped "type:" from child node in conditional block
> - Collected tags
> - Link to v1:
>   https://lore.kernel.org/linux-sunxi/20260227175157.2339758-1-wens@kernel.org/
> 
> [...]

Applied to sunxi/dt-for-7.1 in local tree, thanks!

[1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
      commit: e2f93f45d38f7b6dacb44203cfc7bb5d7e287b8e
[2/3] arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ pins
      commit: 1a5ff6a0a8c2a0dc9f2d55039997c1cd928eb53c
[3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
      commit: 1b07332bf2ee816130e139a8966d312bf1aa32f9

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

