Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623391;
	b=W20Z0F4DYgzi/9xjp4eAgRcHd+SWzs2LdNJpMDWi1HP4bSGN3vJEbdzyFyBrlHGatJpw
	 TUOj9x3Xwdru2aDTTaS7+Kc/TmQxtofq/QUp2/LlVjAyL3EAzfFpdPMhVtMapwdrhd4OD
	 4eAZerdH5tMVmRB2PfXodDzNO/lNzyXm6Ma3FSIiOLpZckIiphrfYrv3BBYBDOgn7aHZI
	 e01TCm8cFbCOXu9aZaNzKNs+W3RdhX/H+e/GX27hn6kaGMGvamDAt8XOcneyeqIW68OTm
	 HSuLcxpnF1FB9uJlDV90xoFIDg4qW6Wn092UtBLd/6U+xaUQLgWXPNh1nfcMdBjhJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623391;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=47gPGwQDcpWQVb0oOB9vJD1DBbnS1YYcP6qZGFfC+AU=;
	b=3sHzCji1XvhdzMfr4uVwp1twA+K6iqIxrYYbTiGjJ38eWNDHN8yjz5IRJM0g+DG3hzPr
	 xaN/Y09E2mEFQWo+BGZ57YbiW6nwJwDR38uuMRlkeVlqAyND9PnqraSFQgAkb/dB23tca
	 IV+/oOnB3pRYCXZ0QdyWmJ+B6MSXGAnQqoWfS6m1Yim2BwhOCIQ7VEDR4YfCbLRTsiqpA
	 KN9HnyZJFNmyEU1L9rRP41t5itC19F3eCOux4c9Hj4P875mU22TjW6bQSHM6eVRHcaUv7
	 jun2AL8vqbi0sHUzqv2xtnKe7nLCq+wyET4BeMg0irRA/lEHh3L17QaKAeV4H9NUj7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij5HJGTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A760A381C;
	Mon,  2 Nov 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij5HJGTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD71E1F00A1A;
	Mon,  2 Nov 2026 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623391;
	bh=47gPGwQDcpWQVb0oOB9vJD1DBbnS1YYcP6qZGFfC+AU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ij5HJGTDOeolTEdQC/crYdYRTVEBfDqTDg08/th/xWIwQT4+tEsSKn3W0dJaoGl15
	 +XHpT4tY2tjk3WOWKtNRoNwZOeEw96LQx6tTTu8V2EecF6xB60tiRN7GMFdXLkkjHM
	 YRhHlYS8RNZ7xIbKJLoWKnOF9Lu0NWVnggyTFzvBoHoSWloY1HbsovGDlmVQdqYX65
	 5H2a5ZabTiTXYgFIUfow4UF5beihn42xs5fH88DnMMdXAYbYWd6g6QvcjQ+7X1+IuT
	 zTAoaFZtTwj6+wFav9ev+wnSonVFBQX7y3FIXW/MoPqmqu+KzSHFYZd3tLIQQ2RWvy
	 kEvYKHASCM0DQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 35B142310559;
	Mon, 02 Nov 2026 12:43:09 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Jyan Chou <jyanchou@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>, 
 David Carlier <devnexen@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261030145909.285144-1-devnexen@gmail.com>
References: <20261030145909.285144-1-devnexen@gmail.com>
Subject: Re: [PATCH] spi: rtk-nor: Limit exec_op writes to one byte per
 operation
Message-Id: <179357771350.1716893.12371926655363855543.b4-ty@b4>
Date: Mon, 02 Nov 2026 00:01:53 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lrDIIr+Eg+99x731KjiM0ZvZdyWC+t1qUZHVn99o8oA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJetMae3cXfXhd8NZgtIfCQyK5Hr62815QeUFnete3y4
 sflS1pPdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAie7Yz/NPovT+3I0/a7NSP
 w5Y9b0I22auun/zpUXzyk7QpX1q7w5QYGQ4w91jkcT44tTQwjq275Nn6jZU6J/7PzQnJ4JN3sWM
 zZQAA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 30 Oct 2026 14:59:06 +0000, David Carlier wrote:
> spi: rtk-nor: Limit exec_op writes to one byte per operation

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: rtk-nor: Limit exec_op writes to one byte per operation
      https://git.kernel.org/broonie/spi/c/30421d2469d3

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

