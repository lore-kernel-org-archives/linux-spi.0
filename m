Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAB3F7AA8;
	Fri,  4 Sep 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558757; cv=none; b=gh2QTf/25OOIpvnABOcNBoIJ4YSc3oC0Y81+pT3KjbotPmBrI2U0o6ishbbaVqkU3QK2KF3O0++MNb3q+qoVEYhs9e393Q5GsjrA/90QUV0LKZ361q7YJoT1sdvR8a8CFASjdx6lC4/dWInxYZRgPExEDjZ9jrJOvFT6e1o2PHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558757; c=relaxed/simple;
	bh=zjdkNkDUmonpYU0Jbjz+zmmE2qaeROdmXnVtOHiS4H0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S03c1Hv6B/81zBqi+KdrU+5gWQP0qL6ijysay2OaQmhPP0tDDTMgdM66WleMSIHRrW+zZTipMpiQWXWnUq5Pp41aUK0Uy4aiFals7kmCnBzZ8W1JVB8CAL6CNhQb+7j5JoNsu6pzJv9A7v+k7YBxD0JrNH60dH10CMTjK/ZvP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPgS7bnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPgS7bnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FF21F00A3D;
	Fri,  4 Sep 2026 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788558753;
	bh=UVrkCuu11lO2jLxhwTb0RktChudHatDr/XIWbtQPRJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aPgS7bnzvgxMwfa68V5kdEfcEvrZLGd4hvfezzhdeGq8+bOy1jCL4sPYm9J/EbDYF
	 gkPn7q0PoBPXjqJV/OLTJLR4CgXgemuy9IKdOTvyPB63n4XSWlTThwOSE5s7+W+AO4
	 bIv+8zGiCh8U7evnLU/n/w/c65lp2vTXaojCltmSWmb2X9QtXw1fg+VycJm3gKxiUN
	 X1sa+GFQH2bCctfRLIdBVNAN6FIXAJI5hO12qx4FxiHCF0C26hofTDdKTJvgfNz/KQ
	 QCsMajHdfNWeYy/jhZFliinQJ9jYGry2L6MBC5fdTpfgZbaN8HCnib59/nm0FHAIRt
	 Klnr19gs2DHKg==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
References: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
Subject: Re: [PATCH v3 0/4] spi: add support for Amlogic A9
Message-Id: <178854160331.632048.14728363088107524038.b4-ty@b4>
Date: Fri, 04 Sep 2026 18:06:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zjdkNkDUmonpYU0Jbjz+zmmE2qaeROdmXnVtOHiS4H0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqmz2b7imfFO58cCzluHQ/CY6Goj/swmGs9TWX0
 nLpvYPkRyuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaps9mwAKCRAk1otyXVSH
 0NGaB/428q5frnEDu6OiYRheIcp0oUTfMczZRKqjcktVO1KRJV8tnPgfqRdLE+iRgJvus+Kj6KJ
 tBEAjeE0QCuEwIzvETLElAdP1QQx3LAs/bCH6zqbfpccDlzUaX3t0vwFB4qdK6ilZqA/KgSROaV
 toJ2SOywUOdqZ9Cq7yCjbIDK+FMafs7siTt24u0z9PMprkkN0EkOJxx0Eu3eGWHGGP+bxfkuwh0
 DnZ/jE66flHee/aa4OMiG4eA/K4ZkJ/log07zVQ1HHfjXPpfnhOP4F7TjqyXLsGv3XSp/oLkKXe
 zO7eI9WoP0mk/Ltl3lgZUNE0exWMa18B/RTx/9ciEePfMt3Y
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 31 Jul 2026 09:08:24 +0000, Xianwei Zhao wrote:
> spi: add support for Amlogic A9
> 
> Add bindings for A9 with some features, and driver for A9 base on A4.
> 
> Fix the incorrect keep_ss of the last descriptor.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/4] spi: dt-bindings: amlogic: spisg: Document A9-specific properties
      https://git.kernel.org/broonie/spi/c/29359ee126bd
[2/4] spi: amlogic: spisg: Fix transfer size limit and timeout handling
      https://git.kernel.org/broonie/spi/c/754d2bbd92f5
[3/4] spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor
      https://git.kernel.org/broonie/spi/c/253dfb1839c6
[4/4] spi: amlogic: spisg: Add support for A9 controller features
      https://git.kernel.org/broonie/spi/c/b552119acd63

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

