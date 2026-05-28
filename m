Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B6380FC9;
	Thu, 28 May 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957035; cv=none; b=DHvrdjMnoWWFNxBf6NfkuxQDTnWoHCjR4LhgbNjuUK2GczwM/QnKMefrM3QwyOzdvrIIeuoeHqpz0isk8SJY+kqsqA577xceQgOTuuZO5Zo6g9EHIbE5WgpeAkBaLaHb15MIPjS/Gev6k7dUuXPKXHi30pU5rFJAq2JxhEK4J5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957035; c=relaxed/simple;
	bh=fcBo9m6sNmiJz3hn/AcoR8qI1vasGv/zhaiEI24Mv/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5HCQhnWpAAqeVqZ2W0vXj68T8Qq7wmJ9vnt68Z4mS/F0/cQA2kG7jW1cDJKqKz5V1IPO2pJVgZgZLBfNkcFeV7feblc/uKPjbuV3MWGLdWxh7Sqd24Y7kjF+GcNO6Tqp0RS71jZgKEuRxgWahJ2xnTnIyVfWG7p2eU9rRiHdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tjj4vUqh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tjj4vUqh"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DB2C91A3700;
	Thu, 28 May 2026 08:30:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99DBB60495;
	Thu, 28 May 2026 08:30:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 717E21088877F;
	Thu, 28 May 2026 10:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779957027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TIhNZRqO0cs5fDTYhOJoDKGLN/i3VRBigoH2M9bMmDQ=;
	b=tjj4vUqhb5xCE/MrzoC2dbYjZfQYt+kNLnYB+0TjXaI5UBcM7WGID+77ewDcgrPD/hJbSp
	IlYNFWb65zSPyO6qfq82ylxH+P0yvkJhMJ5TKe/BaLfsapzcEG8ZrBqe5rJW9aBMXv6fa9
	zKzKXVePzEGIJ+IirZS/JzL5BIQFOX3451htVwgyv8Bc1nRGKoWDZBbiBAUkIt+Q4q3u3x
	kaOMrvzUphY43gMT8kUHTkJYnzE8JZRy2Cqtj3TC8rSGma/+xRu7tHiWzT22DssUk5TdwK
	kPk0q98F7ECNzMypLSIteTTZ/EOjunWct8uSm4mwcyXYqZz17qlsD3og21+zAA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 00/13] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <20260527175527.2247679-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Wed, 27 May 2026 23:25:14 +0530")
References: <20260527175527.2247679-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 28 May 2026 10:30:23 +0200
Message-ID: <8733zchr6o.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Santhosh,

Very happy to see this v3! Looks pretty neat overall.

On 27/05/2026 at 23:25:14 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> This series implements PHY tuning support for the Cadence QSPI controller
> to enable reliable high-speed operations. Without PHY tuning, controllers
> use conservative timing that limits performance. PHY tuning calibrates
> RX/TX delay lines to find optimal data capture timing windows, enabling
> operation up to the controller's maximum frequency.
>
> Background:
> High-speed SPI memory controllers require precise timing calibration for
> reliable operation. At higher frequencies, board-to-board variations make
> fixed timing parameters inadequate. The Cadence QSPI controller includes
> a PHY interface with programmable delay lines (0-127 taps) for RX and TX
> paths, but these require runtime calibration to find the valid timing
> window.
>
> Approach:
> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>
> SDR Mode Tuning (1D search):
>  - Searches for two consecutive valid RX delay windows
>  - Selects the larger window and uses its midpoint for maximum margin
>  - TX delay fixed at maximum (127) as it's less critical in SDR
>
> DDR Mode Tuning (2D search):
>  - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
>  - Finds TX boundaries (txlow/txhigh) at fixed RX positions
>  - Defines valid region corners and detects gaps via binary search
>  - Applies temperature compensation for optimal point selection
>  - Handles single or dual passing regions with different strategies
>
> Patch description:
> Infrastructure (1-5):
>  - Patch 1:   Extend spi-max-frequency DT binding to accept an optional
>               second value forming a [base-freq, max-freq] pair
>  - Patch 2:   Add cadence-specific cdns,phy-pattern-partition phandle for
>               NOR flash PHY tuning pattern location
>  - Patch 3:   Parse two-element spi-max-frequency in spi.c; adds
>               spi_device.base_speed_hz (0 when a single value is used,
>               keeping all existing DT fully compatible)
>  - Patch 4:   Add spi_mem_apply_base_freq_cap(), called from
>               spi_mem_exec_op() to cap non-PHY ops to base_speed_hz;
>               tuned ops bypass the cap because execute_tuning() marks
>               them with op->max_freq =3D max_speed_hz
>  - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>               spi_mem_execute_tuning() wrapper in SPI-MEM core
>
> Cadence QSPI Implementation (6-10):
>  - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>  - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>  - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>               verification (NOR via cdns,phy-pattern-partition phandle,
>               NAND via write-to-cache), SDR 1D and DDR 2D search
>               algorithms with temperature compensation, AM654-specific
>               execute_tuning entry point; base_speed_hz is cleared during
>               the tuning loop and restored unconditionally on return
>  - Patch 9:   Reject 2-byte-address DDR operations via a new
>               CQSPI_NO_2BYTE_ADDR_PHY_DDR quirk flag to work around
>               AM654 OSPI erratum i2383
>  - Patch 10:  Enable PHY for direct memory-mapped reads (aligned body
>               region only; unaligned head and tail run without PHY) and
>               for indirect writes >=3D 1 KB
>
> MTD core (11-13):
>  - Patch 11:  Integrate tuning in SPI-NAND probe; propagate the validated
>               frequency to all plane dirmaps (primary and secondary op
>               templates) and to the persistent write dirmap template
>  - Patch 12:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>  - Patch 13:  Integrate tuning in SPI-NOR probe; patch the dirmap op
>               template with the validated frequency; store the result in
>               nor->max_read_op so all subsequent reads (dirmap and direct)
>               pick up the tuned speed automatically
>
> Series dependency:
> Merge after:
> https://lore.kernel.org/linux-spi/20260527173736.2243004-1-s-k6@ti.com/T/=
#u

Isn't the DQS series a prerequisite as well? I sent it as an RFC, we can
definitely consider it for merge together with this series once
ready.

Link: https://lore.kernel.org/linux-mtd/20260205-winbond-nand-next-phy-tuni=
ng-v1-0-5e7d3976f0f1@bootlin.com/

Do you confirm that you have "[PATCH DO NOT MERGE RFC 4/4] spi: cadence-qsp=
i: Retrieve
DQS capability using the core helper" in your branch for the PHY tuning
series to work?

> Testing:
> This series was tested on TI's
> AM62Ax SK with OSPI NAND flash and
> AM62Px SK with OSPI NOR flash:
>
> Read throughput:
> |-------------------------------------|
> |           | without PHY | with PHY  |
> |-------------------------------------|
> | OSPI NOR  | 37.5 MB/s   | 216 MB/s  |

I am impressed by the SPI NOR improvement o_O

> |-------------------------------------|
> | OSPI NAND | 9.2 MB/s    | 35.1 MB/s |
> |-------------------------------------|

Was this tested in 8D-8D-8D mode?

> Write throughput:
> |-------------------------------------|
> |           | without PHY | with PHY  |
> |-------------------------------------|
> | OSPI NAND | 6 MB/s      | 9.2 MB/s  |
> |-------------------------------------|

Thanks,
Miqu=C3=A8l
