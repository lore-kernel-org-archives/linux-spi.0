Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D481D61B7;
	Sat, 18 Jul 2026 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784334229; cv=none; b=DUocxKYLN10avg1egI3qedcHo/QLPUB/cVNMOWiw6/xaF0h+25jfRcTvwrUhLQKUUVppheE5mDO/WDVqmA7xQkGDNW47J6eMytYqNXUNif9UuRp/QqPZZ1ANBHacodcWT/wnN7KVHsMmsmq7Ox3Ee+D8XGtDmfkKcYfmMDWxlaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784334229; c=relaxed/simple;
	bh=uYYiCXCtOTBYlV7UAKPflJqhse9npjrSQtrT8YFvGwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f0ZY5errQp1hp/KnUJoC0+UJ+az/QIbAI1dsMLi3j7RRh+SHrvg1CTMcikBCgPHSUwOU36UlCyGRLUjKgzMItsjZ6kEUPGFacZ+viXvsC1V0GpNnkCQFmHBZCwQ9MNOlwybHQ44auOC75mSZ+2CeiT0YG4rkRRFnmB5PHzd2fqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnEeopC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnEeopC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADCC1F000E9;
	Sat, 18 Jul 2026 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784334228;
	bh=t5ewH2mBWi4WdGCNAkdr3NFsZAc8gg2+WW51sFmYU7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AnEeopC79QfCC/2lFQoUaqP7o9SWKhW4GiZO+GPcGkrioBEMO9cvwI3yQNlg+TuBp
	 GGSSf2nqNS4uXBcbjfzNaoSy49i/exK8ceIJA4jm4Ar2JkmFZCiZlZiKksvjHqrInM
	 gGN8peVwm0cjHErnNXuVw+P5Vz/hHWNoCjyqpYl1/58zbjB7SMUi8t9qcY2cLH3tYZ
	 CRkSIcUYAXLW+XyV8lshiLoJoCAKIN0J/JvE97vrLoRiCmaDoArTsvBUWPwMSHOP5I
	 0HmDtBCRGHo0XXhD69qWjMSqGLCXlRCDuaCNm4BpOdAvQYWaPJBOvXd9LJfWjbRKOD
	 3PZmJhouSvCZg==
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
In-Reply-To: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
References: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
Subject: Re: [PATCH] spi: geni-qcom: Fix sticky ret causing wrong return
 value on invalid proto
Message-Id: <178421750505.63368.1033774319423395300.b4-ty@b4>
Date: Thu, 16 Jul 2026 16:58:25 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uYYiCXCtOTBYlV7UAKPflJqhse9npjrSQtrT8YFvGwU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqWseRrgkNDw3hSRbt21mK4NBvXwvdwaZPwJ5cY
 7qD3YKNnZmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCalrHkQAKCRAk1otyXVSH
 0EF5B/9opmo1IpaS4K6QVSfjB9RDfGnBGy4mzd5mfw0vrmeYGi5CUt+Tf3CY53Xb+52dE4ZvPMX
 LE75RFuhkQT83cMMzt1Ba6tKFlLAiCjoxDdAcbaSPPvJSqtLs2jGvlyk9fqNdw/Yay/p7NpUmTW
 pb/yZQlqGQ58AwWQscL7M0NUp02LcNTq6K4uy7MkiJx1haBRKtGkO/2zuQfXx6WHbSWGEIXC+3e
 MxabB5ZpoTPI/+UnFvbOtyfG7i6y7YqfVN3qNtVLxHNZaC8razKazRKeznFm32vnPL0y4GTo5HX
 9TXGCeHW/pKUc1BiRto8DGuhCuh1teX8ApKFtFZlgNnmc/Ye
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 16 Jul 2026 13:55:45 +0530, Praveen Talari wrote:
> spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: geni-qcom: Fix sticky ret causing wrong return value on invalid proto
      https://git.kernel.org/broonie/spi/c/2c1c13da3a3a

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

