Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179408;
	b=41zNie+yv269SggFZOSAGapRhC+IEaFd9kX9PGz9fyLxrkn3Nk74waJ41ebkxe3ywOxW
	 35RVDJ7jB6xWYOML0FHKAVx7NDAciFlz1yMMt4HEQwOON0R689r/nWEExhM85zcY6ZRiT
	 h1R53KC0GJaaRzCswU7KjEjN1Qo17mjEWMhBxXZTGP/eXvu0L5EL78PVSaQAe5jxSDeEm
	 iv6PBazKgbxq5YFfbiTWcZAdIDPw5Qe5q5cWl50Y5CUTLhXvipKCERtK1YhzYQA0WENna
	 pMtg7m6B4b5+KNNYDxS/LX1oIoXbPQ4i1Ri9gp16dVAY1nWSL0xqeT5vv3/j57WLWWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179408;
	h=Received:DKIM-Signature:Mime-Version:Content-Type:Date:Message-Id:
	 Subject:Cc:From:To:X-Mailer:References:In-Reply-To;
	bh=tFUgsonzdWZLAS1pzTBqmSJ/wCyu7F0wrC3wsF9xA4k=;
	b=WvC/JnNyAOEDToSrs2vhb+gZKPiv3uM2b7jeJS6u+aTOUrUdUPV3kwPufau4RC1NRMM5
	 RHgnwQEzvvgxzMyiFDkuLiHJl78pUShj1fhMa2zKWQTioUJRnrwaWL0R6QRjTl0WYbrQs
	 mM+Wi0Kji52CKate4J0RMTpH/7ZqWxTReDJKCPoURJjmSuGX/mv8sDB3p9eRYuy6LwE9A
	 8HzV5Nem1cEc2jPp0MZtfNLTXn3yYwuo62/8gQtFBAydxd4hn+5HnI1qjmwshfRy9MudR
	 G7+jWtM3jmYdEy87eRl1UJrwaUydTi/V1PBbZw8Czm1I6no2WW3BrgGaUZ7hZkQPuHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZgFJpCS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E5C0F60A261C;
	Fri, 20 Nov 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZgFJpCS
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 427CC1F000E0;
	Fri, 20 Nov 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795179407;
	bh=tFUgsonzdWZLAS1pzTBqmSJ/wCyu7F0wrC3wsF9xA4k=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=QZgFJpCSXGErrdr7UZI00oLmHhVCCzdMT8VQHkB/2F1wAFIhB2Ju7hPV/BR3TRngO
	 2DF7hTlWHP0e56sa6XPyR0a3O+pwhnGkBosvxlP90u4xA+4hZ1iizknD54IuFKdvXC
	 E5OV5R2Nkkdp4lOpFjF7YlbZB+687R7APSJT44S5a/zSOS+V92V4LcgaXW7ybsu3wm
	 MCPcj3qs08uw2zjtBZude5YsTD7MdmOjbvu2xJxiaVYJ6ALPWmLOFprSq0KuQDpv/C
	 qV4hKlPDWeom4IzCEEAZTnV6CLX1D5QJFe3IeNbVhXXCAuba4dHHR1tdGOFhGZ0z48
	 2DRKoKoEQ/WCg==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=cd2dae19cb24704fa8f412b0fcbc099e07be2af6d62f1bb1ea7d9fe316ac;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 20 Nov 2026 13:56:44 +0100
Message-Id: <DN01ZL81VTHB.3PB0JO4WI6WU0@kernel.org>
Subject: Re: [PATCH v11 00/19] spi: cadence-quadspi: add PHY tuning support
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <praneeth@ti.com>, <sebin.francis@ti.com>, <u-kumar1@ti.com>,
 <srikanth.boyapally@amd.com>, <m-shah@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Santhosh Kumar K" <s-k6@ti.com>, <broonie@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <pratyush@kernel.org>, <takahiro.kuwano@infineon.com>
X-Mailer: aerc 0.20.0
References: <20261105105832.2134313-1-s-k6@ti.com>
In-Reply-To: <20261105105832.2134313-1-s-k6@ti.com>

--cd2dae19cb24704fa8f412b0fcbc099e07be2af6d62f1bb1ea7d9fe316ac
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Nov 5, 2026 at 11:58 AM CET, Santhosh Kumar K wrote:
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
>  - Patch 1:   Add spi-max-post-config-frequency-hz to describe maximum
>               frequency achievable post controller configuration
>  - Patch 2:   Add spi-phy-pattern-partition phandle for
>               NOR flash PHY tuning pattern location
>  - Patch 3:   Parse spi-max-post-config-frequency-hz in spi.c; adds
>               spi_device.post_config_max_speed_hz (0 when not set
>               keeping all existing DT fully compatible)
>  - Patch 4:   Extend spi_mem_adjust_op_freq() with a bypass: if
>               op->max_freq equals post_config_max_speed_hz, return
>               immediately leaving op->max_freq unchanged. All other
>               ops are capped to max_speed_hz. Also require per_op_freq
>               controller capability for post-config ops in
>               spi_mem_default_supports_op()
>  - Patch 5:   Add execute_tuning callback to spi_controller_mem_ops and
>               spi_mem_execute_tuning() wrapper in SPI-MEM core;
>               serialises access via spi_mem_access_start/end and
>               rejects GPIO chip selects
>
> Cadence QSPI Implementation (6-14):
>  - Patch 6:   Move cqspi_readdata_capture() earlier (preparatory)
>  - Patch 7:   Add DQS bit to cqspi_readdata_capture() (preparatory)
>  - Patch 8:   Add complete PHY tuning support: DLL management, pattern
>               verification (NOR via spi-phy-pattern-partition phandle,
>               NAND via write-to-cache), SDR 1D and DDR 2D search
>               algorithms with temperature compensation, AM654-specific
>               execute_tuning entry point
>  - Patch 9:   Reject 2-byte-address DDR operations via a new
>               CQSPI_NO_PHY_TUNING_WITH_ODDR_2B_ADDR quirk flag to work
>               around AM654 OSPI erratum i2383
>  - Patch 10:  Refactor direct read path for PHY support (preparatory)
>  - Patch 11:  Enable PHY for direct reads at the calibrated frequency
>               when both transfer boundaries are 16-byte aligned,
>               falling back to non-PHY DMA otherwise; also reprograms
>               DLL on chip-select switch when two devices have
>               different calibrated settings
>  - Patch 12:  Enable PHY for indirect writes of at least
>               CQSPI_PHY_MIN_INDIRECT_WRITE_LEN bytes
>  - Patch 13:  Reprogram per-device CS timing on any chip-select switch
>  - Patch 14:  Reprogram the PHY DLL (master config and RX/TX taps) on
>               runtime resume, since the DLL loses its lock when the
>               OSPI controller is power-gated
>
> MTD core (15-19):
>  - Patch 15:  Extract spinand_select_op_variant() into a shared helper
>               spinand_op_find_best_variant() with a skip_mask
>  - Patch 16:  Negotiate optimal controller operating point before dirmap
>               creation; iterate all read variants in performance order
>               across ODTR and SSDR interfaces; re-pair cont_read_cache af=
ter
>               PHY tuning via protocol-shape matching
>  - Patch 17:  Extract spi_nor_spimem_get_read_op() helper (preparatory)
>  - Patch 18:  Execute controller optimization in spi_nor_probe() before
>               creating dirmaps
>  - Patch 19:  Reset max_read_op frequency for security register reads

So what is the merging strategy here? Getting the first parts in and
then getting the spinand and spi_nor in in the next cycle?

FWIW, the spi-nor parts looks good.

-michael

--cd2dae19cb24704fa8f412b0fcbc099e07be2af6d62f1bb1ea7d9fe316ac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCawBDjBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jlKgGAmJfvydKg0f8fTncnEJee3RHHg0horD+2
iFLHf5kuyyb9k43qSNyXNtEh8Z9lOWHvAYC2s5jKfeXC8nMtNHHSPMfBTTj4BbZV
boFxqVsvcIKVaEBgl0odMoW/LoONdY0SoiI=
=fiz6
-----END PGP SIGNATURE-----

--cd2dae19cb24704fa8f412b0fcbc099e07be2af6d62f1bb1ea7d9fe316ac--
