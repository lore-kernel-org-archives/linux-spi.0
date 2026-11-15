Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767700;
	b=v025J+01RehCuhuED3/Xc16JJptYkIkBFRDffF0nWiIhRjqXHnFPgVoQCc1RW7zB13iZ
	 /LKDdBrV55iqqqgZOPJPaZek3tng97O6xx2smVCKAxoWomcFNgemYXzqR1ia6oNJbhYGx
	 wyENtsdZubX/Wf6fslQiVO9p3tp8EFF/H9Yca/USdysPsuwYAGeVsaVgQe/sxYJEE6TCh
	 BeBbizWrHe5h8suJBOjc/8U8CGuOnzlNsJTxTkAKuAYYdRJyUTiRJ5Ux6lDXUolbHg7/b
	 xtsRb4yW6j6ZWIqUV7dGnzud6HKGBJ62mkbJkCeiUlxI0Ng7GiMLEGpxal4KnepNFCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767700;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qkug38rLyLbe83/64lf7ib1wgEcl0CGh3ZUrgQo5Jks=;
	b=fbqv8OWGDlXgPHloCS8oV2RzRoQr9NA25/A4eOQyzPlXriY9omnrsIGPa2mJuqwiLgBH
	 3ajlbOJ5UP3sctb17apGVrGo/2BNHPoAIX9mKgmktN255NPYs4Oa4sO7nW4fIx9cJ64r1
	 xrMqFBe/DhPQdG1rAJz2MwvVYZiYkihLjuK1TWDA+0FCj3Xw+o1ZjU42jEDGWzGL7K/zj
	 KsWBcky0U1Lpc+Y2kxg++Pp64wVnnDQX1N84tYx87GhkY+1gVjWEeRhEOl0kdy97XTs/s
	 rGe+WsOjD1dj60MKKgTxxwiK4v8H3s7musUHXgSbt/36alNhWogAUbs87duG7Dv8SIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sx3NVrdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CE606A31E;
	Sun, 15 Nov 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sx3NVrdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426521F000C4;
	Sun, 15 Nov 2026 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794767699;
	bh=qkug38rLyLbe83/64lf7ib1wgEcl0CGh3ZUrgQo5Jks=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Sx3NVrdi1VgYbngp5NH90+dig9UknwSHPElGWYiROSAZneV1aTK5FTnMx36A8sXIn
	 kfVMWkje5YtxGN5Hj6mF0j6YNXeE/03h0KjxAP1AAeRzilH5CethTRFYOHgFFDyN6t
	 oUKay3D0IDC2ftaoymuiU3ZEJ6pFE1yrzzqLStzYPkEFWNOzmhehBWz+a7nlb7G1MM
	 t6oeV+fDgReD9Ducj9VdW99lZiyhdMvWDN7aK4MlokyW/6NWhqGoZuPkeck/ylF0RN
	 5X948ZmKmV7mLcBfV3XvBAQZJWv9/qJ7CfCIOsWK38PxXuzYa6wE1/ch0Y2BcfQYHc
	 vX6Q/YQBSV7Bw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 9B5E53406424;
	Sun, 15 Nov 2026 18:34:51 +0000 (GMT)
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
Subject: Re: [PATCH] spi: cadence: recover the controller after a failed
 transfer
From: Mark Brown <broonie@kernel.org>
To: Mario Behn <mario.behn@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
In-Reply-To: <20261105203703.979067-1-mario.behn@gmail.com>
References: <20261105203703.979067-1-mario.behn@gmail.com>
Date: Sun, 15 Nov 2026 18:34:50 +0000
Message-Id: <179476769088.140154.15578994019028111178.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Pki/m/0jZn1raj2B/B2AEHxynEcohG0kd/FPNYn4Kas=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+/vbeVa7N27eLO0j6l6ZrnZrG/l6Pn3UHJPd+ZF256
 fXm5XZWHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhIvh4jwxvJm4JhM9wmBhw9
 ty9Jy0HPLk+L63P6PunjfSWPe5kWNTD8lfoy++jBEy+Oe5zQf6N3kfP7y/l+183jzPefkDi55rl
 GCwsA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> When a transfer times out, the bytes it clocked in are still in the RX
> FIFO: the interrupt that would have read them did not run in time, and
> the host path never drains the FIFO between transfers (only the target
> path does, in cdns_unprepare_transfer_hardware).  Every later transfer
> then reads the stale bytes first and returns shifted data, and the
> device behind the controller looks dead until the system is rebooted.

> +static void cdns_spi_handle_err(struct spi_controller *ctlr,
> +				struct spi_message *msg)
> +{
> +	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
> +
> +	cdns_spi_write(xspi, CDNS_SPI_IDR, CDNS_SPI_IXR_ALL);

This is missing a synchronize_irq() to make sure that already pending
interrupts are done; mask the interrupts and then synchronize.  You'll
also need some handling in the interrupt to make sure that it doesn't
reenable anything.

> +	cdns_spi_init_hw(xspi, spi_controller_is_target(ctlr));

We should reset xspi->speed_hz as well, otherwise it'll be out of sync
with what's programmed in the hardware.

-- 
Mark Brown <broonie@kernel.org>
