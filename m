Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2EC37C911;
	Tue,  1 Sep 2026 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296938; cv=none; b=itJFih+Enz42FBLNrSkoY2y4q8Wvo3vT1cUsZkja6/l+WrstDhXOehncpi1EUY5wLAvh9rc4Y9xN9j/TIgQ3SrCtianMxmgZ9yGXlzgBKVd1/buRUT8IqAYPWq+iKHajha9M5mVAtybd0vFNAchi67pnKuzG6T2zgxT5SXVWZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296938; c=relaxed/simple;
	bh=RTLE6gZgRbyuxtnnzOrorUSP+uMBRfUHS7j4OjUredA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q2T3XKBS7bOCuZtjyC926z4YqrTnEq9uMw1tP7O5TwSgEULfwg06aVreiMh0hNTw9nDH7UQfSDm/7cHuWEuqaIzA505108u+nRGQJDa9X2qHdun981yyRCHEjwXWXrQGx7Hpe5uBN1gMs9qnS3uspglWb0TG6aE+o6rRRjYnXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJhRkwbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJhRkwbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F366D1F000E9;
	Tue,  1 Sep 2026 21:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296936;
	bh=VybXJ8SD60aPKpFwFoaNuzXTDLb2GQY0/FeQGMpfffk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=GJhRkwbzOSwWkHo9JAQKkSG1VdCTDfUm/VWTdD7l6zQlvcclH0xyF0a21NLorCf/o
	 +957uld5KCt8JfvPKqJXcnvx8ne2prUXwQ48MxhA4r0UhWWRkZaYhKrtetxYzjdQ0+
	 F5TBZKAkkXslC/9BsnlXM+0IloJ94hb72vVOeP7UmTv50c87RnaScKUXbmSMVnJZuG
	 El75zUocKGZJHikOX6w/JPqUMkSjhUiZ4iHjaWyo+jBE7tTQ8qU9vZmqXtHSDorATy
	 nIYXG+WhkkZDanFAnXZtFZc2Kk2EM5LVhO6hci2ZsTRjCl570nk3oS3APkcIrhTTbF
	 qtYOkQ75glT1Q==
From: Mark Brown <broonie@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
Message-Id: <178819868940.141190.6264743722267135456.b4-ty@b4>
Date: Mon, 31 Aug 2026 18:51:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RTLE6gZgRbyuxtnnzOrorUSP+uMBRfUHS7j4OjUredA=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqzpdk8LI9iTpdnf/xHO7b3LfvPn0/+qrnXpPLoTtOJs3
 7UYNUzvZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMk2Mg6G5enI0H/dMnreb
 fO4HsbL3JV+zynRM9GN3Y5/ikMIxk7XT86khc3OPoNeOuw0K5uJ7DlwJD2bKE30979DTRYcNdxp
 zCyb/mB591kSD9QnLjvM/8tlPnYqNq4i+sHRjQt2MZtbNjo1Fn/K2+SRVbLYIU/06UWiFEXt1VI
 3wd7XPOteufVm7aco95wubPb5zO7Wf1r38c4O0gc0U24nzr6pdWGevX6jcf5hpBrMavyr7HkHOD
 XryB5xthV2jBI4ml5h9M9S3c964PTDs0uEnzf+XMT++XjmlpIPNf6PHFCNVs3jd61xe10wCFK8J
 6qcGvwryj9Hkn8p2JyBf7bjc65SzNmrCJcmFpzi/T90AAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 24 Aug 2026 15:43:58 +0530, Viken Dadhaniya wrote:
> spi: qcom-geni: rename setup_fifo_params() to setup_spi_params() and make it void

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: qcom-geni: rename setup_fifo_params() to setup_spi_params() and make it void
      https://git.kernel.org/broonie/spi/c/ed07cdb2b386

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

