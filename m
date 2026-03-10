Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897712BD5B9;
	Tue, 10 Mar 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153176; cv=none; b=DMWiuNNhRks2GAHMDIkCKfxZE9J7B/ZK3OFJK9QzXwYwu+gie29gsxJaJEmLPl7yWvJFelcWP0aGnaWsllTFAZry8RbplFMr5KGchAme308iib86Kle3kTYmVpXsnKUqKaJBj6qH1v4HdNyYPaB1BgubB2j8j8eSnaVuci1uweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153176; c=relaxed/simple;
	bh=nhKMFXNnyhgTkj4hZY1nMCDdAkUYa+v86e/CRucuo30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HKaEuxb8CzEkVSBJeeJBXqFkR3LZ78acQPQLSfttR0UAEIrxQELzDmaQYJkSHwoh9WtsLAFZ+acIGHFbatLps6JtNr5vfNdK9PwAAOm6oeYt1BlO3lRoK2mWk7Wc08LuF+9cUlgbG3rFBcMnkXIm1LYokcvJ6MDvPhhceITu2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhDpKvo1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhDpKvo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B98C19423;
	Tue, 10 Mar 2026 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773153176;
	bh=nhKMFXNnyhgTkj4hZY1nMCDdAkUYa+v86e/CRucuo30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YhDpKvo14ROQoaSk3eXE+EkxRkc04I2GNgCoc9/FRN5ru27zIOA5QpVODjS9ZmQir
	 yX2jBISUKjhJUtQEau+mxo0xEfoZzTLr9x5zW5xdQgNTRwVGzGRKQWnmVZyz9qsDgB
	 Pi5mg7vTo5lA1mo8JZrN4vTHEy6Hp5tnS3g4y5qlZ0GCqMymqGq02Tt2+fD5XCw1Lx
	 1chKzsS/amLf+21w2YC7TkvEtEmx+3zfcUOz8R0c0BWAUiRdYJNHXdlvDaYAi/MLXf
	 tDmPvZcRPXVYTdw/+ZfdUadahNVJej0xku7PTbWRookQee4fnPbwdM7JX4XkYwapOu
	 FKP0JM/UUqoCw==
From: Mark Brown <broonie@kernel.org>
To: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Ron Economos <re@w6rz.net>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
References: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
Subject: Re: [PATCH] spi: cadence-qspi: Fix requesting of APB and AHB
 clocks on JH7110
Message-Id: <177315316932.168740.14659972400811576573.b4-ty@kernel.org>
Date: Tue, 10 Mar 2026 14:32:49 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-53144
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nhKMFXNnyhgTkj4hZY1nMCDdAkUYa+v86e/CRucuo30=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpsCuW4n7xzOyiyNv9/8Y/k1t2RcaMpQtoMQv++
 NT5HHV/PmaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabArlgAKCRAk1otyXVSH
 0G68B/4+UvOoy/eOK3qi7bdtvXz0bV9rYJqgXMqJIgBlzgKZ0ik+KeRuQ44KkLsfl4MhIOMs7zq
 gfbyka+pSkKfhMRZH6mkgJydld2wEiypLgdWXR6BZRNh5G9ijRL8xAtE9Qh5JWZ8n6LILS+b37Q
 DSDPtvsv1dWXFTRngaQwQ8TP7b/SkQeGfHQexM6qHRjSu+jet45njUsMS42loW3ji8+q/T+3XsP
 s0UDSWCaHXDHtK5QOz7/1V3tC2iUyGMugPEoSoiR0jmSAMgyfNqRLhxNHSv7AZ8myYq4AMszwbz
 uvILLBlTMlx/lOTNIBgJX3JPk7jgrkxRIuazipw1E0OWcDrQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Mar 2026 09:50:35 +0000, Mark Brown wrote:
> spi: cadence-qspi: Fix requesting of APB and AHB clocks on JH7110

Applied to

   local tree spi-7.0

Thanks!

[1/1] spi: cadence-qspi: Fix requesting of APB and AHB clocks on JH7110
      commit: e53c0e99fd93da200c413deb57875f9f5fdb314a

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

