Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF122D785;
	Mon, 16 Mar 2026 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625063; cv=none; b=LQqZq/uYYTxAXtg2xTWXmm06Bd9XeYABoF1k2Rn+ApDt3W2Xp5MpXLJHVns9Epv/096gi9wQXqQ8kyo8LoAagVz6AVu7VKvIy2ZcZ2UWqJ0XkCnjqj548vE/uLpgrRy4nbt2KtL/55EcNTrFP8WW+IwsyapPaV/1bcdCH6wl5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625063; c=relaxed/simple;
	bh=TGQIw/q/zFMyHgT9wXEpWPAd2N2W6JnYL+lx6HkddLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vcir6blr3tf05Caz75Xrtmk9d+lyROWcNcTs15PrhssaH1omTbwXSgeybg8Pi3kvyJUvOj0U7+8brQQ7NFs53P43kx+K6UVh7EFsUF+HfIPovMU5sXYISTrViAIIKoYNfAHZiONEaYvsK1ZjSYs/yjiUldn7h/qKTEtlnPjSr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRzD8sxt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRzD8sxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF8C19425;
	Mon, 16 Mar 2026 01:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625062;
	bh=TGQIw/q/zFMyHgT9wXEpWPAd2N2W6JnYL+lx6HkddLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FRzD8sxtWGzZf04kzC7Xi/txIeltFmL7gxMkHHZhlxDQcObQTW7bT1CEcFWxmAxZY
	 1o+6rc64q4fh6e6ahab9n03frJz8mZ3rvcOkdgKvlZYrbMWLahfiylHFyDDYfQNmaO
	 OQ9vqB6MXJeubc69yr4l+rSQGAg4hihvqsoyxyiVprNtfXfV4pU3lePKCQwWPQFmv2
	 1e9LPCKyw61UXetoeVulORj/r6wrJuvRWa/1JczJAsB2KWV8GreUb7qpk3Fy6DfYba
	 qzIT8KP9I2iNo2HLLyIWy3VzHVHs/u9FiwvljbmhzWkQVhQqJVWBlobXjNieLrR9UV
	 zNCmusXetr/cA==
From: Mark Brown <broonie@kernel.org>
To: Jernej Skrabec <jernej@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302153559.3199783-1-wens@kernel.org>
References: <20260302153559.3199783-1-wens@kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] arm64: allwinner: sun55i-t527:
 avaota-a1: Add SPI NAND
Message-Id: <177352554724.149922.11236010638417672034.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 21:59:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TGQIw/q/zFMyHgT9wXEpWPAd2N2W6JnYL+lx6HkddLk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt17jchZo0gt311TnfM91Px7xeMUnDDWgGnHg5
 aPZt2gS/jyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabde4wAKCRAk1otyXVSH
 0NkBB/96GMZnNoZeWsfT+kcGAZx6S+Ao310k+PbeK/xJt271Tz0NrWNlPvQZCLXxs4SQNIZFO5M
 Dr4zSEidJE/ORmsiypIqH6qztsrTp9KGh0DMZt1wZgeIrWETeDJenvDAP2BxhnRhER7hcEkbEjO
 dPj1MGZqdoZBCb4pEn/bQ2itm7AAsbKhMPTIT+fMfNoP+awzQn1AvEBL1w6eSPkRJtGe/PzF2vs
 4apTXsrYWgR1Muwe2Aqo6FqdXLCUZVZRLtV3QqIrNVoVqlc1EqFdBZKwysXbk0Krry4Kgs2iFih
 zwZ7tpICsIacOmo1RYoCA1etZDpvw+NSmN3HLmdihBnINnoB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 02 Mar 2026 23:35:55 +0800, Chen-Yu Tsai wrote:
> arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
> 
> Hi,
> 
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

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
      https://git.kernel.org/broonie/misc/c/743956bb9990

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

