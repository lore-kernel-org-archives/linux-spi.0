Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEB3594A;
	Tue, 24 Mar 2026 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311108; cv=none; b=OJ3SpezFvnaXpcPifr25MFHFyngBWLg7tKtIB/OED82o3KpNLBBj6xJtLMxE03dlzaAztx641ZtPO10uhkqEDtDInFuby/ulXyK3AulXsN8ZfaX5t9gsI7HKpV6ijrvBHhhn3yot6ccKLnVJY4h2jgnS1azXHWkpJzf908GH5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311108; c=relaxed/simple;
	bh=9XrwS0iAt3o2Po7HxX8rxVBIYzpYzB6prB30wTql4Kw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HFp9YMF4Ac3xdKiVB7Vt7I1a/ajwnGSRxNIGX6n+9BhX1nsWkqF3p9rg175Lv1PB5naArlgjLWucolM9eSTMWDBlRsEGbuITcQZdGm65ZoRTGnfKqsZ2HPmMN23FGXjaUD9oND2GCnG68sBBEtw8cB9ccFJS8rD7vzsOQfta1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/N9AGuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/N9AGuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7885FC4CEF7;
	Tue, 24 Mar 2026 00:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311107;
	bh=9XrwS0iAt3o2Po7HxX8rxVBIYzpYzB6prB30wTql4Kw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=b/N9AGuXsMEK9DCC5SldRFurxb6pulKlQJkxJN1qaW2BReeSPkWBzw/xv3+Ht1bgk
	 1GyZAKTv/2ZjphHfOjMt0RIp+KIeBOMKTy0buDYIn/ZuxvbH6lOChVtEhmQITLBt/Y
	 U5s0KXNYanJqcn6h37ZAK5909Qz9w79o41Pf07Gk0ROEeBQ8PgVZN8CJdha93yb5sS
	 v8ESWFAz0HVbjfDWc5HFyZU2bCyaKp6JGiD1NX8R2v/ggAcC9zGxAuWmOKK7gqtwmf
	 EE67dU45Ohf5lWpe6Yt5Z7Ch6DcwlUdMnpbHpU4RcrghombtBgRn9ikHz0AcqXAm59
	 quzoEgxss/aLQ==
From: Mark Brown <broonie@kernel.org>
To: shenyang39@huawei.com, f.fangjian@huawei.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <cover.1773889292.git.xiaopei01@kylinos.cn>
References: <cover.1773889292.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH 0/2] spi hisi-kunpeng cleanup and fix
Message-Id: <177430338723.811880.17223052527638590587.b4-ty@b4>
Date: Mon, 23 Mar 2026 22:03:07 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9XrwS0iAt3o2Po7HxX8rxVBIYzpYzB6prB30wTql4Kw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpwdbBpU205feqzrvOQS3aEbPlmDCWFKuZO44A6
 53/JIdV1MGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacHWwQAKCRAk1otyXVSH
 0DpNB/4kLHQdx/FnUR5w6bfUZ3GK0XPjxdH+r8svqo+7HSFHbsNCchny09g4f0xBdhe2DSQ8Zci
 Tk+quJS+15JWWJaUnhxn95ZaE4fBwHzPqw67A5HMnq3kgbUHYslOORGRmpaC3p1UCt+wRCMvAaq
 iKknEeFeUo9OaWa68TphBzPm+3izPZbpKpfCuPG9Mi/8M0JmmA9lwmmZ20TDu7v+mvXrd2ExYgo
 UdqlkmJob2qymz/kVhyhurpu0xlpxVce0rP/XuB59qqiM5R/s4NcouWWM7SSUEKMtFLdO5W5IhU
 ZXMgmF+vrD/H1rP36xXURll2vrEqMQvl2tGhQewqOHB1DOt8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Mar 2026 11:06:40 +0800, Pei Xiao wrote:
> spi hisi-kunpeng cleanup and fix
> 
> Hi Maintainer,
>   I might have wasted your valuable time again. Please help check the two
> modifications. Thank you!
> 
> Pei Xiao (2):
>   spi: hisi-kunpeng: prevent infinite while() loop in
>     hisi_spi_flush_fifo
>   spi: hisi-kunpeng: Add timeout warning in FIFO flush function
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/2] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
      https://git.kernel.org/broonie/spi/c/9f61daf2c2de
[2/2] spi: hisi-kunpeng: Add timeout warning in FIFO flush function
      https://git.kernel.org/broonie/spi/c/579a49aaab08

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

