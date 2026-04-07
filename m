Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7353D090C;
	Tue,  7 Apr 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580276; cv=none; b=b3RLhiv7rGFO8zjKOt3eDGMy4Fla59egDR1zFNRugPPSijPUh8zh5jTHfhDHeEgTj4QjjYQ8AuUCFRMskbsiHaT0YVrghAzJGudiws1rahYPx1D1adv0UpqcZZEKdkD2/g1msY6WXY3Cto/3tuN4OVpvXmaNLwbwaww5kTSmtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580276; c=relaxed/simple;
	bh=rvbmC5Dq0KsEWmx370qkfW8e7Z3N1wyWFn+3g7ufGZk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fXYgtbZrOHrYsxVmJnhN2nVVWB4GI3sujCbSZ83DgeSeOR73LQ0nvazZVC91lOvvgfJSVLhoqBByMZP6VzgV71JjPNGEmH9yujKTi5tezz616HCioETqQiNazlmVOCVzgIUqdXjcRryMDHvLAZPpxhjXfT499YOl3sq6gVnsgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzS8BC8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzS8BC8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFAC2BCB0;
	Tue,  7 Apr 2026 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580275;
	bh=rvbmC5Dq0KsEWmx370qkfW8e7Z3N1wyWFn+3g7ufGZk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=dzS8BC8/CdESd3Vtch5bsGUBJNVW1IX8BrmHk2YfrlrF7AdQDJlmKDi05hj8F5/CD
	 ivopLuURB7ojhUuPQ5aUS6Ym1t5q2aA9uHigHgUwLRcqbwC74gZpmYuv+RfuunsYOv
	 Z6B9PBLX9Jt8ykQUS2R8OgHXWsmjWPYYKOKlHAQn77NkdHOM2uVe6PyvhD0USi2j4v
	 /SBBjQ9oL+n1Bzr4wQ8FzGN8u+kaBXE44EmZsCNsS2JDhZDz+Gom9LjGJIoCfj6j9b
	 K/4COi82rL+WI548MqipnzAzUOnXG0arHESyDO2rHW7o0rSBXJ1n7xb75ivkodqPNg
	 JKXSo/7LCB3/A==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
References: <24043625f89376da36feca2408f990a85be7ab36.1775555500.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH V2] spi: zynq-qspi: Simplify clock handling with
 devm_clk_get_enabled()
Message-Id: <177556281347.37897.18439480858338017890.b4-ty@b4>
Date: Tue, 07 Apr 2026 12:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7a3e7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rvbmC5Dq0KsEWmx370qkfW8e7Z3N1wyWFn+3g7ufGZk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1TRxgPqarP6cSnt75tqI3UUZpaqEHJWqvD7LE
 bLc6LWvtPKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadU0cQAKCRAk1otyXVSH
 0Fu0B/4uuq/VG6k7xLQE6dCJ4Vsxa2ziOs7jm4QgiKN6qgBPGEtUVmOwvCeKuj4Jh5jdrbgNvvQ
 7ryVjY3swUL5lHH5gQH5dxRMbjXkKHupHN/uYfDO4bCTmEbYiI2gM3DhNiV8uRKmarvijGAnjTp
 uRYlLCwQXf2onEpMjHSDPkWFLEfrf37PvkV+T/dPstX4Misde30Lri67Kpug5QoSFpOQDgkINSw
 pHXQfEOrFD5+IMc/0pPJKSeRSklrrVd4NN0UhQSzhyXsRD4bVej157xiH9PCg5W7oaGma3z1o5+
 1v46Ya4JJ4Y+y55JBjDMSdXTTTg+oR5x6dCPUT8jUkED0+QQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 07 Apr 2026 17:55:08 +0800, Pei Xiao wrote:
> spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()
      https://git.kernel.org/broonie/spi/c/1f8fd9490e31

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

