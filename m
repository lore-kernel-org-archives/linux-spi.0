Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DF38B7D4;
	Thu, 19 Mar 2026 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920348; cv=none; b=hoKknQwq1441jwo9/VIUENodxkcj39PmzPnLmkOI6AN7y3NugK1JXpp7WIqnBhEdeREL3OlzOTynHQTV/Bz3ul5mACRYTJyHsctrmRuF2RuEVWXxp0DRM+TKpA19ypDF9l5u+py3Qdr5cq1F3RByfCSJRRPqOsy+b9bXb0ttnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920348; c=relaxed/simple;
	bh=lh508JUR5Tcgud/XjW9UWdfwOGC20T/hDgvPa65bwxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nAppXIrDi3k7DXEMwpfaEJmYMgZrxNYCtZXPyPDa28Q7FZ4QxdpTiwu6oKOU3PUYdsCWQSvyS4t57tBnjvYFatDue0/9L84bHHSX66NWDm9cIGl8cbLZzRAB4RLFb+vUjZKUigO5V15CGZ6m9oAHGtwsayR/lDnZpnxDrGJ7Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6X6Wdsa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6X6Wdsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EA5C19424;
	Thu, 19 Mar 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920347;
	bh=lh508JUR5Tcgud/XjW9UWdfwOGC20T/hDgvPa65bwxE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o6X6Wdsakg5fhp4HA2aWLuiC5pLxkaNlefHtGR/b0qhOea5nyqsRiuFAyypjvoieP
	 w3sWLU4S6bZM/e7t9t6MIihZBqsDKLi3LW63HpoDCyy5OHvjSkuoyryML1duFT6HyZ
	 ZJRi46/EEXGH4YuUyUai0gI+8m4CrVjVSFnh5LC+5gXO0utYYJWS3ftQ4AsutITPbi
	 PwScHxYCKUAkG8ZVXp0xjUYJ90juGA1MU/66AkvalVcxrPVaPDOesEpowFhScFnPag
	 UX0TNGT/72iNrfOb9K4MuVROsACHDNbXO8VNEtF1bWDhdes/skWk/Ns5+LsFFh11XE
	 LCFd+S9eINVxg==
From: Mark Brown <broonie@kernel.org>
To: tomm.merciai@gmail.com, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
In-Reply-To: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH 0/5] Add RSPIs support for RZ/G3E SoC
Message-Id: <177392034458.38435.2133228084279872320.b4-ty@b4>
Date: Thu, 19 Mar 2026 11:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9787

On Tue, 17 Feb 2026 17:23:44 +0100, Tommaso Merciai wrote:
> This patch series adds RSPIs support for the Renesas
> RZ/G3E (a.k.a R9A09G047) R9A09G047 SoC.
> 
> Series apply on top of [0].
> 
> [0] https://lore.kernel.org/all/20260128215132.1353381-2-cosmin-gabriel.tanislav.xa@renesas.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] clk: renesas: r9a09g047: Add entries for the RSPIs
      (no commit info)
[2/5] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
      https://git.kernel.org/broonie/misc/c/c2edd7841f58
[3/5] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
      https://git.kernel.org/broonie/misc/c/5b7ac8ca0eae
[4/5] arm64: dts: renesas: r9a09g047: Add RSPI nodes
      (no commit info)
[5/5] arm64: dts: renesas: r9a09g047e57-smarc: Enable RSPI0
      (no commit info)

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

