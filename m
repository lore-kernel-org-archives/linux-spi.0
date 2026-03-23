Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5111A6813;
	Tue, 24 Mar 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311136; cv=none; b=oPQN6tchUc7Y0/KJ5G52JxTtFexnB7cblvRj39+5ygHxxgtDP/ogoiBfpnUq4NFZgk6yqlLAG3owNabxczbbzBknwQS/vqKmKmaeECHRjC6csb+7y5mxFZFo7y3nXTarTselnCAyxZ94wpkPpV8R2xDv/B6TN2yE6OGHIOzAEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311136; c=relaxed/simple;
	bh=ll7WR/DKdUOJ2QVL8D4sjvjEk80f6/hJ+WprFwRSzjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JzIbG6DhWzO5zusHaMEvkPODxdWD280S6XV4wLhklo5nr2KTBOy3gJOL8z9uAD0VxMvrfLKasygrAQfPMqQNi1Ut+PjragnOl4dAGGeszyPS+d87bWgkTWJVV9RwZC4HAequhpXLCU5pQxP56f/dp4BNg3Hh91kngajM6jklpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ54V7zh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ54V7zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F106C2BCB0;
	Tue, 24 Mar 2026 00:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311136;
	bh=ll7WR/DKdUOJ2QVL8D4sjvjEk80f6/hJ+WprFwRSzjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OQ54V7zhU5FhwgkZcm1E/qa6zovCBprdKLppVbHoEnyswe4s6IeVK52k1wISMZKVm
	 xA8V/zs7e6ELV9fv6/LrbFO4so2AkWP/bTmeKk62UiSXOAVgLAk2BpbVUqRCrt8AGA
	 Bl5CgctdbHJtDyYxFIrk6s5wlRPKZy3VX9irmzBmJLpJTaquu3mbmdMMCNqPHY8Ksx
	 VZta93Zb67xn/JFHqQeMzNWwU5n0pNwg7rRal8YSicJrFnHsTirbACLys/dOIIVmLS
	 rii4hmkhcC4Si9L4w3V0gPiui1DZpNn4+fJ23xgc1VFI+T/lqegimOmG/dM1sO6OPK
	 nnkeM3mCTNEhg==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Dongliang Mu <mudongliangabcd@gmail.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com>
References: <20260322-rockchip-v1-1-fac3f0c6dad8@gmail.com>
Subject: Re: [PATCH] spi: meson-spicc: Fix double-put in remove path
Message-Id: <177429077139.537498.16954848852263952907.b4-ty@b4>
Date: Mon, 23 Mar 2026 18:32:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ll7WR/DKdUOJ2QVL8D4sjvjEk80f6/hJ+WprFwRSzjQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwdbdXEUPKj8ItOqc7xBw6cvRRsFZKImArKwXy
 YCArGlh0Z6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHW3QAKCRAk1otyXVSH
 0H74B/9BC2L2wSmOiH0fUFtlo3LVk2qUS01ix3VKKDqDDCr5x/lnEyVAx1OTErUCLrUdiBzQ3an
 RKelvFWc3HGvQBk/AZDjDfdXdNtKBUx0WzuxP2nsfgZyv/e1h6s/pBVyxogIJTsvt8Ve/xxlxe8
 aiHHM/SnkblFl6tgPtDBX+uFZEk5As094CJpfwxv4MQ3alsd997cmxAPuUPINLqnY/n8dajioV8
 bonk/igKebXqsNXLnXI9pGc2Bo/8scXoHr/urS4J0n9QvEQrb+hJ1IFcmBnqhbZqE/6WH9ItDQu
 Q6m4vDgU+RoVauRthdiKab9R0U4IrPAe2E54Xwd2YDrMVyNb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 22 Mar 2026 21:29:56 +0800, Felix Gu wrote:
> spi: meson-spicc: Fix double-put in remove path

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: meson-spicc: Fix double-put in remove path
      https://git.kernel.org/broonie/spi/c/63542bb402b7

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

