Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F551FCCE;
	Wed, 30 Sep 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792860; cv=none; b=H4m9zK9ZgdhpNW6EM8hAnn4Ksa1zVKbBuND9w8UEJfn1DD1Qr95v6/SPn1QpHy5Sre7AbcEG49/c+ltwT/fv6fyIN1Kj3B3C/UzGrVF6la7dWPz0uASHRXW8Xmlg6pUGcqVQ++cb1uJNcY7cU1RTbtx3hhCUy5E20TOKT8bVrss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792860; c=relaxed/simple;
	bh=NVTqCHZirSFfFjlrWiar6kDMpCimYL4sMpwRLWmz634=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lYUHg9XxXCR4B+DMzRvjX5lHxhTU2k7HMMg1F5LgnQf6o9eSat9nTfLvWDkAHzJHy+l9hGeod7gYE4Bd4kzzxFyfiyIRBAQtGAKzgBykvjhlSmewnvZ6W6VrTv+D9f2xMHcL+VLtqcCtopZLU78AYqXvsNg/265nbXTp6sv/f3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi6zloh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi6zloh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B31F00898;
	Wed, 30 Sep 2026 18:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790792859;
	bh=pXrIXqfH5ZaZvBxsmPhaKPx/PCosusHRAdqLOdXaJ2M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Wi6zloh6RWH8/GHKu69phCIKh+skVvrZT1Rw+7dNoTWH/uBGbe2DVstkjiLO2A8r3
	 MMSMl1f01DZ42+iT8Ebbq05iyymjDNp9JjuedVnaXiItVPc0ZReQGBiPyhne6SP19i
	 +qKhDeyzECNhVeN4itjumWKoR89tl33mvjT3Xls18wU9y+XB6V/ErYx2K3vnHLUL06
	 ReBnFjLDv4w9q8Qr0KZ9NK2FIZrHjREugkmC2JrHIVT9vfMbTEmUj0UbYKlqCO1s/v
	 rm3Wu7N0mYEWJ7eV7OFPng6cY89XLH3jLkqwiayA4wThhgnbLQG8Gt3OlS8t9DgKyY
	 VVCwWj9X7PKPg==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260924-qpic-snand-set-qpic_version2-v1-1-a0a9a3e0d06a@gmail.com>
References: <20260924-qpic-snand-set-qpic_version2-v1-1-a0a9a3e0d06a@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: set 'qpic_version2' flag
Message-Id: <179078622534.116826.12304094168953530603.b4-ty@b4>
Date: Wed, 30 Sep 2026 17:37:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NVTqCHZirSFfFjlrWiar6kDMpCimYL4sMpwRLWmz634=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvVSXi2t6tGNCtwajiXX27ZQOlt+3GVtHlK+ML
 GkOFPJPZ3CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar1UlwAKCRAk1otyXVSH
 0AafCACCGXb8f65sM+Pn9ZFHDA0c2JHQeoxlAhrcaA5ni3SiW8t0YhL4ZmK3Rmgv7eQv77idStr
 QAda9etGkO3vUB3DvwX2tA6V/4QbCkc9icWPP7loOfgKw0sC9XGgr5crgVgiUungm7B7qVOIDS0
 xjj6BT2eI4pBaBMJ8BnZ8szLAKLzhBHWko7rnPQSs19PLbHVZNSF15VtIhTZ0EANsqyWC0l1cE5
 4lA1aVCIh0cZLh57Zremu+YzOTRf8HXaKw28I6gk4E3sFYGetcTVbrttCqSlK+eenKJ82ibKFfw
 juMWU6v8RlBqVMKptO3lsi5t0K7no5TfGob9ByTI3XPWknjs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 24 Sep 2026 19:02:56 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: set 'qpic_version2' flag

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: set 'qpic_version2' flag
      https://git.kernel.org/broonie/spi/c/52efc89ccf66

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

