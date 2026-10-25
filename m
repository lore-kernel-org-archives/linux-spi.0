Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792921856;
	b=kuqAER4/BQRcCWeJMnzSA+boNbb+pu5QxT7XMrUmFop446E8uoq+9tCg0z3I/7XJ/LVr
	 hvpj+zeq2renfuck523F9I8HzpIU30Rh1/dJA09AwNf4OqNom8fOnHy2tfjxV9tgmYBj7
	 NSvlCU4T3iz2vqHfPpZ8MYxxDvaeOS1cJRQr2p+wEF170ls2Eq8G/68wgoAOOacSDgIW5
	 3KPnyYyluWhaqMZcqcUawfWNYlVL23W2CCACR3NuJDALdIIU/bbIdBBMmJx2pyL/Ll+sm
	 rd0GrKeH82RIPBrRncB1Xgisc4Su7x8tJ+pwBsf4fwMwYizJdzwA1h32vkwRvFhqnVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792921856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZZ/dz/zvcgw6BMp5lO+qKEfF81xHiazGSYx2xRkXccw=;
	b=TLiGw3X3k1UcBYcyoizBYYGNzsJcr1/64IWEBcDcMe625ijfQci6mf2qorVArcKt6RTY
	 qyCUldXPww6HK9gq1FMLIw/bpmCSA2/0UVTtwmDmrUOa/NjevHVs9NwYDI7WbfPR0xQQR
	 qedL/qYX/xZshvf6IUc1aTusIaZvuUDSwTo8K5TdphY69Hv/XEad2zb3HKCz88JOlRl/7
	 vOWxehhYN2T4RS3RzWnw0MwAcDbXJ80O3H83Kz8YMAPQyBIcLr64mdcjXyiztoVi4UMv4
	 o2Fkj5GTqrwtoIdpGPO9Quu4swAxnPw9lzWqmgfFEuHhUuqeFbwDbdF0am/RuRMrLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DIoTUM7e;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EF606A31A
	for <linux-spi@vger.kernel.org>; Sun, 25 Oct 2026 09:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 789EF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DIoTUM7e
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so8542895e9.2
        for <linux-spi@vger.kernel.org>; Sun, 25 Oct 2026 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792921855; x=1793526655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ/dz/zvcgw6BMp5lO+qKEfF81xHiazGSYx2xRkXccw=;
        b=DIoTUM7eDXO2AZZf1D6mdll8m4itIZVK95/sqvPnwrofi/2rdiZ9jyNjHCvRfDA3tI
         HutJxHwAoVzRX0/QoMNaH4Xh0itQEzO027z7EIUK1b2a5Zuc3ElbU4rZ9cTDp3BW+jtK
         /kE/BxoaDqBPyau0aK+A5qEOJI5wq73/l1/L6nUtVdHr4VffcHAsePEMcWU7m0vHmTgj
         lRYk7Iqz4RWljYySgw1eCS4wDLFdiT08l5Ky3tmEsnQncKphC3VPEhIR5M2IvlOi/HHj
         phnEWNxk9296sA73yhdTP3phc6q8NjXjZ28qXMZsi4A6fL2ffLkEWuEkEuwkd4l9jZCW
         pDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792921855; x=1793526655;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ/dz/zvcgw6BMp5lO+qKEfF81xHiazGSYx2xRkXccw=;
        b=GrHXs5FiCrUZO2SjfBqYhq4FmFD1Fy2TLp/GZ7uCR6AI5JBG85WDgcUUKwmDQVU1dt
         L0z8nYc5F5ob5eCi+/xBh1m+1mnJo8yYBf12gBMjqmMvvPqIOyKCeMpyJWiURo1q7jXF
         2hblnqFnYE1DQHPD/5RytHCDJxL+miuBkfzycB3vRKgGxHuRDfUlkz32g+Q3Czv+/Fg0
         OROE/WomX3qiKmALZqXpP8xJuG/vi7GSd1IUX4urBU5vQ24CFLt/0TjGQssTBuzjUSUv
         77OmkB2oVlkzFDmAgl5PsdLEeOvRbLrqT9wE4cd7qpduwnf2TCL2+0zvyPUTVlou3RRe
         la0w==
X-Forwarded-Encrypted: i=1; AKwUvByVMSRUZPStTKOpOsrKvzjmu37cn4H7KHcaXkFtLqQE2cyggB21hidOckXqb3uVGnBa+lWtkerHt30=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3fmTQHzIWceXRQCmnCrBzS2J0iKqrf22rNLSUs1dAP+V/CNAs
	luY3BIjvQK5ynTVNEbQbfcwfd+IpaHS2GJ2aviOuQC/idl8/F+sK48Rc
X-Gm-Gg: AYBFou0ye+hVmA3nxeV7JQ0d+ftwgR/hqTJfce2JPIaWDKSzMq7vUBy8ubsdZT91dWi
	HxyvvSXAq56Buj1UsxjCa4ntFxBmO3r+w3AfZ0IvLxs5lkFGRIb1+EThDkdLswIwNr43NnwnxOd
	K+kdiAjzltqhUpE2dkhlYfOpPIOmpdDEbET/BnUqgqj22N1ERzSCbyYTqYQDCxQucU8/akGafqy
	2izCPWLUT1TQq+vHR6tKdHpALvp2j80kqqtet1lqOdMR4fL3Ke+ilZB+22O69LuOW95rEmYrCAY
	05e9f8DPsGhaGWiMhHtq6IQckr/TA2F/Tm5SbuBdHCIKYyLPhctopgr91asEdQPC0mPoUFeeBNm
	s1uv2aK8FDx9ql6gwhJhdLwaEAPaL6wCG5h7qPvkEjxdVybilGkB5AQoH0eqQQtoCzqN+tnvGli
	YcK9XENjrYack6RO9T0ijccWbgjogp7dv8WK0mdBeWk85ZyZZTnNqfBb67K8mzYleyfhim8Z/un
	OvsbBPm5IzIJb/ETr54otSKkDluT/VfyuaDctKuS8pTzrD04ojF+dUJG6LrXEY=
X-Received: by 2002:a05:600c:6212:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a35acdd912mr60693725e9.27.1792921854775;
        Sun, 25 Oct 2026 02:50:54 -0700 (PDT)
Received: from laptop.home ([2a01:cb1c:1280:4300:c4c5:93ba:d899:122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm9341433f8f.33.2026.10.25.02.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 02:50:54 -0700 (PDT)
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Rodon?= <jeremie.rodon@gmail.com>
To: broonie@kernel.org,
	rf@opensource.cirrus.com,
	david.rhodes@cirrus.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Rodon?= <jeremie.rodon@gmail.com>
Subject: [PATCH] spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54
Date: Sun, 25 Oct 2026 10:50:37 +0100
Message-ID: <20261025095037.18891-1-jeremie.rodon@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Dell XPS 13 DX13260 is also sold with SKU 0E54, which has the same
ACPI speaker ID layout as SKU 0E53: two pins in one GpioIo() while the
spk-id-gpios _DSD property references only the first. Without the quirk
the speaker ID is wrong (0), so there is no speaker audio and no amp
firmware is loaded.

Add a DMI entry for SKU 0E54 using the same handler.

Fixes: cad16d850e37 ("spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260")
Signed-off-by: Jérémie Rodon <jeremie.rodon@gmail.com>
---
 drivers/spi/spi-cs42l43.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index 6772abb483dd..46eeb44130dd 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -301,6 +301,14 @@ static const struct dmi_system_id cs42l43_spk_id_quirks[] = {
 		},
 		.driver_data = cs42l43_get_2bit_speaker_id_from_one_gpioio,
 	},
+	{
+		.ident = "Dell XPS 13 DX13260",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0E54"),
+		},
+		.driver_data = cs42l43_get_2bit_speaker_id_from_one_gpioio,
+	},
 	{ }
 };
 
-- 
2.56.0

