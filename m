Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180722;
	b=KgTmyblz/cL+DU4Q0gaanAZ9tZ+9r/KYVsKMqd9lwPk9mz0Gac2S8GZfWuYvF+QijUre
	 03CGMA/o/eA0M6+kgOr7l61KmsQnscrCCXDNg6beUCMTaIGn7gmWOJnxVthNZ+EJ/NrUb
	 +Pw8UyB6gOGPjyMLqmlhg8GWO5ZsqSzoy4HL+b6aKD03SfqB5BsDKlbfpPWeU4FkNBQlW
	 tjApmMKlszNLkSn43MVtQ8e370CtwRd1szEz6vVLtzPjAkjFxb2QeFvOvM6tM1FkBqKKb
	 Fnq7X55F48qAiRbnsv+U+06o7DdZK+o+d5QcWpLkSuA2chWngQgIDz0oCst1ZWWjCTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180722;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=61GJjhwg5oOvms+aARYdro5wTTJ4sOIsLi6nvULglvA=;
	b=hxsg/Ok6VnxEfibzjttE375ve0xWeGBWPX2JtUOQy4HuenAeD9u5htPVOB3d58rCRt1+
	 u7/1f1rJc3f2ZVYJiirB6Ukpa+BQCak6LO6gSb/xSyPdSptTQ72jwRRcsuDC/2idFQQ0L
	 fRqAcOZAW/jZWU614iMr2YEacXsB2AqfsEr89sqfVd2M4loyoY+4smsOIx0mx+rMJMnOh
	 aNvaI0+GqmZGOo13DdOZQCJUd/qLf87P2erjVH48lVVYpTf+1RfExwvCO77Nk0Qpprgi+
	 /ixZLXJ6cDg9FKB5604wo8gvye+//75ewPijEdh3DdQkifPrnZNRW9mSD8PFyWWX39Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2w4IsVbA;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52676606A33E;
	Fri, 20 Nov 2026 13:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52676606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2w4IsVbA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DB7BBC62216;
	Fri, 20 Nov 2026 13:18:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23B7E601B9;
	Fri, 20 Nov 2026 13:18:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7854611BC017C;
	Fri, 20 Nov 2026 14:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795180718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=61GJjhwg5oOvms+aARYdro5wTTJ4sOIsLi6nvULglvA=;
	b=2w4IsVbAQRTkTGYemx/0oRtViPXyOE0KkUbuv49VjBXdHmRnPbyS1I4C6rx05vpF1EplHc
	D8fvFnixkqXgxca4MrcWmjcaALBKSrjssO0IxbFZ8nNzRaG4p2qzu7MJSEGc1OFRiALigY
	0Rd83VmxTlqCDNOULfTWF1ALyNMWv8B39GvcIZXHdBL0wW3HbvBrMOMY2o1peBxbygRZEa
	/L8gjADasA2YHLR8a61gDVbCxZ5aIRWqKh192/PKhkGHSD3Pfk9AHdUAqPfKX49PqsKHwn
	sG2A1VNhg4rqYlgwHt7kdny058RU0UvQc1P3YcEiO+Qk02o9dhTTN4hP7MPm5Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Santhosh Kumar K" <s-k6@ti.com>,  <broonie@kernel.org>,
  <robh@kernel.org>,  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,
  <richard@nod.at>,  <vigneshr@ti.com>,  <pratyush@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,
  <sebin.francis@ti.com>,  <u-kumar1@ti.com>,
  <srikanth.boyapally@amd.com>,  <m-shah@ti.com>
Subject: Re: [PATCH v11 00/19] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <DN01ZL81VTHB.3PB0JO4WI6WU0@kernel.org> (Michael Walle's message
	of "Fri, 20 Nov 2026 13:56:44 +0100")
References: <20261105105832.2134313-1-s-k6@ti.com>
	<DN01ZL81VTHB.3PB0JO4WI6WU0@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 20 Nov 2026 14:18:31 +0100
Message-ID: <87cxrzbpzs.fsf@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 20/11/2026 at 13:56:44 +01, "Michael Walle" <mwalle@kernel.org> wrote:

> On Thu Nov 5, 2026 at 11:58 AM CET, Santhosh Kumar K wrote:
>> This series implements PHY tuning support for the Cadence QSPI controller
>> to enable reliable high-speed operations. Without PHY tuning, controllers
>> use conservative timing that limits performance. PHY tuning calibrates
>> RX/TX delay lines to find optimal data capture timing windows, enabling
>> operation up to the controller's maximum frequency.
>>
>> Background:
>> High-speed SPI memory controllers require precise timing calibration for
>> reliable operation. At higher frequencies, board-to-board variations make
>> fixed timing parameters inadequate. The Cadence QSPI controller includes
>> a PHY interface with programmable delay lines (0-127 taps) for RX and TX
>> paths, but these require runtime calibration to find the valid timing
>> window.
>>
>> Approach:
>> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>>
>> SDR Mode Tuning (1D search):
>>  - Searches for two consecutive valid RX delay windows
>>  - Selects the larger window and uses its midpoint for maximum margin
>>  - TX delay fixed at maximum (127) as it's less critical in SDR
>>
>> DDR Mode Tuning (2D search):
>>  - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>>  - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>>  - Defines valid region corners and detects gaps via binary search
>>  - Applies temperature compensation for optimal point selection
>>  - Handles single or dual passing regions with different strategies
>>
>> Patch description:
>> Infrastructure (1-5):
>>  - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
>>               frequency achievable post controller configuration
>>  - Patch 2:   Add spi-phy-pattern-partition phandle for
>>               NOR flash PHY tuning pattern location
>>  - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
>>               spi_device.post_config_max_speed_hz (0 when not set
>>               keeping all existing DT fully compatible)
>>  - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>>               op->max_freq equals post_config_max_speed_hz, return
>>               immediately leaving op->max_freq unchanged. All other
>>               ops are capped to max_speed_hz. Also require per_op_freq
>>               controller capability for post-config ops in
>>               spi_mem_default_supports_op()
>>  - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>>               spi_mem_execute_tuning() wrapper in SPI-MEM core;
>>               serialises access via spi_mem_access_start/end and
>>               rejects GPIO chip selects
>>
>> Cadence QSPI Implementation (6-14):
>>  - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>>  - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>>  - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>>               verification (NOR via spi-phy-pattern-partition phandle,
>>               NAND via write-to-cache), SDR 1D and DDR 2D search
>>               algorithms with temperature compensation, AM654-specific
>>               execute_tuning entry point
>>  - Patch 9:   Reject 2-byte-address DDR operations via a new
>>               CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
>>               around AM654 OSPI erratum i2383
>>  - Patch 10:  Refactor direct read path for PHY support (preparatory)
>>  - Patch 11:  Enable PHY for direct reads at the calibrated frequency
>>               when both transfer boundaries are 16-byte aligned,
>>               falling back to non-PHY DMA otherwise; also reprograms
>>               DLL on chip-select switch when two devices have
>>               different calibrated settings
>>  - Patch 12:  Enable PHY for indirect writes of at least
>>               CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>>  - Patch 13:  Reprogram per-device CS timing on any chip-select switch
>>  - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
>>               runtime resume, since the DLL loses its lock when the
>>               OSPI controller is power-gated
>>
>> MTD core (15-19):
>>  - Patch 15:  Extract spinand_select_op_variant() into a shared helper
>>               spinand_op_find_best_variant() with a skip_mask
>>  - Patch 16:  Negotiate optimal controller operating point before dirmap
>>               creation; iterate all read variants in performance order
>>               across ODTR and SSDR interfaces; re-pair cont_read_cache a=
fter
>>               PHY tuning via protocol-shape matching
>>  - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>>  - Patch 18:  Execute controller optimization in spi_nor_probe() before
>>               creating dirmaps
>>  - Patch 19:  Reset max_read_op frequency for security register reads
>
> So what is the merging strategy here? Getting the first parts in and
> then getting the spinand and spi_nor in in the next cycle?

Agreed.

> FWIW, the spi-nor parts looks good.

Same for the SPI NAND bits.

Miqu=C3=A8l
