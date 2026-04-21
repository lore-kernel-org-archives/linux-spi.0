Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F32F25E4;
	Tue, 21 Apr 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792135; cv=none; b=DiV1Ssu/wdPqcUOy/kPg/JDF98hKcliqn1jkRycSkZw2Rzr9PJNLiZdGmwyiRQp6hhhhm3xfHYuxiYt5GAZPLIbZMHgMikqPn/sPutbipXS5Iva44BqwanK7MLUJBf9nrKzw564IdyfBYh+L818UznS9HnnkUodBzq8cpULVEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792135; c=relaxed/simple;
	bh=vXbVKismDRGKJEMtDedxJZfo7f3acmVBoag+z8X13LE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KJ77Y8oqWX64aff7uHWxzkSqjvRA4X1gQ/dgZNgn61UoG4EF0gBpdHDEEJEEDOHUsDEzudQmTXLTHxJoUfgE9Mp/N4pjAa9XJfmNK6HHHPu7WcIXoqi/bRGHYy5E21t0htIvJdAilp5IoXm0yg7C6vIqrp2YvPkqm1P2+RpDywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OydeabnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OydeabnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD3BC2BCB0;
	Tue, 21 Apr 2026 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792134;
	bh=vXbVKismDRGKJEMtDedxJZfo7f3acmVBoag+z8X13LE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OydeabnDpQVMebVcaNXpFhp3hrig3PepCTWCsnkWtvZBTYXLOqNb3whZAAfiInegi
	 OtIyOJ93P3rD+PCvnBmM5bW0c6YT7gK3pYgDv2kcwrZv/1uWLp4jmLhyAAhZ/NOiSF
	 J5dw6yBNwiexl738pxic9FK160Ticlr8yUkqsxpMRnudQcU9BKx+13XVsyrUJsPOjH
	 z+zVX3Z6E+b1MNMYwnmVxwqwgECBfQd0QTAq+CQ3AjCRb8amZPA3r6xPTv9tXW6PxB
	 gVC/Yn8OdVg2YTWNEVhpSnI89v1ra0xQcQzaIob0oNAw78dhVYXAh0ciJQfykbLNZI
	 R1XhHGu2SG6MA==
From: Mark Brown <broonie@kernel.org>
To: Dewei Meng <mengdewei@cqsoftware.com.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 olteanv@gmail.com
In-Reply-To: <20260421025808.6572-1-mengdewei@cqsoftware.com.cn>
References: <20260421025808.6572-1-mengdewei@cqsoftware.com.cn>
Subject: Re: [PATCH] spi: Fix the error description in the
 `ptp_sts_word_post` comment
Message-Id: <177678386627.43010.10504071627544811289.b4-ty@b4>
Date: Tue, 21 Apr 2026 16:04:26 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vXbVKismDRGKJEMtDedxJZfo7f3acmVBoag+z8X13LE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp57JEVyggZGRzc7XrMK+e+f8Xor+d4hmdwGT2z
 qfaAekec++JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaeeyRAAKCRAk1otyXVSH
 0ExjB/9a9Z0eBh4+5d2TltTA7m/xN3Of58IaN0sKAdwwshuvOwhHzmgyUfXcBZxjDrMtnuDnZJu
 9f+oC/PokDdxR6IRZuAZsjIbeAmGykYYCk0VRGNtFfhb7vExpQCxgqfZIKjsOKJDCsunk3Di8r6
 DW9ZeW8Tl4FdSAtaQP3a0KLBqp0xlkFlMOPOmWbXrfG6faDm6dvBlRmaiYo4Vs6nKlozIS2S4ah
 tkjwkg76ZQrVFSN7omKnqScAM7y0xiBpYtWv6Y1qLyD7UAwLo3iFb9kryIr3zzBd76UYV6v1g4B
 tKaOVahG8wWnyxX/lMvn873o1Ug+dcmQe6c2UdOaZQ0MExY1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 10:58:08 +0800, Dewei Meng wrote:
> spi: Fix the error description in the `ptp_sts_word_post` comment

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: Fix the error description in the `ptp_sts_word_post` comment
      https://git.kernel.org/broonie/spi/c/922f8c28811f

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

