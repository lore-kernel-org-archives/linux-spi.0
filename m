Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12724AB1B6;
	Mon, 21 Sep 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002567; cv=none; b=O/pUIqfR4k5VYf5p2oqgR9Z7mW4BwcYzAdrxFu2V3asbD/0fG0msTkswJWRpuxDBlDrDC7WSmfsYgf7TKW6OpeDn+T7Fc6gAGAtkz3hGNFEQUIPi6pu5Bu8EfWhvDAeOxOiu9X+r4EgIOvjMHeldGqf4oCqUvQZz5KvnX3HewGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002567; c=relaxed/simple;
	bh=pKq1NgtVeldVrlvWVVY7UHgOPOxgx1kIDbjZRKrz/DU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T8UFjZBmYFRpK9yAz2JYnBIQRbrV1NNTnPXio1FJNDFnuCuDQ5NvuV71zxdTU/xuBFXfogms2sdoJPtrz/jGJxoJklhRef3m+iCEsaKohyjmlZ0T2nYECQh84TbKEap0qrhJrO7CrD+i17zcPCcFFmAuJRoOcx9CwaNRawGvEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU3YerWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU3YerWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B81F00899;
	Mon, 21 Sep 2026 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002557;
	bh=2KhcIYvD4WU6B8VL8pQJEB5vtrhrYx58gIS42TGhKjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UU3YerWUSa6hmScKk/28hmb2rL6bdiUV8dr+TUZpRAUN0kKluqK3zDyOeOKP0uw95
	 FyREyKV3Bp+mWGw2/c5tu+oxTCujP/JXpSzmUK3WvdWqhm5NtPE6MEbdgYtgElBUN4
	 KTiamfhM1RSwoD9sBmcTSAEIqlZqNMKdZYCMFxN3VzVpZBE0Xw0m9GFeUlVTtFl37b
	 fB9yKLdYBdgrSd9dxw52MjJ+0BMBXf/88re6WZ6l3eACWJMd1Ppj2B/KPkhjRNkRRL
	 B+AY6WBxqT8vmjOHqg0JbxI1b1ae8AXM+LEl+Vie8Ugvl477NAI21r7aOMk9/LpC+H
	 Ta9aVer+u0b5Q==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Frieder Schrempf <frieder@fris.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
References: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
Subject: Re: [PATCH v2 0/3] spi: Better specification for
 rx-sample-delay-ns and core parsing
Message-Id: <178999301827.228132.5384836256951345086.b4-ty@b4>
Date: Mon, 21 Sep 2026 14:16:58 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pKq1NgtVeldVrlvWVVY7UHgOPOxgx1kIDbjZRKrz/DU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsUV3MiUE11vmndVK7J13KVtlCYMO6NgAfa8yk
 F1ISGGHfSWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarFFdwAKCRAk1otyXVSH
 0PyjB/9O6wWNQDpTjCinYKeGqr3AaavS6lrNfvoE1jf9IvhzytejOAz5D2vohF+GD/sw/93pxpy
 N8FCMQsROVBBJ/g+jY4cxDGWIoGw1XmrmH+eXVa5Puwa8u4fqNh8d8MRYd/sPNZIzdCHVqdx0nj
 0bhXpxNOtSeQ68mB7L367kAy9kib6CLtWwYU09gJaOoUBEZFwSxjrN7qriCGL1a3WF3gj57mdyr
 zhYNeLLy6e9p4K7fxAU7o5tFqc44Kkn/fClLHEvy6JePtYtDzeJBOpE52hj3L3/bSkrLeFfQf+Y
 y8Gku6XXyc1yOnG1BIscBr7d8JG9Drv6iikWxwtpAmvtUiLt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 21 Sep 2026 12:16:43 +0200, Frieder Schrempf wrote:
> spi: Better specification for rx-sample-delay-ns and core parsing
> 
> "rx-sample-delay-ns" has been a generic SPI peripheral property since it
> was moved to spi-peripheral-props.yaml, but the core has never looked at
> it, and what it is meant to describe has become blurred along the way.
> 
> It was introduced in 2015 for Rockchip, to compensate "boards with
> high-capacitance SPI lines". The wording now in the generic schema came
> later, from a description of a DesignWare register, and lost its
> controller-specific qualifier on the way. It says what the value does to
> the controller, but not what a board should measure to arrive at it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/3] spi: dt-bindings: Clarify what rx-sample-delay-ns describes
      https://git.kernel.org/broonie/spi/c/2c68b2403acd
[2/3] spi: Parse the rx-sample-delay-ns peripheral property in the core
      https://git.kernel.org/broonie/spi/c/631a56336381
[3/3] spi: dw: Use the rx-sample-delay-ns value parsed by the core
      https://git.kernel.org/broonie/spi/c/38d4b42e4a2a

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

