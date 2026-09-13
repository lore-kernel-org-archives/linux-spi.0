Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC743BDB0;
	Mon, 14 Sep 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377871; cv=none; b=k2uSRaBdjq3UgmSqyyr/qPDrOoHh2HB7awTdnPvu92Bo9vui6bAY/N4ZMgGTL5BfHmx4J3J6WDACNVYUox+krItGwNIy9K01JmiXfWAifgpaw2Bz9Bi1W1EebXdA6FdTcP5z6priywHkB0tCIBDZk9U9qOB1cBJ6Pt03XBoeHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377871; c=relaxed/simple;
	bh=tC1wv+ImbckLAm8UQHUgklYq4/p7MVHG+v9h6nIK45o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aIGOKyWBneycMjvuM5NEcfY+BaaCIHUtR+8Sjo6sNl1qiQB/fZ3EfRsd8TcZqtl8644e6m6qIK6CXLQcV5reHXAvhyHd1FHsS9np2Y/IHThvhCi/E6Ry1kVAWmRxw6ljgB94COhYVs/mEyYt4NaLPvxAv/GywMAledVhWEAVVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldDV9Z9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldDV9Z9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA11F00893;
	Mon, 14 Sep 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789377869;
	bh=fvA8Ngq3Gqk0wIDatkanDU2CgeiyWG49GttXyXakQVo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ldDV9Z9GuBg7OhLkcbiEzel9ikCFPA2YVD3Z7AiW52m4bP7oZzAABEqtBpJ3y7cUS
	 NeIbEW5yUWiee3CFtwuPIGRDvFc6x7RHaA+bfKWBuI/YSzn0LDaPyy/lsk/DmxROeO
	 cky3wrK2ZTWUC674SjjLQb4U7YoRXRnMI+UVFVvSJVHMHtC/A8N6gG+xEA6liRjq52
	 BNYv7AvJmg6zBpR4jsRw6L8RrdlfAKPVrnZQyP4eT8AOiU74AQAXySY1ZV8Ent6dJT
	 oHlvoyS2BhCZUt2YDzqd4OQUARCojoL+Ksq1/5OEJRsm1adY+vGWLIwuhfVZZfhxAt
	 ut94i6qub4GsQ==
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com>
References: <20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: avoid writing
 QPIC_EBI2_ECC_BUF_CFG register
Message-Id: <178934302922.1239410.17729512737637087382.b4-ty@b4>
Date: Mon, 14 Sep 2026 00:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tC1wv+ImbckLAm8UQHUgklYq4/p7MVHG+v9h6nIK45o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqp71JiJQxr1afYE6gItX+nzDjbEs/qDIUIioqk
 ze9GTLfsYmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqe9SQAKCRAk1otyXVSH
 0GHCB/0XoC63Tc5STf2bxhr96uO673rgVUg5m4dl8GEdxy+u0p4sDm6fFFciK1HZer6wi6NtlRL
 AxMFona9vD9bDknUoiY8cpblw866dVw+abClBMWlOD0Q1QoH6EDoSgwS+zdJK4teAW0SIq9tfTG
 lFCvamM35dwDWMSgcPTvMuZu11rCtAtWmh3ecRK5lgWlmKSPOIMNUmiyQ5EVl9fW210eGluovYP
 VauuiPuOYWKzYlWZdGPgMdCin2W2jxOkSjH8g3s7buGUGVYaDDdcTTGqXvHBc1sVL3uL981Kco+
 9jThShR7dEXKDEnxoo7FRRPLHHuvGEcNAdOYKdV0L9aiS/KX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 09 Sep 2026 16:08:25 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG register

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG register
      https://git.kernel.org/broonie/spi/c/930a7312c946

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

