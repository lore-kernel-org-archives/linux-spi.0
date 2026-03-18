Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956EA3E0C65;
	Thu, 19 Mar 2026 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933670; cv=none; b=ZxSwy1260XaCLu/8shxLoIZKgd5RtSUfLaFDDmQVKIeRqsG/xHAirirAUpnI9ayy+Ys9GxnAkoJQJ04V+PR+wpW9AE2Y6JvJn5s7QjE8oDiKTZGayw0aayVKs8h+Km5RthW6yf/8r5pwKNIy/IvQT7Vz03AXpeCEytxMFvBeYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933670; c=relaxed/simple;
	bh=UI0Po3zZPTeRCJm+Lcg0cPTJzeJMjW8JHmmBlLQ7sv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WjjF1wDNXzK8z1oy/PNSWh6Z5WKwN1WJjO4T8k/sNw3dSO5+3vxqmr84uVikxU0NAfzfKHRWjNLdON2UpSBdIAj2DV3blSMdgMeFfQtTkj/7YTgB+QEzg5t5B0Acvy3hgICitNAqy9l2pa91PK2RgueKeRe8yt43OvJwKUJ7D6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMG2IqVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMG2IqVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB57C19424;
	Thu, 19 Mar 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773933670;
	bh=UI0Po3zZPTeRCJm+Lcg0cPTJzeJMjW8JHmmBlLQ7sv0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DMG2IqVGrVoHd+WDIX2nJm5k+4XOhMVlANmg90qjr23nkh9KCntc77dD1vAi/RzjL
	 LIXXwj3k0Do/nm5Ru7H5HTfQ3/f+BaMXCn1KcLxAUL4ZMmRUWpJeZUsdAWBv0Yaxqv
	 IWyB8WBkcHHtHhJYxu8gEZg5iVQPDKtzV6WbhTeY45wjnPHOJ8qj6D8mdOmG98AOio
	 1c4orCeA38QUzN8g69H/CJjV0PD0ejYTiaZtAHXDLJCxgjmMDmntPAQ2jQm3PMUfJk
	 RHQedk3piyKEU9Ju6dMRwlL7Nm9maYeCENKStGCskv5+PDk340i7QHfE2AhH+DsX2T
	 jM9JBUSov8vlw==
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
Subject: Re: (subset) [PATCH 0/5] Add RSPIs support for RZ/G3E SoC
Message-Id: <177385558537.96554.829005700471715089.b4-ty@b4>
Date: Wed, 18 Mar 2026 17:39:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9787
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UI0Po3zZPTeRCJm+Lcg0cPTJzeJMjW8JHmmBlLQ7sv0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpvBRh+Ygk8AAonklht1UTda+DWI/9qlNX1PNYP
 VEb+8Z2DP+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabwUYQAKCRAk1otyXVSH
 0NCwB/wMoTtUcWjChT/PKi3QHwGtqZHHd5DQjjjxyCRPSuU7RoSr0FZZDIk9Ivv3ots0DfZxTQJ
 qJ2sqvjDAsWtVUwx53E2p2IrLIkctEKv/uLmF2OTJMwXRQ6KeD3BNDxEioU59ExCEuqgzdNvv0r
 h/xwBMz3ALCrrFE5FgfqR0fazJNsLjp9UkQD5zuYN4sA/kSyEPrBercubhgBB5sV0yu/Zo4F2ng
 kov1d+FxmBbIMFLsaBZ3PM4jjebz5GrkHcMsLxkpnwK4Am7L8BTE3D02KUUo1FmnghYCn87f9Qe
 cWTdIJ7HbN892xdI8F3dxS8FYMArnV0IJwY9oDzSJnVIkKW7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 17 Feb 2026 17:23:44 +0100, Tommaso Merciai wrote:
> Add RSPIs support for RZ/G3E SoC
> 
> Dear All,
> 
> This patch series adds RSPIs support for the Renesas
> RZ/G3E (a.k.a R9A09G047) R9A09G047 SoC.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[2/5] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
      https://git.kernel.org/broonie/spi/c/c2edd7841f58
[3/5] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support
      https://git.kernel.org/broonie/spi/c/5b7ac8ca0eae

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

