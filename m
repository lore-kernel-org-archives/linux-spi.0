Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F174BEE5E
	for <linux-spi@vger.kernel.org>; Sat, 12 Sep 2026 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171542; cv=none; b=GsR4eVIjD3d8C/f1xS74rcJxxh7uglMsL03tPUG9A1HJNpsQB8hlLTgffpkL/A1Zx3+qYSqa6LE9p0hoeVG2a849++Vd1mqPSkiWpITMi9F7QFeeVwEppXafttSwfY8ehc3YPzAebj9Va8RyrHjjH/CqLjP19dOmwxfMR6ZiM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171542; c=relaxed/simple;
	bh=bEuJl6tbZwwTV8fGbs7IcdzniD+J04Zd/HtTkYcb35c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmJ1bh0NPwQI2ZYipJcmdoTkA/RlnzCxfuvBd0rPMYX9nH0/CS5ps70aetoG1EGwg7OtpJfQJSdj9Or7RA7JP2aiCd869kgZ4DNsk3OUedFwbd9eSkNH18NO8vCJzOSdHb4T6FAOKCMIftv03iVcsmYC2/7OtJ8g/VqX1tYafps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev; spf=pass smtp.mailfrom=c127.dev; dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b=pSUHe7qL; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=JPTE+ygz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=c127.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c127.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=c127.dev header.i=@c127.dev header.b="pSUHe7qL";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="JPTE+ygz"
DKIM-Signature: a=rsa-sha256; b=pSUHe7qL9M6cTkt/HKYb3eo5nQep5aPmRqx+xKIfyKoactwZMtXDM3J4Xw0wEZTUMKhYI04+TaEOCJ+QTyvJMKFpWHwR90M78mn9AqqPDuztPky73kW/d53ETqIcvhLkGop/vd+hTESAY68KmWXNFLDOLLa0tbDHfw4CKZrsi22PToL2Oii9w+OqReEUAmUODD716e9xd6pXHeoZPYHO5p7M5rCTjGlnGRU6FPFuTQVHg4zC50jJk7wZkVIBNWGoBPo9ghEvKFIN4EsUtLtvgBFZE6VS9tnnHFK2vaHLohZJJ+201F8aZ+MZqr3QS1YOivBjxFJ7e+uPLZbo5V+tPQ==; s=purelymail1; d=c127.dev; v=1; bh=bEuJl6tbZwwTV8fGbs7IcdzniD+J04Zd/HtTkYcb35c=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=JPTE+ygzkg1E+W5yILE+IuWPVnn595+I5i8x/RVe/uXOaInPVKPdTfA+woNA0mMC7UxyuMnBUGMZaCs+IW/L3cDHfAp/hPhiTjeO6IABDyXEJCE87OefZcfuW/X/GqBWyXS6YLCdxGSc50QmEoL0AMnvdE9idrCDej3d6o5m7vgaMHqkKqr6Vd6f7RfxK94504OZHMOMbesjsqbmOH9W9K74FjUrDqcCj+f3aOkSEd04ajkq0WZb5/XSW60gMOqJ78e+uqLEzwzv9kcJt+VYTjzAgYBdk01SX1etbutbOraJtgKQLJOmRAu24QPuUj42za3XkH+LKaZ8gwrYcuukgQ==; s=purelymail1; d=purelymail.com; v=1; bh=bEuJl6tbZwwTV8fGbs7IcdzniD+J04Zd/HtTkYcb35c=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1017243:43747:null:purelymail
X-Pm-Original-To: linux-spi@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -621174798;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 12 Sep 2026 00:05:21 +0000 (UTC)
From: Johan Alvarado <contact@c127.dev>
To: broonie@kernel.org,
	md.alam@oss.qualcomm.com
Cc: Johan Alvarado <contact@c127.dev>,
	sashiko-reviews@lists.linux.dev,
	j4g8y7@gmail.com,
	konradybcio@kernel.org,
	pengpeng@iscas.ac.cn,
	miquel.raynal@bootlin.com,
	quic_varada@quicinc.com,
	quic_srichara@quicinc.com,
	linux-spi@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: spi-qpic-snand: drop the redundant ECC context handling
Date: Fri, 11 Sep 2026 19:05:13 -0500
Message-ID: <20260912000516.653989-1-contact@c127.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911191010.990EE1F000FF@smtp.kernel.org>
References: <20260911184416.109790-1-contact@c127.dev> <20260911184416.109790-3-contact@c127.dev> <20260911191010.990EE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 11, 2026 at 07:10:10PM +0000, sashiko-bot@kernel.org wrote:
> Is this assumption accurate for all configurations?
> If the device tree specifies ON-DIE or software ECC (nand,ecc-engine =3D
> "on-die"), or if a non-NAND SPI memory device (like spi-nor) is attached =
to
> this controller, won't the host's init_ctx be bypassed?

The engine is selected by the nand-ecc-engine phandle, or by
nand-no-ecc-engine and nand-use-soft-ecc-engine; the core does not read a
nand,ecc-engine =3D "on-die" property. A chip node that phandles itself, or
that omits the property and takes the SPI-NAND default, does land on the
on-die engine, and qcom_spi_ecc_init_ctx_pipelined() is then never called.

That configuration has never worked. The page helpers are gated on
qspi->page_rw and qspi->oob_rw, which only
qcom_spi_ecc_prepare_io_req_pipelined() sets, so qcom_spi_read_page()
returns 0 with the buffer untouched while spi_mem_no_dirmap_read() reports
the full length as read. Removing the phandle on an IPQ5018 board confirms
it: the chip probes, then UBI reports "no valid UBI magic found inside
mtd15" and "failed to attach mtd13, error -22". A block erase there took
cfg0_raw and cfg1_raw from the zeroed scratch struct, which is a wrong
erase configuration rather than a working one. So this patch changes no
configuration that works today, and the three in-tree boards using this
controller all set nand-ecc-engine =3D <&qpic_nand>.

For spi-nor, the binding documents a spi-nand child only, and
qcom_spi_cmd_mapping() returns -EOPNOTSUPP for opcodes outside the
SPI-NAND set, RDSR 0x05 and SFDP 0x5A among them, so such a probe fails
before an mtd is registered.

A mismatched device tree should still not panic, and the silent read is
the worse half of it. Refusing page access and block erase in
qcom_spi_exec_op() while the context is NULL covers both. I have that
patch ready and will send it on top once this series is applied, so it
does not hold anything here up. It cannot go in qcom_spi_supports_op():
spinand_select_op_variant() uses that callback to choose the cache op
templates during detection, long before any ECC context exists, so
rejecting page operations there leaves no variant supported and the chip
fails to probe with "unknown raw ID".

Best regards,
Johan
