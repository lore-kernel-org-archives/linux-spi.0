Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FDF3EBF1C;
	Wed, 11 Mar 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255447; cv=none; b=LD6sCjzXvqh3IFbKB5Le8fLb7+lMkolfk682VBWbBHLTrCht6U/AuS+9YPNrsO4hrAcj7hxWPdibOIvyzjUhnpTM34oPmO+x6BVasmE1EqW3T3hlMs3HELDyOf0IMoMYpDlbz0H6hNkXSUT/WBQn6wvlt5n1bxA4rpX91JA9YEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255447; c=relaxed/simple;
	bh=RidVbGC9mU2xxmkvIRvsi2MJXiN1kV5l6UrdEnON/PA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WjdpqIccUKcI+gc5BUaOQ1obRNtaASOc6fJL/rHCMfR8qPxxbHwaBlHqh07hvGx2nKE0cRaPzHOWmlfWoWoPL2Vtm5cBvPLVcobPzljYQUbdid1EMvjzq3F95iqoXtVGv2kjFsGFLob33jpiOwqxlPnL6bcckFWt40gznF3HzB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaYsJG+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaYsJG+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F2C116C6;
	Wed, 11 Mar 2026 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773255446;
	bh=RidVbGC9mU2xxmkvIRvsi2MJXiN1kV5l6UrdEnON/PA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CaYsJG+y2ay//ZEN4F7URc7/XMDRJ2oI2klieogZ0PcbnU7Jer/702guv78IEvKEi
	 SfszeO3MqALtiw8HZU7j7SiUpw1bKHZCPbzIf2wuBY6+mrxRfirl8mgHdnckyDKoaX
	 Rukm+bN3GQPn3QY0uYu/Z2zFxgy+MRBp0n5lwsDFjMlOqMUMCyg2phJsXFO/Wf8O/T
	 4/gHXmwD437KoOh/6panPhVlkxp7DK7TtvE0sZo1hTpdgm1JLkD+n13zzFMS7r10wU
	 /NEOtA7AaMia6eWuTfPhBKFRu0b24BgmAaH8+mCPwvegYpk+DOx4wBtXDWSjnaldOA
	 3BgEY52dnQycA==
From: Mark Brown <broonie@kernel.org>
To: cl634@andestech.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1773193726.git.xiaopei01@kylinos.cn>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
Subject: Re: (subset) [PATCH v2 0/2] two cleanups in atcspi200
Message-Id: <177325544556.227890.3315912927938517762.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 18:57:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-68380

On Wed, 11 Mar 2026 09:55:12 +0800, Pei Xiao wrote:
> 1.Use helper function devm_clk_get_enabled() to simple code.
> 2.fix mutex initialization order

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atcspi200: Use helper function devm_clk_get_enabled()
      commit: 97545e37234fdbe457f5104a09f55033550b3d84

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

