Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794514340;
	b=HMcv/y4J44y2d+n6A4mc+pU3Ik/eXNnPT6EYEt8vHX09Kd6Idmu/WlQr0h6EDQY+d182
	 WDRa8gorHec1xqXdewPt05G1tRkY4fAGj0xRvXjtl2rjVOysxeN2lUJ8WeVSkS67tyfIi
	 /QENrkRQNgtvlUmarIRlCrbwnGMrof5KajRRTCurt6M+IoToxKg56U4PUOkoBCmeKEbbB
	 TMkLu1KgS8cU1fuGbCnanI0VXORZrOlMhXv1kb3O0h4te4EQl19Ko2tHe4GreyyNSyrME
	 zgiP1kKxPTvW2jz5GCWYyfvHXqTx6IKqU8S/er+R65kY6wcSNfV/Ayudv7ite4lFElA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794514340;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9fpTTl/wf6AJr6umSE+CPRu2oJNdc9XyyktaSY9PbpY=;
	b=2KUOVpcMBeAWK9F2ZW4SFSYu8eyHgXF5ElZeJBS7z4tWf1Egn+q3GG3aZhpPIok/aWlO
	 1rWBlek619mot+su6j6mms6LKwnNMVRKqIt7dlUGNAhrmJCNK1JdwkqycSaNrm/m7SRbY
	 xKtIt/f9ukLj/aIhfzC2yY0/s1+ybxLoHuIMjeYifMNLAZ2Jg/tAwO/2aWeXYcwZcGHHy
	 XN4qU2NZOfSEJSovIbLHi3l3W3IcF82xeMB5EiYqLtD1IJoKAxwukNMwINPd/kIEQcPom
	 ib/YPZCSGHOrHX2fGc77NGPby3VMWj8aflY5PK85uzqj6CDwlwUYg8owVegUPjtdo6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wd5LR3x5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A4C606A332;
	Thu, 12 Nov 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wd5LR3x5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF41F000C4;
	Thu, 12 Nov 2026 20:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794514340;
	bh=9fpTTl/wf6AJr6umSE+CPRu2oJNdc9XyyktaSY9PbpY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Wd5LR3x5Me6L4DjYpH7RjJgvEIUHTnafELJfE4lbU73zmNdBaldXlR3sSNQXDE0rx
	 cpCXv20hOL/iaqJ73OPT+LEExBym1VzA0yKj2SlRFh4FEHhSrCukhXuMSztKOjwdqM
	 zynzj1q6PuePZXVZNMDojDXujpUxwsQcgY1AR23TTvny+9nAq1OxdKf/CLd+CdJuzT
	 3nh0ePxvJMBi9fOqhjY4bt3pPmXbZ7n1OWo63UjkDT4Z7+c5hQwUWZTI8TY85CXaYN
	 RetJuVMppPAVUFs8M7LyohWaw+CDp5DnIt9p++Ndi5cEoOcczjyjweM+CMEQMZ62/o
	 ul+IDIXwa6dSA==
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
Subject: Re: [PATCH] spi: atmel: poll short PIO transfers
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Ryan Wanner <ryan.wanner@microchip.com>, 
 Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112-spi-atmel-poll-short-pio-transfers-v1-1-240ccc868cc3@microchip.com>
References: <20261112-spi-atmel-poll-short-pio-transfers-v1-1-240ccc868cc3@microchip.com>
Date: Thu, 12 Nov 2026 20:12:09 +0000
Message-Id: <179451432977.339049.8591158302502636785.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=broonie@kernel.org;
 h=from:subject:message-id; bh=B3s9LTuJyrYMtGqpBf4YhavMI4ad7zNib44eomiVWMs=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+yS4IOTDds4S3tibr5Utl4U1HmcIfSShF+tl5Jdvtj
 HkdPDepo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABMRZmVkmG18l1NKqPvphB+H
 7oVxsDndtLPrunVj5pVtcieOuzsv/MDwPzcgmmXNZXPfWK2G3QGHiz5pMIVnyIfV3fG5dNeTuSW
 eEwA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Every PIO transfer enables the controller interrupt and sleeps in
> wait_for_completion_timeout() until the interrupt handler has drained the
> receive data. For a transfer of a few bytes, the interrupt, the
> completion and the two context switches take several times longer than
> the transfer on the wire. Devices that do their register IO over SPI,
> such as SPI attached Ethernet switches, issue one message of a few short
> transfers per register access, so this overhead dominates their register
> access time.

> Busy-wait on the status register instead of enabling the interrupt when
> the transfer is estimated to take less than polling_limit_us, 30 us by
> default, as spi-imx does. The estimate uses the effective clock rate and

How big is the FIFO?

> the word delay. Setting the module parameter to 0 disables polling.

If this is dubious enough to require the module parameter we shouldn't
be doing this.  Most likely it's perfectly sensible and we should just
do it as standard, other drivers don't make this optional.  If we do
have a parameter it needs to be documented.

> @@ -725,6 +736,9 @@ static void atmel_spi_next_xfer_fifo(struct spi_controller *host,
>  
>  	dev_vdbg(host->dev.parent, "atmel_spi_next_xfer_fifo\n");
>  
> +	if (as->poll)
> +		spi_writel(as, IDR, SPI_BIT(RXFTHF) | SPI_BIT(OVRES));

We should ensure there's no interrupt handler running or that could run
in future, especially with PREEMPT_RT which puts everything into a
thread.  If we timed out a transfer then an interrupt could be
delivered while we're polling and try to also process things.  A lock
while updating the flag and checking the flag before doing anything in
the interrupt would probably do the trick.

-- 
Mark Brown <broonie@kernel.org>
