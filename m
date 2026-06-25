Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D03BB4A;
	Mon, 29 Jun 2026 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735251; cv=none; b=EtjGtfiOc/It3ImY94HgYXo1S0Z3bM7TMB5EKNeGBjZ7oJL1ByMK/g1Stdikkt/o7REBObqiRkJMwy73ScIWX1UGakqynvHOSmNE//Gg4ACzNK2nWpUWG3ny9IIHBFbFl6gJ+gc80cR/YEfpSR1xoeOfeyu+4zqyD7IZPBpRHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735251; c=relaxed/simple;
	bh=w/lWvb9mhEOZn3WzSs0+K04PnPM8KNg/bfSSpXb3Zeg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BcxAZNTy9yBeEwXIA524R3SyoTa8h/uhMIAN9ztO43AKZlKcS764RjyuzNkCeSSnqQpADK/KrPzf+a3a8lmJDTxmcBVeUK/ejAubTzjmfj/Esge8+nEug32Q18dVdO+4gwzoRJu6EzPsrT2+rOds8gwvz1vvUpOLcTcENYaNMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORHULmDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORHULmDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485B1F00A3D;
	Mon, 29 Jun 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735250;
	bh=fPTlUp1UuV29NUWQkNieDfML4ilGzEpvPEj27rPLmlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ORHULmDZXECzwl9DfJ4wOn8vHy72EX7q1WqEAawBkVrCDbDP5by7CkqyQivv8f/ND
	 V2/UgG8R94fB/6I6wZpApPeUYohDwMp3QdHNdvRoSzpECSBN6gqhC8+Own2eQKD1xB
	 452bioSM7ZVzlBTVdUnkq+1PLCyhs7FwVCvD3gaur3p9RLg9CgD6gHGZ1g6qWgP9al
	 gCTeesEW/GYpjFdgU5MpePOJL+hE2pwRqu6WiUiLnORPoUdLgFOpJSgov0u4PFY11Y
	 8fQ8gJDqC+nMcO2kIqilOu7x1jQTGwsr8MAw8aBDSRqkOGPGL/0gsNGdZiKjnFLInS
	 htxMdMmGwjMLQ==
From: Mark Brown <broonie@kernel.org>
To: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260623135834.55442-1-pengpeng@iscas.ac.cn>
References: <20260623135834.55442-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] spi: sh-msiof: abort transfers when reset times out
Message-Id: <178239243329.51343.11037370908516947952.b4-ty@b4>
Date: Thu, 25 Jun 2026 14:00:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w/lWvb9mhEOZn3WzSs0+K04PnPM8KNg/bfSSpXb3Zeg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQmGPG8vOEWqmtApnzwG+rbBomxmYUOTRa/wX0
 Vv3DAymhJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakJhjwAKCRAk1otyXVSH
 0AD5B/9KR2HZrmN9c0C7hEl7X0bsU9ZYc+GoYTE1tlJx9kc4xAnkcWZRXKnBzOLVuIetDUP2RtR
 3ZeNy00EvfsKUi29ePf2BlbleH8GXtEa0f++gTYMDnOou/PL+i3xxm663AH4PgslxXfrYG9wQJ7
 neKURiEHxHJjgeE9/tdhwLNcJbZxUQAjurKzUYHwq4/FuCe9EchJplN2nSXilwvdmXrsRvBdhZH
 QMLRbUEFBg29sWj3cMqtxBjiJWx2/oknd5dpczNfIHoZfWxUBmSb5R4c22R/OizM1RRW5Oli19s
 Q5JC2RbH9H8lgw9uDeckLrgxao6QhKOf8j0oYgV+m+N/ODxd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 23 Jun 2026 21:58:34 +0800, Pengpeng Hou wrote:
> spi: sh-msiof: abort transfers when reset times out

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/1] spi: sh-msiof: abort transfers when reset times out
      https://git.kernel.org/broonie/spi/c/6dbaa4d28843

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

