Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB13DC4B3
	for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865644; cv=none; b=T9coPEhFnWufRFRKTdRDIpz6gy9JexEKoWrx49mn9KxRoqDiB3XIs0LRFizCBCdjOOIM7nSaB0rInk/5268cgTPJGzBIPIwxCK3dbmtcfY/OJFOgpTKC1etBXEyX/Cds6D89RiMAB5jpdh4RyX5mRxq85ElNBaqMEIHNKIEM4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865644; c=relaxed/simple;
	bh=yyFqC5fjhtxJHgvm3Qd9hub47GraUTHFaKnluUyATxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZP9PXU1lcxaC0ls183VMsJGcOdnwVynE1v7A8MvXnulxDE2q5gZRNZXFKqlDEi75G+nbFxRiE2raUm+n+0p6/escrH8HH49luViWn9dqt8gbYuSKadg8UR/yQWXNXUXgO4qQggWHYovzg259FU+AQmkqmKidwczdEnQp0MAQVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF5UrVTF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF5UrVTF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba1e9d3687so694095ad.3
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778865641; x=1779470441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoxGcLe85XsNfpKh6H9xgfEXuYoK1H+GNjoDAQ/eXZg=;
        b=lF5UrVTFe9RxD2Dk/AhBZ7l1e5BybaGJW7RE6edqJ2ZQHq7iRQLpxP7rLISTiD93ab
         X/nMevwxAtjxfIy5by/FeYJw9bDdKJ2Vu6YG5796NWh+zye+CaSAZh/Ve5mY9ibzXigT
         a/pt3BKeF2vgD2z4IenQyoK+2gxlsuUs18gx5Jq6/Td0qjXHbjfKRpJU4ygCCvi8m6Cm
         LLV4Kb0aBS5839Odd3WqZLp+VAWHcMLk6epsS8iBk1cHcpvq5qIAi6/WvNvJdkXqa3FF
         mjPTvrZQyF4XeuWQ11JUSlMLFM/3pqiQ1ikWxaswJ/rSDaHAR/Z2BQKAzka6CEY2/upz
         G5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865641; x=1779470441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoxGcLe85XsNfpKh6H9xgfEXuYoK1H+GNjoDAQ/eXZg=;
        b=EsxWbDJoP3v9MqsVSiAl3kH9o03zTllx2R4pv5uWj8HhC1sNwaxdq26TxwLgaPT/Nh
         euiXvZQwvwgrg6iBbG8HzBSNe4KLVleayeMEAUIaPppw9940EL46BIQmFYbj52ZvLqfG
         gTEsXb4MR8Ff3FYwL8eEqbXY1A/m3aVm9QpOVDDfeLm6bciAtToQbN7Rt9ML3Go+JfbE
         fJ+Tvytw5VHfzHJgyplk1MDnRynKajCLbBpHA4e6U5xgy7ElwgwBKjbOvc6BENpzNqxZ
         JMIyWXpipcGZYXujgRVIWIAyU7ojF9vHqYGP2T4oUyspHH68FFhuHLVqylJl4bZN2slK
         eXUA==
X-Gm-Message-State: AOJu0YzMpqmA71RQ0qDZq4bKA4Dz7NIvlE9ubx5/JEjey3O3ZBoAUSVV
	bI/DdxqcENt3ayzEFV32DlddFlwfqZkmlnsGeCyoavxhh9eXdeo1oMZRPWjsWHLW
X-Gm-Gg: Acq92OEMCFvLfj7nvqly6WaEP9P2AIzVhr9GndIs9RuLFXoRpVboF7IVcklS4IhpaUG
	hhwMPBsIzbk2GmOEPK/xK+0fA5US0A4wsbs+R/ZMq7oKt4p+ymDo3gBzJYJtGAG6QJ7ukgmbtHF
	UWfbTQ/2aOs3U2YJDwESqfYIEbslJrD1vnW3R+mvvUfDHjnOf4hs9r3SyxbKk1ZwgGl2kRiae4V
	UuOgod7wI8QZDTLpJ1+Pw1ffF96zqhQdrbVmSQavGbxZtj+e+CeDneRgK7SYwVqcpLmyXqbaMwD
	XFykGt7N3HM9jGQUYrguwx9sI6MmcX2AeL+CCaVJIGrJqvMel8183+0D9aU+UPHN4Z0UuNmWMjo
	cqXVnzpK+K2/jmKOafVFyPcAWn7NXWI/D3ZGHgtKAEq+DDBGCTZARVRPDnsRrfH8QORkMh59L96
	Yh1B6UOaBqWx28WqmDPn67WbfAwCismtzDlB5KmAJ4vn9NFEcJPP1sjMbfqWfHRxCR1xaTv6xzG
	6x6yrUfzckhehb37KM=
X-Received: by 2002:a17:902:7887:b0:2b2:eaec:c810 with SMTP id d9443c01a7336-2bd7e7e38fcmr39332825ad.8.1778865641072;
        Fri, 15 May 2026 10:20:41 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600c3sm63151085ad.29.2026.05.15.10.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:20:40 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] spi: atmel: two fixes
Date: Sat, 16 May 2026 01:20:33 +0800
Message-Id: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBVB2oC/yXM0QpAMBjF8VfRd221KVNeRS7MDj4x2pCSdzdc/
 up/zkUBnhGoTC7yODjw4iJUmlA7NK6HYBtNmcy0zJUWzTZjEtpqI1UuYQpQbFePjs/vp6p/h92
 MaLd3TPf9AP2zi9NpAAAA
X-Change-ID: 20260516-atmel-6d6b0150eb7e
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu.pirea@microchip.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778865636; l=485;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=yyFqC5fjhtxJHgvm3Qd9hub47GraUTHFaKnluUyATxg=;
 b=/+Xe6ab4myY19CHxfPm2ezkPuWNFZ0n8NbsjPFDkm5IlFrV58WdjcYRtTaKWaXl2L/IOHAFPd
 p63hSnr+S9rAklbg6I5z2jhxR8lzCsVqjWgkFkG5n6jEAQBJYMyPT1C
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      spi: atmel: fix resource leak on DMA buffer allocation failure
      spi: atmel: fix DMA resource leak on probe error paths

 drivers/spi/spi-atmel.c | 129 ++++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 64 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260516-atmel-6d6b0150eb7e

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

