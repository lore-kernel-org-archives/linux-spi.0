Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE053AC0EB;
	Thu, 11 Jun 2026 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169849; cv=none; b=bljMPE1m5m5Y6MXqUHZmSj8M28j4pHIGhpzaUhRPg6sZrY2yUR4T09M8gada7pqUEyLHjWoSx6T3GiPB8AEpbCg3B7tpLsEEy/hUcEh38+0TYABBVFHgY7RxcNi0Unx7EgHzjg2ugRRWIzr1Yh83vcnrYf5eyYW/IHa7cccTkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169849; c=relaxed/simple;
	bh=eDxguddQlxUrvId4LbOlhtWIxfA+Fqms1ywpsbZCJzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vd2tgZPhvb0/jQ5QJpBPLGN3Ge9y5XPuVxNYXr32JjDcJUmZuRSMvEbZ9AewRqDHSoIWbO/LOV6EkLArj9t4fsJcesO/T1vd59Nb6/RuuTrN3UscuZAAgg6UvgdCrF86HWfALJgvwNizB9ZiNZQG/GoBWBTHTpkxX29ee1I3zW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WufietZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WufietZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7703D1F00893;
	Thu, 11 Jun 2026 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169847;
	bh=hsCJH8jkgkWPbKFNS/J0Gi7UaLaw1J8pfTQzvdF0Tfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WufietZDjPb5CokDRjI7rTaJ19XaBnORqIqUBCqPDNFlUJLDST+lu/GP+g5w9SRqs
	 KUUE0l4RJEWsoaGlsxj0Bztv9HodMxlPKbX3LK6riOxpRf6LQOZRXq+yWKXESzrolw
	 o4ZrX/9N8oiqKjCR0yLb7tZ796KXkvNDX8hK2ex19RAeZWebXDRrLgiJSTwd6oBSjo
	 iPIxk9JtMbknojWBhxGARkGkb4OTOhthE1rh4BWTo+0QLRUzuWRj7gLXFeUdHwLay2
	 UsR7qd1HpY5Ix6OerX9NFZ8zGJKR0UPnRWaTWz/+DXsg9iRbRFIqDOSW8c2fsGfYp3
	 c0h7CvbURMHVg==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com>
References: <20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com>
Subject: Re: [PATCH v2] spi: rzv2h-rspi: Fix SPDR read access width for
 16-bit RX
Message-Id: <178110595731.232889.12415517955627517232.b4-ty@b4>
Date: Wed, 10 Jun 2026 16:39:17 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eDxguddQlxUrvId4LbOlhtWIxfA+Fqms1ywpsbZCJzE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqKn6057gNmSr6fRNjOM5BUW6GMalSTAt65x4kf
 Rc/iuxklvGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaip+tAAKCRAk1otyXVSH
 0G2gB/9QuLENy7kPtBpNMI85hBBgz6hMpB/k16OzZA4U4qKCJrTCc/3/apUA/j8n2sLE0jtL1lF
 aQ8fR9N2sdP1GbZWT8dt6EkrdagTynRGSyHb+bbBLvV1XGFVMU7gIDEcGSezEM+EL4XbO/FieQ/
 EB7z/3Mgg30/EQm7mKYCfin1FU+Etq5Ia32onq9rxrum+bmhCb+TWpu3zwvV4VFRdbIhLotjuCq
 Tqlv1RYqFzKno4yoGyVoLH87yocB2yfyv1lFQKLX0cANPn8mWbjGI0FowJajelaUdpbATJMHMJo
 wa8oSV4uY5jOcfN4TAX/p7MJUAZAa4hA9diry80QfwFs8z8a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 10 Jun 2026 20:08:17 +0800, Felix Gu wrote:
> spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.1

Thanks!

[1/1] spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX
      https://git.kernel.org/broonie/sound/c/310628484ef0

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

