Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CC2F90E0
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207307; cv=none; b=ehJZ79kBhmCQSo2sRzbz+LWOlY0mC91Sdq4zzsaN3IzZdldSEa9ib7ABFkkMhNhs0dPo8o+q5nfmyL5EeSeuCTRT/SjIcySu5XUsfSyUCEA3YgrEiFr8G4zSSr71+d/hypp9iu0KlYNVtavtrVVZi9K3l/MohstPfVz3c8V6SIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207307; c=relaxed/simple;
	bh=C+g+lR7bpcxvSDJYIe+z6TtaFMoj5qY2QlBV1qd+Ja8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApVb6N51MkNmC5W7h4QnxYLhN6ZW8IgcMlkzSG3wI71Rr5/iIHmwyBJM+ulEFMGyU3aqsleSWysYbcIB6y2alItuORAS3z0rN9GO2oR4YAgDlOuw45xk1oQYO4fxc9Sb0Qdc9ZGTa4JV1NISTc58wD/VVOtWfDQyvniII1qdxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=iuKmbCru; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="iuKmbCru"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485b358552so3546010b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 19:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1785207305; x=1785812105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=niFsg6H2YP1ZTl1KmNDyWGnsSe0oicHRx+diETwQw5o=;
        b=iuKmbCruJu8iSldc1aqo3Pd5xqYyu5mW9FljKhaSnRjDATaL1C79J/WRLTpJs5bZ92
         BsazXNxYBch2HP5k4B2yYqCxL44eoivA7mc6rOAz/kkKYoyQE6E34ZTUfERVP4ahX/f5
         wSa8CneIIvGp1klss99dD1niHxzwhhU9nIlSqZQap8zUkRICX3Kdkfbi3aRPJORwZBkU
         uiSBeT6QaLV2Rn1zs8e7EaQdYc6V9+vDHM7/NRhTrA4FltcS4WU/CwZ3+eD2zFuhW0Nq
         Fv4Xqg40vxNZxht6ntG2LGkXrFiJflS5oSjzKZa0S1QOwH6CxYujnvVKO/b499cktNzu
         m3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785207305; x=1785812105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=niFsg6H2YP1ZTl1KmNDyWGnsSe0oicHRx+diETwQw5o=;
        b=XsjtYtNlpeEYRq8mWRi4FUSOuKgPMSOGlBWY0oo4zJZiWKYCZ0cmXileKZrjr6eZM+
         07MuVH4q4s2ICkIyjoFrN8i3ZdEPL1raBwq2QGCkLvc+HmsCd9w/Ileq0TdIXYgPxpEt
         DpxmfUXNiEkRO71gD/zeZdOBBwgmVI31I4+ugqDO7VKR4zYY7y7Pn2GWiD374QjNM+db
         OTN+4Yy2kreqSJgIWILQow2fvaj5IA0ToyNZHbb6/hnENusbcA6TSa1r10zIFKUxLxf1
         pw3hKXCP5Q3lUYkkPM2FsfefiyXrLYGMvEIbk2ZePOcarTP5MQ6XM5TP1mMnOLoosNYX
         1DaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3MFajB4V7bApevc9kx8Eumq9FxCLHf0qsWjzAAQI0W5S/BBKXNp4GriY2T0W45lzrZf+LRIZVSkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10LlknSbFrz76g6MvZhoAwSCW+e589kGZ5RbB8HuvIcfZmz2J
	D/XQoAx0BPOGNlDPrLlwWI4OTTQ7dBhak2rce9KmmNKfhPHgHdgRvlnIt03OAFgxG4UkckuCyvy
	wL2I/8YuzbA==
X-Gm-Gg: AR+sD11ktKQKDEL/JeVbcRe9HFZDdg2GI3Kod3Anfp+Ub549ta/2ORNE01FoD8xTilX
	G4tNtczzzivm+pIUBgKkxEvW6NE8aSLiQdEdDDzHxGyebmzx2615PWVwePg4ld6wQX3et+H4Udh
	7vlQAqJr6nkyZkfWdJw4xeIhe3H3id9psQ2szBiZx4nckcdIbjKS/Ok1SXf7TigCtOAQImuLGtq
	iUSOwmKu8f6EzQXT16qu/n5HM8s0r2Q2xtjdk6lWRANg1N2yopXBedd9Xrfbb51URFBGx1BDlcE
	JpwsEXciGu5zNkWFi7PDr4dimNW+168Lgm6K5Xcyd+je72RzbDa8tyRHeJHy79vZZSmGdP5db3I
	AyV6azJIb6AgO6A/5+TqCY/OhdwM3oDBYYBI66pUypIfjfmof0oUW971MtZoXUWonUDlpzYi2L+
	dw4Co+/IBoox33IgWnWTk+z8/L4GWm1OOZU9J32a9up4OXPPGHuW8=
X-Received: by 2002:a05:6a20:c90a:b0:3bf:6f30:1ccd with SMTP id adf61e73a8af0-3c8ba546272mr690898637.42.1785207305412;
        Mon, 27 Jul 2026 19:55:05 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:68c8:458c:c1f7:4115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm37156981eec.10.2026.07.27.19.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 19:55:05 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Jon Hunter <jonathanh@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: tegra114: initialize native chip selects inactive
Date: Mon, 27 Jul 2026 19:53:08 -0700
Message-ID: <20260728025503.162543-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
References: <20260725042944.1204409-1-abe@maticrobots.com> <b2a3d65c-d3ef-499d-b56a-82018804f4d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 27/07/2026 13:07, Jon Hunter wrote:
> What about the case where the SPI devices CS is active high or a
> mixture of the two?

An all-active-high bus is the case the window gets right today: probe
writes zero to the field, so an active-high CS idles deasserted and an
active-low one sits asserted. This patch inverts that. No single
constant covers a mixed board - one polarity or the other is asserted
until tegra_spi_setup() runs for that device - so the question is
which default is the right one, and active low is what the SPI core
assumes when a device says nothing.

Setting that default in probe and correcting it per device later is an
established model for controllers with a programmable CS idle level.
f9c6ef6cfe9c ("spi/xilinx: Support for spi mode CS_HIGH") added both
halves at once, to a driver that does advertise SPI_CS_HIGH:
xilinx_spi_probe() sets cs_inactive to all ones, and
xilinx_spi_setup_transfer() clears the bit for an SPI_CS_HIGH device.
The changelog gives the rationale:

  The core controls the chip select lines individually.

  By default, all the lines are consider active_low. After
  spi_setup_transfer, it has its real value.

tegra_qspi_probe() ends up in the same state by another route:
def_command1_reg = QSPI_M_S | QSPI_CS_SW_HW | QSPI_CS_SW_VAL drives
the line high in software CS mode, so its native chip select idles
deasserted before setup runs, even though its CS_POL_INACTIVE bits are
zero like ours. That is a single line on Tegra234, where cs_count is
1, so it never meets the multi-CS case, but the idle level it picks is
the active-low one.

Others leave the reset polarity alone rather than overwrite it -
sifive_spi_probe() saves and restores CSDEF, bcm63xx_hsspi_probe()
reads GLOBAL_CTRL_CS_POLARITY back into bs->cs_polarity.
tegra_spi_probe() does neither: it writes the field, and writes zeros.
The Tegra234 TRM documents all CS_POL_INACTIVE bits as one after
reset, which is the inactive level for an active-low device, so probe
is discarding a value that suits the common case for one that does
not.

Thanks,
Abe
