Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D81E5724
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917354; cv=none; b=C6qilztJD+fhpYKj7tcI5JiKYyoZc0HV3C9Aa3wd+xnRigYos/qMzHotBWb6U1wIvZyalguhWFRdv0ltstw/JJRsJcnyJTXRqq52QllR4pmezHq5V3sgfwXlu/Yteo/72BTDJUDgHZPAomDFJ+CMyAqy3MrhDLVeLD0U7d4ekMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917354; c=relaxed/simple;
	bh=wnvFaFSfPUHo5q23p4OvlwaDUECNLrAx79wkpH1U0R4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WsHDIBsmaSS7UWkkDetACukj0kTWsVLrvDJJbI9yMLUl7h7t9xgUTSsPuE/LtmxqdOiIpg/PvDk34NCDz2eXCpx+mUKai1Nh9JWbIf63g2c52lsXmkDI9RYT20hsAjOsH287dKbZanhAmdxz1GbVAEcWdUD90DGHUNNMaY9JcwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zm3qTb1d; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zm3qTb1d"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-394f4397662so175479a91.1
        for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786917353; x=1787522153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B1WpV1mK/ZfAGKlbOl9xD+Zq1+n16HpY+NcEojw2DPk=;
        b=Zm3qTb1dkGSfrrhTqbzTirQhAuZLPO2Sq0O/Netq6Ip1fWNQgufH6RzMaC3o/Nwual
         Nm6o1KSlj1HCXaAYcObROsSk20toOGYVyh2iCKiweYhD84ZkkGdlIfA0fRufJhTG9d1i
         NETyi6Tkf3az8ryo1jxKVyGd0YLgXVpPmoJnxJFZKqSwT60Gq5OpRGCsq6kfhdhtsXeK
         ILO22AczmQ9txXQgZv+fevlneVfjQ7CCv5coVj3mn5M1KBkE6dAa1wSkgYBUeeS3SeQd
         TU1RLvQL8vh7sCVo8/ARsQOcKntAh+SjBo4WfJIgHJgQSAmIVcCWa3efdmHqeWhIG75s
         jmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786917353; x=1787522153;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B1WpV1mK/ZfAGKlbOl9xD+Zq1+n16HpY+NcEojw2DPk=;
        b=HuoXw/IIhmxz5o3Hyk2lnMbphh2LMSKLFtzEPG0AqGFfwpt9p/6rT277G4sO8XaK/d
         pOFkKbsnXWVHHOev+K1PvuvFSj/JtDYU7mDYAsiyQBMR7gs+5PNrCwnsXjUEKZMfCzw/
         Xn3uX/o9lZfMaC+9dwezLSDW0QoIStv6Bk1KCEnuUCDE9W8IwsSkM9J+tUQ1WP441oSh
         Rot0YhOK/tUj1mqRX8nkGjOvw0tItWLY9Z+3q4CaPGyZiNNrrlswqvfzQeo2CtTIKzBs
         Nvx1ATUMsE86PLxHFo/f7F9Npu4FKUnm3n0vkpr6q+RrVFYHZ36miPJLKqt/06wfJPFh
         eF/A==
X-Gm-Message-State: AOJu0YyaA3g/VMsoD2uWt6NMgsMLEtXNO+VR6o1AhAd1+7zcAueE32LA
	1SkASk/VAyDkMzW+OIvIq/4hMf8qRWC7+C+BG8Fs2VK0wfbWoBo+Z5cR
X-Gm-Gg: AR+sD103wirQXIcviJkb9Li4JrBdNXhQB8saj9WJtVsOKRieEIe4j3plMZxgWZLufzl
	y/uoDR18L4WQ/+Ip/YgDR7psrwZw/owVFHotDY0pGmary35qSTa0wb1Z4TKfrgRAn9h2d+uXJAu
	74DihH7MMxqKiFIk1OtTXLL29971RpU66LXYnPMa/nQUH5WZU1j2RZcWj257XoBYJs+0SeqJ5P7
	dhXxoGOH49ashpmcBsid5ny5qJa2cVQ8vMboulKspXJr2DgKp8JjF9VkwRBecX95tpFPS9vNz5C
	HRp8SNl+1/IeoczJI0errRUAH7NWJSiaFDHN+6cFI2mpLjfxtaCkkPIjtjOFfeMFvF07uUMlYeP
	icHDJfvgZqfnb/Iwymq5e4h7h5C20rczVSzMqDj6/xkJ0z5R7LRss9P7RQv0BteykSikRuIsilq
	ue4m71kwli/wv/Pr/XdKOvwVEg+LKm/cltEnijXX4IDWlvpPkwN3ruRWLq1gMm6YBtk9i83AgSa
	w==
X-Received: by 2002:a17:902:c944:b0:2c9:e846:a582 with SMTP id d9443c01a7336-2d3b04fdcb2mr164306085ad.0.1786917352596;
        Sun, 16 Aug 2026 14:55:52 -0700 (PDT)
Received: from [10.112.173.252] ([2409:40c2:504e:1c5e:cbdf:b953:2369:869e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d60eb8eesm30168318eec.10.2026.08.16.14.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 14:55:52 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v3 0/2] spi: davinci: Convert bindings to DT schema and
 clean up DTS
Date: Mon, 17 Aug 2026 03:25:24 +0530
Message-Id: <20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Myw6CMBBFf4V0bQ0dYSCu/A/joo8pTCKPtKTRE
 P7dwsqN5q7OTc5ZRaTAFMW1WEWgxJGnMcPlVAjb67EjyS6zgBKwbBXKhaXTiUfLMs4sCSvKaw0
 aFFmaA3l+HcH7I3PPcZnC++gntb8/U0nJUurG143zrgaEWzdofp7tNIg9leC/DllHi75WjaoAz
 Le+bdsHebSGPusAAAA=
X-Change-ID: 20260816-ti-davinci-spi-e64e4e48b6b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786917340; l=1857;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=wnvFaFSfPUHo5q23p4OvlwaDUECNLrAx79wkpH1U0R4=;
 b=oDGmhQUVyB+xUum7xYfs20IrjfgZaGulpadBS1m4rxfHPkdNrIypL0etLP+GhRaE/1kbq52+W
 kskeKebO4qwAsGUdkeYMD0LT0v+7X4qpKYHUOo9CuNVWeu+IeVp3qUV
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI DaVinci/Keystone SPI controller device tree
bindings from the legacy text format to DT schema. 

- Patch 1 renames property ti,davinci-spi-num-cs from keystone-k2l.dtsi,
  as the driver uses the standard num-cs property.
- Patch 2 Converts ti,davinci-spi from text to DT schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v3:
- patch 2: since old text binding required num-cs, #address-cells, and
  #size-cells mark them as required
- patch 2: davinci-spi don't work as spi-slave i.e address-cells 0 is
  not applicable and spi-controller permits both 0 and 1 so explicitely
  define #address-cells as 1
- Link to v2: https://lore.kernel.org/r/20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com

Changes in v2:

- patch 1: Instead of deleting ti,davinci-spi-num-cs, renamed it to
  num-cs to properly preserve the hardware's intended chip select
  limits 
- patch 2: Removed  maximum: 6 constraint from num-cs.
- patch 2: Add standalone support for ti,dm6441-spi in compatibles.
- Link to v1: https://lore.kernel.org/r/20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com

---
Bhargav Joshi (2):
      ARM: dts: ti: keystone-k2l: Rename ti,davinci-spi-num-cs to num-cs
      dt-bindings: spi: ti,davinci-spi: convert to DT schema

 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 124 +++++++++++++++++++++
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi    |   6 +-
 5 files changed, 153 insertions(+), 103 deletions(-)
---
base-commit: 3eb40771c00a8488fa6ed2cc1fe203477908bf38
change-id: 20260816-ti-davinci-spi-e64e4e48b6b6

Best regards,
-- 
Bhargav

