Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87A31E823;
	Tue,  6 Oct 2026 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284618; cv=none; b=mSt2mwnvCCZfQq7V+4xOPTHyRPaMORdpQHQwlWr289+Q31sGGwyDcpVEb/hYchMp4DXnt1PcUL/KR44d/2xNMwaV2cYX34gQKMDiez+4XMSDwmhXFKGBv9EjzqBU6mNvOZyWt5LQnLnCQCmSD511ra6DfFvnGrZj7gjiDIQdf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284618; c=relaxed/simple;
	bh=/sEnKQOAYcBs3IqWcb6o7y7e2Yf6I8mqtpdFlQ7cHC4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjqc4xqGtywdNQ9hTOySiopNEuJWHzcmRHlMhBteY1tD+a1O8LIKAfTQ9cFoMRmVgO9rh16hoV8LAVWWwpX1hNCKXqH/8oEZybKHhxeyll12C22jphtZKQBap9yxZyN6BS4I2YgG5KrqTOSKHxDmE6LMEAXU5u1+WAp6BBfAPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTfmITTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTfmITTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AB61F000FF;
	Tue,  6 Oct 2026 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791284616;
	bh=TbB6ZQ+tdxcSXxxRThMSmIWWLCbmdMCvplWisVYn9do=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QTfmITTT17z9DsuPf0OA9+kMsoGx0VrBkk0TUksIV20UHr1MFvoMIggZNC6l2aXoF
	 WQecva2zzjcwphno+ICtHQQRYR0cf7yZMZI/nocc8jxhXmllmj7iAvq/YDplGbj9Mn
	 BnMSPMKMrPXdNyb89t9VnVz69TaZGJWI9X/z3/FG4FC0dLz4C9xMAZCtqlJdJIOd5q
	 UV/ChIpRYkqLCANPuz55vb7w89iH+sH9DVcHwjasxHutBiv5EjbOk0JUNotsu6OZ82
	 WcbqMAoFZfaKmGDJsFQIjxDnFi4nZZGP6fZhjA9I79oQLp0EbFFjiWQ2qlxdSq4hAR
	 kaqV4XiPyuu8Q==
From: Mark Brown <broonie@kernel.org>
To: error27@gmail.com, robh@kernel.org, 
 Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jyanchou@realtek.com, cy.huang@realtek.com, stanley_chang@realtek.com, 
 james.tai@realtek.com
In-Reply-To: <20261005030504.2651773-1-eleanor.lin@realtek.com>
References: <20261005030504.2651773-1-eleanor.lin@realtek.com>
Subject: Re: [PATCH] spi: rtk-nor: Fix incorrect boolean return value
Message-Id: <179120987392.150114.1333903605231981395.b4-ty@b4>
Date: Mon, 05 Oct 2026 16:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/sEnKQOAYcBs3IqWcb6o7y7e2Yf6I8mqtpdFlQ7cHC4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxNWDIjhn4ItjglGDG3viZfwv1eUEYVlSCFLlL
 EL/oXuHX9uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasTVgwAKCRAk1otyXVSH
 0D9vB/4lNQdfGtXzXrUxz+lzU6E4d8YJObInXroWe7K29TjO7e66bZ9GrAzQ3/AbjaHe3KkMZwS
 SB5tnqUiRXuK0OzCfqZAsvKYZMdxxhUIiafRDEygvgS9PBol0Ha7BauO61ZLQ9RBXZ+EupKOzjB
 BkhFlNIxeyAhgqsznq87FaT8BwA2LvdIWzOwxb+n5znm4uPgs83WjdCUxLdRAL7w0035liEJ1/R
 GIL+59VuOPf0s31MzHJle/fs4o3zaXa3xqlbTJiLKEwhPlLE3sej+m1To5qyw0sqPww5PPlOcs8
 R8zj3jfcGFO5Ioqgom6uTuWxFTeItgHnsW0Fs+wX/iSrZmiw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 05 Oct 2026 11:05:04 +0800, Yu-Chun Lin wrote:
> spi: rtk-nor: Fix incorrect boolean return value

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: rtk-nor: Fix incorrect boolean return value
      https://git.kernel.org/broonie/spi/c/a143fa85c78d

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

