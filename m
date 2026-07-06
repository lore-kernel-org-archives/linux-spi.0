Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F09D3815FD;
	Mon,  6 Jul 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783365801; cv=none; b=WMefs+SPYgXHLorS1QX4Bu+yhiGBfDcLTOchcKfkP6Ewq0HO9p2oUsd0xXlt039wDn7fo4zt4kAHH2o4lawWNDFRfoPi4UrPu8N285Zfd7PnCc+a/txxQSKyD+EdBZSAna87b3hwoCJWG83AA9M3/X5njkpsdyKiixC5jJxwG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783365801; c=relaxed/simple;
	bh=smHIDdMBrISIUclq2KU89G9wSYb5L35HuFsy6Hkns0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uHm8h+pnp5hlUU0UcoyvyvxVmUVVzX4UD+AI5XUKuTAx+9S6HOoTDIWgjlmxRd4cyn62HMwbpibUulaB+aAMjb6NuMv1+ZFqFDUa4woo4Ylb4U5qqfZuQjP3gJWBj/9Pw/PWPzmTt/+FBxWOwqqVwCtGta8vTTlUKYqs2wkoQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYpD9AkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYpD9AkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F881F000E9;
	Mon,  6 Jul 2026 19:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783365799;
	bh=p3q2VZdPCtAQ079i9Vkj6H2OcWSmuY5sJZzcZ2aWk90=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MYpD9AkBQYe3CfGLjNEis2Zn8EPxXNurFuQcOx64a5okOyRBGLsZizYV6OrWAKy0p
	 IGthETNmQzRrvfv6aJqtB7AQi/BDSn/sJB/ousTcC67UsZnXB/EKC0txpCKGQL+2q6
	 6uoJrNpxr+YH7j8ebWsyntpRcqRnMdakAeBjO4h2qXxDB+WSuaHSP9/d9S9cI7y/hp
	 Y0hSG4l1iJpuCI/iMUiF7YMqzG8X7pW/vDTR0vmUOM1cYCPj4f2aw0X3F0roIY2vYy
	 N8sh7YNSDO0i++Wz5pROfg4WuOX6ZFJYPx7aHn8CFzWZnD1a0qiZxN4oNss8ndIcji
	 UTolk1ZNHvUvA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org, 
 bjorn.andersson@oss.qualcomm.com, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com, 
 quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com, 
 chandana.chiluveru@oss.qualcomm.com
In-Reply-To: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
References: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
Subject: Re: [PATCH v1 0/4] Enable SPI on SA8255p Qualcomm platforms
Message-Id: <178336579658.307786.15742500040717466027.b4-ty@b4>
Date: Mon, 06 Jul 2026 20:23:16 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Tue, 13 Jan 2026 00:31:30 +0530, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: dt-bindings: describe SA8255p
      https://git.kernel.org/broonie/misc/c/59841dc5f6ae
[2/4] spi: qcom-geni: Use geni_se_resources_init() for resource initialization
      https://git.kernel.org/broonie/misc/c/647277240b36
[3/4] spi: qcom-geni: Use resources helper APIs in runtime PM functions
      https://git.kernel.org/broonie/misc/c/059e41aab4c8
[4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms
      https://git.kernel.org/broonie/misc/c/b3e1d0948ca9

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

