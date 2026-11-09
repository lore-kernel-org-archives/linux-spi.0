Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253500;
	b=RDlgWZuLam0AAVm5TP5TuKpGJdfLE9RRdWKB55UeEH6+ljhKvMXEPbt0Fa6xdwi0WepI
	 Lhfg1D9u0UUkxUg26SdruTDM+GcwlzPusFmunrA4kaoMQV//YYo0QiocZumrxf1umEEox
	 0YcAxv6v9gBP3KNUHsc8rvIoY8xP4NSzR6HjOzldAl/ShWHOtfeiNFTPRAW+HRlY298YQ
	 pLW8zOVIbS/5z0X1JfrVt9zTrM9S1ELVILv5T08x2jEFCyK2iguG8e+wjy/wzss8CR7Fo
	 wYZk7HR/QqmYk20RsCnz7XibHYKIFGACLVgshJAVUaHiVvs9ILMWYBB/zWhs3Dl2C1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253500;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kgAb/MNcPZqf2lj1SakxlPQAy6OL7xxuzBejbd0jhkg=;
	b=rCZ4lIMwZXBkE9F4yfuf8Spvw3s3cnLSUzSUK/PJNy04Vngs1ACVaoO8c0I2eXTZ6Lv8
	 Yn/Fooxh9VqEICHUK9fn+WEbtB/nnoeuAvRroK35a7gQX6G8j65MXM/iDzypmr4qwfOiz
	 EeoU5mxaCUQpnw2qA37NeVkuwFKEweFcavGxXkKm6LmJfRzDDl2KLNahyH7EKjRXdabWU
	 c1AY7+a81IAoupPKvWJh5VUFrAYoJgQRRy1sObbx+rgHmEo0e1xzjQQ5AMtEa+ObyzR/F
	 csMxzs4GK6UE4BODLWemyeDJvQ9AfnIqSYfKP79vupGntiKFPhwbB2lAlJWdkFL+c5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaK4YXuS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7581606A31C;
	Mon,  9 Nov 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaK4YXuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9C51F0089F;
	Mon,  9 Nov 2026 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253499;
	bh=kgAb/MNcPZqf2lj1SakxlPQAy6OL7xxuzBejbd0jhkg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iaK4YXuS0PA2gcyJg5eFZZDYdKfVrqf2/p+q7pQC/0c8y9PEZN2amzvB5oA2175qw
	 BUOJDl/6P89wiSWmSnRMxQilXg7X90t6+tc3p5jpEqagG7AAEYRRwoaSAq7LtLAVmJ
	 Gcy4/twP+aaz9gUhIJg3aSmkSKJ+SK8+8srIfM7japIETKGSathZ5pT3F5kYFKIets
	 Y2RUuwkVkdrKOHv7m3vMYfrRuBOPXJOwv2A/xKm61MPH5FTct6elR8nTQ5qrWd2GMZ
	 8WBbrfcJCjjAq63fSA8N540rlCkdM6n/vHlk0RoKnNm5ciDs+6g/Z2peLiSbcJGvXR
	 xt8P7ulfrd0Dg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 81F762FC6BFC;
	Mon, 09 Nov 2026 19:44:08 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org>
References: <20261107-ux500-pl022-power-domain-v1-1-d51913109afa@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: pl022: Allow a power domain
Message-Id: <179424278627.3711751.15633504831825974772.b4-ty@b4>
Date: Mon, 09 Nov 2026 16:46:26 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1bZwAjmm8CNqGWsa18GQ35iJ87/hXThXLE9lj76dRK4=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+KXX81X+pM710eWj1CcVL708frnpk9/Z+GtPMdFdWP
 edXAaxWHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZjIyQpGhoXxzAdLrZkyt5o6
 WDMunnTuZcf2Dx3L1/2Vr/fave6QrCMjw+2AyOyJL3aW6m6UWfRyaRzbJvFvfKVz/69pWP24eK1
 wAyMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Nov 2026 19:14:22 +0100, Linus Walleij wrote:
> dt-bindings: spi: pl022: Allow a power domain

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] dt-bindings: spi: pl022: Allow a power domain
      https://git.kernel.org/broonie/spi/c/6c4c687d765d

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

