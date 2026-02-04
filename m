Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FBC3D7D94;
	Wed,  4 Feb 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200955; cv=none; b=dNKn8/VvaSk28QgZisJdVifwcRRCQHKCPSVnORhpuin9u5okeS9mFnsFyVDK7pOJrRNBqHfNcUlT63x7MFqF1Q4jxWQfwOHnTrBuwQk9+ylRCRnjS9BtncAq6mOYAgaA6LXjodXXKwpuTPjjEbZqag0opTdyhx2Y0G5Tm4zYOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200955; c=relaxed/simple;
	bh=LB2WMksQyfGJhpuEI5Ie02v21FjdlyP1rys2s1FlD/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=usw/nP3B1XtmdjwiS24fwIJaFCl1K3rfRGSEB1sQg5Vzk9chTGzjpSBSb20T/Yw+XdfoANwDdFKtmo3wguTs7hvjjf1a/iauMQRnjwwxSDKbYI/0PK/T/IeSBYX+62WpQCTSgFtEboQvhCUUtv7M9HfKG9xJTNbFENYpIVNzQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oaqQ7l76; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oaqQ7l76"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DD18DC24394;
	Wed,  4 Feb 2026 10:29:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 46B1B60745;
	Wed,  4 Feb 2026 10:29:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 136BF119A865B;
	Wed,  4 Feb 2026 11:29:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770200952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=01QzhpC+ZgIOpSS8o+hjNlELWio1HwrhuHHzfZRg1Sk=;
	b=oaqQ7l765iQGfSSBX//MES/7TjJpX1/lKC0GyoQDpXOQCn65sDKixQW1izvZx0JghaJrOR
	w45VURFbK+s0tQgpoqr7mbYdRn0x5WCWZyM//0viVoBMTSS4gCKawU3MKv5Osd/aFc+5VO
	8/c2T/N35yj8P/tpq+LNDCg4fXIJ8XD6iqV6uACasvhqgE6pi/WuDwqkor2klF3/FzMhf1
	pBhHOnGlp7ruQd7rI0sHSzEdPo1+W9EiYGx/WvBDlrChXYT3E1wEQTQD/ZiANCYS9+xEQm
	C3tL1rmp2UyPyAjsjDHiKzWhq7Ek+UCm/NwDP/t62jGxMEFqIFeaR9eZUUqaOg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <praneeth@ti.com>,  <u-kumar1@ti.com>,  <p-mantena@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [RFC PATCH v2 00/12] spi: cadence-quadspi: add PHY tuning support
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com> (Santhosh Kumar K.'s
	message of "Tue, 13 Jan 2026 19:46:05 +0530")
References: <20260113141617.1905039-1-s-k6@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 04 Feb 2026 11:29:07 +0100
Message-ID: <87343ghkek.fsf@bootlin.com>
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

On 13/01/2026 at 19:46:05 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> This series implements PHY tuning support for the Cadence QSPI controller=
 to
> enable reliable high-speed operations. Without PHY tuning, controllers use
> conservative timing that limits the performance. PHY tuning calibrates RX=
/TX
> delay lines to find optimal data capture timing windows, enabling operati=
on up
> to the controller's maximum frequency.
>
> Background:
> High-speed SPI memory controllers require precise timing calibration for
> reliable operation. At higher frequencies, board-to-board variations make
> fixed timing parameters inadequate. The Cadence QSPI controller includes
> a PHY interface with programmable delay lines (0-127 taps) for RX and TX
> paths, but these require runtime calibration to find the valid timing win=
dow.
>
> Approach:
> Add SDR/DDR PHY tuning algorithms for the Cadence controller:
>
> SDR Mode Tuning (1D search):
> - Searches for two consecutive valid RX delay windows
> - Selects the larger window and uses its midpoint for maximum margin
> - TX delay fixed at maximum (127) as it's less critical in SDR
>
> DDR Mode Tuning (2D search):
> - Finds RX boundaries (rxlow/rxhigh) using TX window sweeps
> - Finds TX boundaries (txlow/txhigh) at fixed RX positions
> - Defines valid region corners and detects gaps via binary search
> - Applies temperature compensation for optimal point selection
> - Handles single or dual passing regions with different strategies
>
> DQS Support:
> - Adds optional DQS (Data Strobe) mode for improved timing margins
> - Configures read data capture to use dedicated strobe signal

I am glad to know this signal is useful. I do not consider the DT
property as being the correct way to carry this information ATM, so I
will investigate a bit a propose a solution that is more uniform with
the rest of the chips description we have today.

> Patch description:
> Infrastructure (1-5):
> - Patch 1:   Add DT binding for spi-has-dqs property
> - Patch 2:   Implement spi_mem_execute_tuning() API in SPI core
> - Patch 3-5: Refactor and integrate tuning in MTD SPI-NAND/NOR layers and=
 call
>              tuning during probe
>
> Cadence QSPI Implementation (6-12):
> - Patch 6-8: Preparatory refactoring and DQS support
> - Patch 9:   Add PHY tuning infrastructure with placeholders
> - Patch 10:  Implement complete SDR/DDR tuning algorithms
> - Patch 11:  Restrict PHY frequency to calibrated operations only
> - Patch 12:  Enable PHY for direct memory-mapped reads and large writes
>
> Testing:
> This series was tested on TI's
> AM62A SK with OSPI NAND flash and
> AM62P SK with OSPI NOR flash:
>
> Read throughput:
> |-------------------------------------|
> |           | without PHY | with PHY  |
> |-------------------------------------|=20=20=20=20=20=20=20=20=20=20=20
> |OSPI NOR   | 37.5 MB/s   | 216 MB/s  |
> |-------------------------------------|
> |OSPI NAND  | 9.2 MB/s    | 35.1 MB/s |
> |-------------------------------------|

I am surprised by these numbers, I would expect these to get higher for
SPI NANDs. I will test the series and report my observations, especially
since there is also ODDR SPI NAND support now (in nand/next, should be
part of my upcoming merge request to Linus for 6.19+1);

> Write throughput:
> |-------------------------------------|
> |           | without PHY | with PHY  |
> |-------------------------------------|=20=20=20=20=20=20=20=20=20=20=20
> |OSPI NAND  | 6 MB/s      | 9.2 MB/s  |
> |-------------------------------------|

Overall I want to say that this series has greatly improved already, I
am really looking forward seeing this merged. I have several comments to
make, but they are mostly minor improvements which won't be very
impacting.

The tuning procedure is very well described in the code as well, which
is appreciated.

Please remove the RFC prefix for v3, it is clearly no longer needed.

Thanks,
Miqu=C3=A8l
