Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.10.52.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203094;
	b=VGdTpWVvlSo2eOFZNgoQkIfJNk6A5HTvy4xcqrK5ky1xxeGeUzKMhrTnZqs+qHQrYI54
	 ITtyoWMOsJRrTYyarcJRKOFmF9ox1LFu0Cp23FzZcBqEdgtN/6CM0elkCtZQhpyyTJ7y7
	 WULJNXNUbIuUhSdBaUXiE+/WJbN929t0CT5t0T9RKdkld9x2okW6bP2BO67ScsyjYpPHE
	 6hSj92wyMICXl5RzQXLhfd3jNcYl8yWqHZxUDFw9ZqoBpp/rtPbDgcKaphp2I8jRlBe78
	 RaBzKktmkBvVdGR3S+Sqd0q5q2j4w5xIKr0uhPpyzLAxqVWFJGKRKCKcQpOhSFwIzOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203094;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=X7E8HrpEX1g48UIcIi/75yDAhrUsrSkw8ZsnU9mUtTM=;
	b=5jnp/zUVbNdcwjdYodqjXu4PAVF1AV6yiI6TZBXlRFem4w7Qu7OebTfJQ0c7COpvgvcW
	 JTfgie0R3TiKqMCYJKvFtpmi/AJBfnvSgujnQD76mfHUUPLS4A+FUNdVwL1I6B4NfsneO
	 +S37Rvgtbi4bWXWXljNPIaPoiz+DMfffNhyGVeR4Nbku4MHQ81x+lcTw/3YHIjuyQkCma
	 kne/fLYmnWj/BM99Acv3CFrM6f9DpdcpHfalVezOZbyaciAcSEtm7r0ZeG92ywz+8g1Ni
	 r2fJfAEG7yCUAINw7FYeexwmggms6/SHg6gwHFdqb0oWSAhQymGTMikO82GEYktMpnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infineon.com;
	spf=pass smtp.mailfrom=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=WLjflKZA;
	arc=none smtp.remote-ip=217.10.52.105
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2D606A31C;
	Mon,  9 Nov 2026 05:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=WLjflKZA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1794203094; x=1825739094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X7E8HrpEX1g48UIcIi/75yDAhrUsrSkw8ZsnU9mUtTM=;
  b=WLjflKZAh5zhqi5V7MdalUG92aMHd0xYEzkU/8uEMEszeTfhhv5vMIIE
   hDxzKkAznaFVMDL2+Xie1a0Qnp1L4+Ny/Z6gnM1O5I5FnP1lAhrlNcILK
   elg8ODGAeXmqK5zqpbGhuQ4o+zJnnGAHIxzFIjf98ajytkb6AByPnQ1n0
   c=;
X-CSE-ConnectionGUID: t1eH6xMUTbmslgbO4DLpgg==
X-CSE-MsgGUID: dyR6V3G7QrySBqswGM3ARw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="169408831"
X-IronPort-AV: E=Sophos;i="6.27,203,1787004000"; 
   d="scan'208";a="169408831"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 06:44:46 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 06:44:45 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Mon, 9 Nov 2026 06:44:45 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <changhuang.liang@starfivetech.com>, <pratyush@kernel.org>,
	<mwalle@kernel.org>, <broonie@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: RE: [PATCH v2 5/5] mtd: spi-nor: macronix: Add 1-4-4 DTR read support
 for MX66L1G45G
Thread-Topic: [PATCH v2 5/5] mtd: spi-nor: macronix: Add 1-4-4 DTR read
 support for MX66L1G45G
Thread-Index: AQHdZtV4kyMcQUvb0kSyuhR/PPPjMrclP/Kw
Date: Mon, 9 Nov 2026 05:44:44 +0000
Message-ID: <fd16660e38f24049af5db47d726744d5@infineon.com>
References: <20261028121100.79667-1-changhuang.liang@starfivetech.com>
 <20261028121100.79667-6-changhuang.liang@starfivetech.com>
In-Reply-To: <20261028121100.79667-6-changhuang.liang@starfivetech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

> The MX66L1G45G supports the 1-4-4 DTR read mode. This flash uses 6
> dummy cycles by default in 1-4-4 DTR mode.
>=20
> For 1S-4D-4D, its support bit is located in the 21st DWORD of the
> BFPT table, while the dummy cycles are described in the 23rd DWORD.
> Unfortunately, the BFPT of this flash model currently only supports
> 16 DWORDs, and the kernel's SFDP parser does not derive any
> SNOR_HWCAPS_READ_1_4_4_DTR capability from the BFPT table.
>=20
> Therefore, implement late_init to initialize support for this opcode,
> configuring the read settings with the default 6 dummy cycles.
>=20
Since the 1S-4D-4D support and dummy cycles are expected to be in BFPT,
this fix should be done in post_bfpt.

> The SFDP of this part provides a 4BAIT table, which also advertises
> the 4-byte 1-4-4 DTR opcode (0xEE). SFDP parsing converts the read
> opcodes to their 4-byte variants and spi_nor_set_4byte_opcodes() is
> skipped later on, but the 1-4-4 DTR read is only added in late_init,
> after 4BAIT has been parsed, so it is not converted there. Select
> the 4-byte opcode directly in that case.
>=20
If 1S-4D-4D support is added in post_bfpt, conversion to 4-byte opcode
is done during 4BAIT table parse, right?

> Also set SPI_NOR_4B_OPCODES like MX66L51235F (0xc2 0x20 0x1a). The
> part supports the 4-byte opcode set, so if 4BAIT parsing does not
> complete, spi_nor_set_4byte_opcodes() still picks the 4-byte variants,
> including 0xEE for 1-4-4 DTR. With 4BAIT parsed, as on the tested
> part, the flag has no further effect.
>=20
> Add a dedicated fixup for the part (SNOR_ID 0xc2, 0x20, 0x1b) that
> keeps the existing QPP 4-byte post-SFDP fixup and additionally
> advertises the 1-4-4 DTR read capability in late_init.
>=20
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>=20

Thanks,
Takahiro

