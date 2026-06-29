Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A140912B;
	Tue, 30 Jun 2026 11:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818238; cv=none; b=aSminP4FF7b8L0jS8/g6JQKd4rFaGbBnJ3HGuJbCb0l/spb6Xin/Ue9hpgl+crS3E6WrbSb4ju2C8oqB4KSTfRht+ojae46D3O6x431G9bFzibwxTKLZOuQYsgfRkHglz2fbOPwAd5lN7ML1qedEHkLlTS54hxXPGInQ4yQiYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818238; c=relaxed/simple;
	bh=q/sQgD+K38nkFWG0ehSN/uuO6WL81rK4d4MwLAYlg4A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PCI+gOBmEX/DOzprdyAc++x9iqg+GcJzMMoNN1+2B3sul2cpUfFDRCfZWQmbAgUXsLlcwhYI9kK+ZHcpuAMnq3uVmimwZPxk9prH6SYf4m3y3kfuUs5KR88nwRsmMyehQ7TB9EkNsUy5CsPH98YorG67pNOWtEoVY5saY6OKesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzCg1kXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzCg1kXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C4E1F00A3A;
	Tue, 30 Jun 2026 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818237;
	bh=RJ13SIhXaZrViW/YUc/yDDBwNLjDBsn7zj6wMkz0aEw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IzCg1kXWQxD/ET+DmxF6mxX1axterFnga1hz8ZO6CkxF6+9lEDnsuxClsmYNhA7gu
	 9p1i1pBvBFBCIqeU85QaD3uuaEpUuzfABhl+VRnogwXNNGW1cEPJsQe11AFz9yo6pA
	 4QsW6kp6bUoyp9KjUT1GgmBjWaZdzQYKZiWG0+ljInvF/+PPotBbPwGiqhDmcwnhug
	 DxwIZeuCIC5mVwrAdyY3KknewR7LBJsnOssBJyeAG3orIY+6WNDYq1KYaMkJINZYKp
	 fTWOPHqcKwZkT7AVNNW0MZd6eLB35Si5vL/DDEO7vf2ZjeHhVpLnyHrYo0C9NkUTxs
	 KgSThy6EpSYHw==
From: Mark Brown <broonie@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260616151129.76060-1-pengpeng@iscas.ac.cn>
References: <20260616151129.76060-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] spi: qpic-snand: free OOB buffer with ECC context
Message-Id: <178275448092.47562.499800053415897751.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:34:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q/sQgD+K38nkFWG0ehSN/uuO6WL81rK4d4MwLAYlg4A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6W8Xtd0XyAmmte5V1fNLQxYdpX0KwBI0xtLB
 jDZs7Ld1k+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOlvAAKCRAk1otyXVSH
 0A3QB/9vXmk95NTEYPl9SxPHlJaDyzjH1GTzh7Qen4H/4Mx9Ujq/8moxEhe+8nAXZRh2Sen9r5c
 DOhQCuNWpUugMTlgFppdagcRG/GJoiKFSaqZlgNIGXs4SR/9cnLKe/Bcu41PkYQ/qahQg7kvqGq
 YwnnYbgiguxMb9BVZ3+0rKZi/ZL/DMVTyTTJmZV8+qpIq5VT+G+kE4j7YVyWiifyX3k9J0A67DB
 f+AYECGA+UaMjOwH+7yADgJ/s2VdTvZHx/xmGHgaXzMpRPb4WVNFwXCGcD19vNfhtSpEc6QTHVa
 yzSz421VjvhHZdvzcdPkxbXEWQjCCbEnNvlsPRd+8oUUYrxC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 16 Jun 2026 23:11:29 +0800, Pengpeng Hou wrote:
> spi: qpic-snand: free OOB buffer with ECC context

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: qpic-snand: free OOB buffer with ECC context
      https://git.kernel.org/broonie/spi/c/5504e50ffbcf

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

