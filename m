Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF910302163;
	Wed, 22 Jul 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727246; cv=none; b=FhDiLCEfOjS0l156yQ44XJ4lit0fqL78wGt8kZp8VXe81kQQownWFT3rj1aX8BT5Kt5PzGUaJPzdy/exBjWYiofaX0ARlAiH/wn/6LbTI84XDt7OPtFjpml64OGKmcKbDnS0GlV9ypoBWiMQv/P9kN/nZ/0mk3peOkSxrwu4rSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727246; c=relaxed/simple;
	bh=3XhPVfYAn5ogg+I8EwpEx5n1phNWzzGfCew+/3A7vfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fQNBg4eXvdsKboqy/wqmayNCggqRr2/a/fUvEWBHEbShR1Y19hK1mP8vLx/YbmyLgL6nydeSGwFNZEeX4ZTCc4+NRbSoebWcBBvkPfkMcy/6BZ6Gv8qVMYM5HXkwobNUFNYj7D9cRX44J8+/Ynjn1eJ3vGmtaEHddMux/XghNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+xE/OUx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+xE/OUx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0F31F00A3A;
	Wed, 22 Jul 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727244;
	bh=Nlz16QiOQhVVn8iXqqYb5Q5dqwZF2ocDB1E2YIBPKJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=H+xE/OUxoazgHV3/EbDlhN+tSyNFM5sM0csw7NkmHKLCFDb3Nd+TYeuxWBOCvxmsl
	 CpWohe/e56Zx+lPC2jvi8n+O735kadt/Ki/D/0dP4GvYkA0l37tl44FdzCtIQzLSQn
	 mokLge1Yw6G5XFy2b/INo63kr2cGCrqBNELbpdXJEoukN0uULKWIDMMCmciZyHtO8U
	 nyRx9ysPQOkxqavP5+/SEj2+qeSfjaJ/cwblPbAmWBbVgTtYPK898up6q65FobHpBO
	 AxkdAhLe8N7RWShdo+eofHR2Q6cpaCeHcTqKoL82xPcIVYpLjJahfk3tV3fn5kc3LD
	 HDLhLAsUHXraQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@kernel.org>, Zhengyu He <hezhy472013@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, wefu@redhat.com, 
 liyeshan <yeshan.li@spacemit.com>, Guodong Xu <docular.xu@gmail.com>, 
 Cody Kang <cody.kang.hk@outlook.com>
In-Reply-To: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
References: <20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com>
Subject: Re: (subset) [PATCH 0/4] spi: spacemit: support K3 SPI controllers
Message-Id: <178467008173.260430.15881924669346340499.b4-ty@b4>
Date: Tue, 21 Jul 2026 22:41:21 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3XhPVfYAn5ogg+I8EwpEx5n1phNWzzGfCew+/3A7vfY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqYMbHcpeaZIkEhoZSEkLpuqvZJ8xpWXXkReHdy
 gRpwegzGEOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamDGxwAKCRAk1otyXVSH
 0PMtB/9FGlzd12BgBvdcW30NNMQqd8KjXqB+KkLAmtx4cNoA1IzxpACg62sIUpQAcGGBV7wIp8r
 2GFCXThClJZHaGn+35Uom0jKZToHaaS4aABEdWdQfC73b4gxoh2KbRmRA4UfoN9X+Rr/d7LVIoR
 APYRfwIrqemHA++MbBhjHVoQIEr+qkL7YJf71/6MsURlSL79E8EeMZxsfN+rMsUu4pJ+nugAoMz
 6MYS/xSGb6fXxPjVCV7j4i3c+9G9vRydRicMMd/BzydCpR+LrHBnnHSoEc9MC+Hd4/ckFexIBgi
 arjULGqLLZgWGpEKeqKEORE/SIou9COaGv0mhv8rskpjxhA+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 17 Jul 2026 07:45:24 -0700, Zhengyu He wrote:
> spi: spacemit: support K3 SPI controllers
> 
> This series adds K3 PDMA request numbers, documents the K3 SPI
> compatible, and enables SPI0 on the K3 CoM260-IFX.
> 
> This series is available here:
>   https://github.com/imguoguo/linux/tree/k3-com260-spi-v1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[2/4] spi: dt-bindings: spacemit: add K3 SPI compatible
      https://git.kernel.org/broonie/spi/c/6389eaf11d6c

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

