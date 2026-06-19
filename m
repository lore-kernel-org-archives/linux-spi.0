Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80463446A7;
	Mon, 22 Jun 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153764; cv=none; b=cnQ9HhND5KtJW9Czmvrhhu0NgVA7XhrscHBUDZYlCRUttLvqp5XRNi8w3L1lBjy21JOmD+fvhzQEj8h43gWLnEmJkuqhUMCCRlA8pe+gokUjaUBc/gdqfeWvmIWoF/9JIaNf/JE/9R7aFaBGHqIGUWCZPIyGjrGnlfuAmeu65eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153764; c=relaxed/simple;
	bh=FrBpkOQL/dgRLybZov+R31Nro41bEC/qUWRU27+F9Aw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R1H0+44IRiAo+Oer6dYfbfVr8M4Q1R8DfbVigoSrB05SOLr8YeBRm7/XeObDJAgkMYxDh9b6zxL9NrxmmPgMsMpoIrKs5d6DHDIu4gSXhdJT7YglKe2Qz05tzMKzCIW7tmoH8KA3tdYKFfvwIY6Pukh2DWFnvGwDLwa5TBNQ+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb9k+WsE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb9k+WsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAD71F00A3A;
	Mon, 22 Jun 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782153763;
	bh=YOGq7lEHrxGToRoPGSKPTagvDCXwpC5glbVNxk4CpXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Qb9k+WsECnuEVeCQEJ9Iwr0KKNZ6AmZkaNAEiFJHj49gLOKc9el0S3rBh0fWRucuI
	 0G+UypVPsRl4U17TuA/z0hssBarpeazAahdO6wMpNPpoBjKhgKlz42MZn76i28AvTr
	 I82NP/1l70b58TFWFvEQg+EiPxj6tZRokwbB/YXmVx4/w9eRPHHI/qlzQyNq1Qrr3a
	 RfM9YnCvP3B3xWiHj+uQnA/2rktp0rf9VbUXcPPuXyviLcspcE4ST0NDbS5RKWpvJm
	 thxkw5RrF88ha3rb4dyue8msT1em7IEwqYBpeRAugdGaqdI3woRHwJVraBgXZfj2D1
	 fs253rkaP7Wog==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20260619143443.22267-1-changhuang.liang@starfivetech.com>
References: <20260619143443.22267-1-changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v2 0/2] Add support for StarFive JHB100 SPI
Message-Id: <178188866474.108520.10248256723285421476.b4-ty@b4>
Date: Fri, 19 Jun 2026 18:04:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FrBpkOQL/dgRLybZov+R31Nro41bEC/qUWRU27+F9Aw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqOYIhxCgYtd5Wg0CnQZJp9+hvGK4leqReS21Bo
 b4eofrEJMSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCajmCIQAKCRAk1otyXVSH
 0HDOB/0R6YPuKQI7aUkT6JdH6M1GJ+3vkQwg1s5IsZtZwIAH8h0XpVmoNeqwnJ9hkVYSNg2w5Hf
 4AtK0VBzjmXK4U+aYNK7xFwlrZJMFR2+Z3u8VggIIQO0Ba2SUbC9AsNYdTG4zn9CbgIGfzB7E1c
 sfWXA5Zj7ZMCG3xRokvquTjCxQdG2Snd+w4jQplXHblXa61FbS/pMWhk4+OQnxnCPy30tE743NX
 G5XnOtD2mDiVaXbm8q1LYU+NHNEi5t+RmeYzxzPq4uV/DRC3UGyn9MOn0SXNDTFbSB2jat00KNp
 jiZHZZmvsBC7fbewWgsa5P7/SycGe+o7Yqeu3ARq4zj3y6Lq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 19 Jun 2026 07:34:41 -0700, Changhuang Liang wrote:
> Add support for StarFive JHB100 SPI
> 
> The StarFive JHB100 SPI is based on the Synopsys DesignWare SSI version 2.00.
> 
> changes since v1:
> PATCH 1:
> - Add "starfive,jhb100-spi" and support falling back to
>   "snps,dwc-ssi-2.00a" or "snps,dwc-ssi-1.01a".
> - using subject lines reflecting the style for the
>   spi subsystem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-spi
      https://git.kernel.org/broonie/spi/c/07f251e0ed0b
[2/2] spi: dw: Add support for snps,dwc-ssi-2.00a
      https://git.kernel.org/broonie/spi/c/914e708e3049

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

