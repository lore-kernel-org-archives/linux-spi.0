Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE64CC622;
	Mon,  5 Oct 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791216214; cv=none; b=BatDM1B8lrYXvQi57e7mUiCWKLOK5fp6sPOGYgBkcU/lU5gyoLD1c5PLX3z/OUn5Oet0h//qJ8+QwyEUfiFWveyFMdDX1oKTj9vZYCEPiAdh5ZrosQxfIEXmUKk4rci15ypFhkskbcD76XoFDus9fVwHZlkV4pLkaeAO/BoUMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791216214; c=relaxed/simple;
	bh=8L+fNVLW4rDXS6jqguZrtBICvw+Olrye0hpvC31GY/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Su1qBUYRDWld4gp0c5gpE+3j6Gy1ffadn1L4zNxrVklrIp0vZ/8SoqFaPObHIuKMSv/PvE2e/o/6+sbkedTqMqr60kXbk74xkJgJ6/RDx/juz/7mJ7l4RJRXcVfry/pBE/Ja/WoP7ffiMwPoT5V7if8diOHfeaUKgGnG8oisfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhsmB6Le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhsmB6Le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF191F000FF;
	Mon,  5 Oct 2026 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791216212;
	bh=fW7YTsAMJl59v0bNQzFmwCvsNNTWWYWsWINgNF+b1Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hhsmB6LeUneD9PL9B9u7RhwTOJqWJVY1yurZPG0e0K769rJ1mesepYYGFktA3k3Rn
	 iOzPC5hlTgONC13jhTFs8+yDbu8tgP6/9P1UB8bu93bPyWWG4tGv3yMTznXR3Y6P1T
	 OPn707dvgKQX5K7/pwCHkSU6X6lhvB4zOzKRCcQHfEXcSfotG0bpiSMn/iaMw8WIN9
	 onsL6GxsIs/WLmgA+3anGka8TIBmvW+HYNT5KWj6H84aTyMCYa+Rs6ToITPcGZOnMW
	 oNx60EcW/21fbHSQ+Gdv3xPt/Yz0MTFrA2pxi57RrOppbr7yyN5oA27aY/NArmEaQB
	 1XCrh+wQ0RyYw==
From: Mark Brown <broonie@kernel.org>
To: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: chandana.chiluveru@oss.qualcomm.com, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
References: <20260927-use_gpio_to_notify_master_of_spi_target_activity-v5-0-9b973623080f@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] spi: qcom-geni: Use GPIO to notify master of
 SPI target activity
Message-Id: <179114365827.150114.15536189360467733085.b4-ty@b4>
Date: Sun, 04 Oct 2026 21:54:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8L+fNVLW4rDXS6jqguZrtBICvw+Olrye0hpvC31GY/c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqw8pLq8ze7npewKtbVrq6AKmKOVDAlaNtIMcu9
 AHIg0CU3uyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasPKSwAKCRAk1otyXVSH
 0A/nB/9S+W186ZbL3UtC97P7+0+bZGsvBkO1snX+DckCq0vPPukiUepciU8cTmx+rwYTnl1/5Yt
 kGi4m3f1mY3HqL+inslYhaUyqWBgLWHzTBl6lTY1KMBccEtFQ704Z9GwP4DUaq3FJ/NdhE36Q4n
 xrH283vP1LvhHBY32fmt45Ux0HabxCr6gmsaKrB9iC0hFIOXrBdYbxBgY3A1+I9og8LclyTT0nJ
 5ZctQqQJsNii0C9OhY3+TR94tnSDoGTghOH3tmjrmPhi9kwxajguOgAVtUgzOtzSF+tGW8V9HPM
 Z6QC4UNCXWT/ssuFXjedeBXy/PNQH7nvdy2N30c1Hn/e3gqs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 27 Sep 2026 01:26:32 +0530, Praveen Talari wrote:
> spi: qcom-geni: Use GPIO to notify master of SPI target activity
> 
> When operating in SPI target mode, the GENI controller relies on an
> external GPIO to notify the SPI master about the target's active state.
> 
> Add support for an optional device GPIO that is asserted when a target
> transfer begins and deasserted when the transfer completes, is aborted,
> or hits a timeout. This allows the target to explicitly signal its
> availability to the master and ensures the GPIO is released in all error
> and completion paths, preventing the master from observing a stale or
> incorrect target ready indication.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] spi: dt-bindings: Document ready-gpios property
      https://git.kernel.org/broonie/spi/c/ae0f8f861e28
[2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity
      https://git.kernel.org/broonie/spi/c/bb5805a74e75

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

