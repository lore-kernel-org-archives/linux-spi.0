Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620297;
	b=Iwko7wZgATYLanYcBr2VUzz+EAWNePGAFELUC93cPjixmSLu5LMXgM1ux1PwwkYrV0eB
	 PMR9yzI72DNBInZqE6FEnfHNtsDaZidgZQw2o0SF+SKJOxxiR6utuCrGR8LlB/CsFTAO2
	 b2ZU9miuKYAxm7EQB8E91T+wbbBFEbpBy/JYdrY5uXBjKHxX6vwhh15bBMwEoBuOsmnWr
	 DKx14jhPkOo6Pp/pVmuLKMJC9Hc2+ZDhFqK0ggaqhPQB+YneYWRb/nJ0Ya7t6GyEXXE5Y
	 1sfIO9UoQmdkYdiLq7syJQGji41jG2n/c/8Z2Eqk2sTEznArWWUnSUGP6S9LFW8D2Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620297;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=khCQZr+lZ5ps02/NBTrpcyjkpLu9gA2+Gk1GsRmHCXA=;
	b=KVa3JzAkvrbikL3iv5LqV9mOoxM9vbuU8AXKC62y88wtBmEcCGJGiWsjBfg8y5Sge4LL
	 GpdkVZ/i7dl8YwEpgWBm3zdKDYsroOuMX36dc/UlmK0GCXv+tE3UXcCQKUCIjJ6O3AEk0
	 vwulUhup3oPu3awBl34lfkLzjdNzupkTENjgH5xzO3SNSAedqOAoEZt4ynB5iVP5p8RQm
	 tACgu9H2W0lvmxzTB87aoN81PsGwsG/MWL1c5nhdfip9h3W/gE2Y4dsCJjpaZ4W51kpYZ
	 ih7vN8SM1uS6FGAT6AgVYCiVdhM+Vh3zaKn8lXEw5lOfnJMph4R0+nyPwBYzD7Phcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQm7XMoj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802E606A31E;
	Wed, 25 Nov 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQm7XMoj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF131F000D0;
	Wed, 25 Nov 2026 15:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620296;
	bh=khCQZr+lZ5ps02/NBTrpcyjkpLu9gA2+Gk1GsRmHCXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mQm7XMojXDRKOjTVodJNFQw5rj41uOgx2Mnln3HRo0PzjmMed2JfzKJ4FSUkvsVXt
	 bBbPcQULhAUyAqs1aDbNPwhYKrDNl4sDrwjT46YKkJTUwxXKHUO8qYHc3qAWBwIu4T
	 j7Mq8hB6jzxwbHseQbdKWyEJ3+6TGzHPhxmGD+4xuTo3Y6L1ReOZMV0yMp/hL7wNOa
	 30pwxz6cQIqbfRO4vQA14NsZOYRAV4Dv4wZJXVkw5B8kBbR+PtOHb6FGjXA5lmGDuI
	 Ql6bd44lZXfV9SttRxiD/OvxMbZzVHwp11N5Ftssz6QLaFAvnZHoqxDK8We/qXLwZ8
	 hE2iY0G2Q3ggg==
From: Mark Brown <broonie@kernel.org>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
References: <20261124-winbond-nand-next-phy-tuning-v5-0-261e0e712857@bootlin.com>
Subject: Re: [PATCH v5 0/6] mtd/spi-mem: Enable DQS control
Message-Id: <179554764437.947306.7383226666322227871.b4-ty@b4>
Date: Tue, 24 Nov 2026 19:14:04 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hiFMYrNelLS4EF+eSytAriGzVrBmGJlkNeuhF2BICI0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLZ/h7W4P6zcq1usKFgc8PuvLOp75/Ofv7cfm22YoHnX
 XWLl6xXO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRPCtGhk+ilrcqyliK9VSu
 nj3Pn5zY8uH3uSePaq33zhZm+bCXdxMjwxT9jPZHookW34u2rPTiUGTfvehhur5Tnclq2c2zHVS
 E2AE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 24 Nov 2026 15:43:01 +0100, Miquel Raynal wrote:
> mtd/spi-mem: Enable DQS control
> 
> For his PHY tuning series on the Cadence QSPI controller embedded in TI
> SoCs, Santhosh initially needed to access the availability of the DQS
> (data strobe) signal. This is a chip dependent capability, which may
> sometimes be enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/6] spi: spi-mem: Rename the DQS setter and pin field
      https://git.kernel.org/broonie/spi/c/fab01b136dfe
[2/6] spi: spi-mem: Clarify the conditions upon which DQS is usable
      https://git.kernel.org/broonie/spi/c/5520745c6e30
[3/6] dt-bindings: spi: Document the spi-dqs-not-wired property
      https://git.kernel.org/broonie/spi/c/2bc362dc8074
[4/6] spi: spi-mem: Take the DQS wiring into account
      https://git.kernel.org/broonie/spi/c/4c9572bc7052
[5/6] spi: spi-mem: Take the controller DQS support into account
      https://git.kernel.org/broonie/spi/c/828d25f820a5
[6/6] spi: cadence-quadspi: Advertise DQS support
      https://git.kernel.org/broonie/spi/c/dd1f49bd2c44

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

