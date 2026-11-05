Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911101;
	b=nH8VHiIwsKH8uwkis9KHBFkVFYFKWine0c0KKaPvM60PqkTOZt670Qy2aa0A3UYyIHG9
	 QSf3HtB5K9nhEYijTIkMfHGd2633YJCLeVfxi/0/jlgqthZBPPg7Cuf9AvN6uxxYseDrT
	 TiVRrannXU/29NXR400nUThGeZOPnPxsU74vV3tznLXs/91ueZVRN7J3XVoHDB3usb0dS
	 MHRH1I5NYAMOlySaT1v2MyOc5Kmlq20a8Ww1mHtUOIZY1IslsPlxCy5vKHCnuUrAVkFwO
	 e+D0BJ/ueKcjbJFCXlWzXOt9w9ZQMV5NyK54+x7LZsaH4I5KU9gBS3qefy7ZrpMWAQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=N6S8HybbmBQD7ksOwNPFIV9dg/XgtnCtP4j4VV6tQZY=;
	b=4YriIkNTYNoB88pzjgJDr3RWDkDVPOhI3MAKiCPqxHjdczQfYKOfb795g0ZZhCNo4u29
	 Zm9UDeuKS0YP5bhliibOYhY/MF5JCXx6UmB/KR3LJairoBletIs1HqTG6r1Qx+q5nMw03
	 TSnXyUSQV4eFtzz0GOn9ZfHcJ3I58YKRQOPyw5kv71+z1AkT702dXulvGJKaBmyVgMgXA
	 0f/7KklILQ0SDSf8QlwicZG069D0aO563Qczx/H20K+tjwyRI/nIi+R8JIeUYSisU4CPG
	 KHuEsYv6LcTtUPxZNT3m4CsnkEhPVzKYys9gfKryzfKT95tH/vI5ghVsvCxZWYQrsjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAjnHiLN;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8584606D81B
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 20:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8584606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAjnHiLN
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b5669a5100so2848332a12.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911099; x=1794515899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N6S8HybbmBQD7ksOwNPFIV9dg/XgtnCtP4j4VV6tQZY=;
        b=oAjnHiLNl/jJ/BLax+ZQJIFgYN2/AH7dTV/8P1AdG4udr0g2rP7BE5JsAjsRLgwruA
         KW6LRstkZkvKfbtipjJQ++XfefKQYzAGBBsIUIC1xwe5OC9W5p4HxhhMvSmItkAT8JtJ
         QTqjj51ey/ojFLNd8jVa5SvtlaRCTbpagh1/1yW/X9OcY9pFXtG/JGlwYcvsNgLpAZlV
         LRWd6G2oUGZNzPl6cFUx86YajKKvF7y3xCrzNqm3lUz5rEATdH20xcc5IxoBJxYFWWxY
         mgOLz55m9eY1PJRPV9ZPzrz134QNju18CRSogEyRCicXFhFlZFp2yBpNPZvsiUYW15JS
         1QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911099; x=1794515899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6S8HybbmBQD7ksOwNPFIV9dg/XgtnCtP4j4VV6tQZY=;
        b=lV8L/a0bsIajQqKSMiXzOiK+iuo/rdZxqzdkUmLmeFPaO2Wkcgzy7sbnc1uEgSGVX+
         RofMKOIi6QZ52uzF5rA3qm4s2lElTbCgVzcB47Q2tqn106M8hipQrIyzr63uHwtSaHR7
         PmUbKLa8afN6OkpfJTZoO/tzIhXcpqb6uUag45QTJrYS76ARNhXCV8NLRC1E7F2Dl31Z
         Nj786vSg5txxjcWxhhfWWHO2hbLPYnam8X3PRkv3zE+Xc4ZnRkGfjTuhpHaCOf5c3MKs
         J6dZSCXp7KDZti4fwSDFqHDVkmhe0SxaLgshrW+l1XcPGjtIP+/qCjzdb7cxeYckHe2w
         aoqQ==
X-Gm-Message-State: APuU4Z+BFvMMHnRBaouoiPpKNf2alY9PWaGqM+BTxxWqZ1PNJRgl+T9I
	KgxZWj+YL4CM+7+rAXr7ag7JrrM0LIh1hwQkWnEEuJ/BpP8lz5aqN9rr
X-Gm-Gg: AYBFou1P8JPnRYioW3lfk1FkEdH2KgArpUVQXpC01Yu6qfHEvoYLmMW2hu2Am25rJ+8
	qmMpd5ndJaXsvSWbox9y2SetbKoiw9chcCnE15PSnJsCoD+vFJG6zRrzO/z5Op330OoY9S+Dj7V
	JdojUrKdFjcg2WQrttFpMFMoyyKBRyXi+MuEhzzHkgJ5qmDovroPSkpCXK0NmL11llm/1Njzh5W
	b+P2JPS1dwru22/l1Hkk+BhvBV9Prw8Ox3qB2uxA/COT74J/uBelaGyEtzpqeMb4HJN61FEaqfp
	J+aSC1mATqdPPuBzKazZdtXqDW9gLOXqDh2wbC2dKDtda6H4Z7eo/VDskpjt+TN1JxydD1q+1En
	nnjWFoNqpdjgyQUQEPk7Ua4skDCZeLCTP+wHUjzBaequv7VVMJ56/MriwmJ76F0XT7Ri+dtMbh/
	l4H9IUtMVN6lyAHeRdhJ4A+qAwH1hy6EY30rYFJpg3KDKWyBNkXQthjZ2SGTzR9xp2y1TAPN+F2
	m1vnYpIp4YrmPc2CbRf7QQfXTSABVYKMd/AW38KiPCLyKk5G88+pj2mvsoVUUi6eBYRH3sG9+yJ
	mgNF8DCUNXdi9YQOzO9UoS0R7QgJnDHFiNZ2DbcYJalx4yQJRFohqBBYU/IIsUH4pCxopjq/4yW
	2HVPIKgkfEC66fPTmx532ReslVH2hVcKaYZc/SESvdXvTPAGaOMUx0pLyqWAC0o2JpdiZEtGV4J
	pJbQrUNTwVMA/G9B60yPzA2OzkmsRjYhkoImWgUzJJ1EYdIKWDpBXdGWlrHwQ8cPRS1ro=
X-Received: by 2002:a05:6402:3808:b0:6b4:5d8c:95e2 with SMTP id 4fb4d7f45d1cf-6b597553644mr323041a12.4.1793911099046;
        Thu, 05 Nov 2026 12:38:19 -0800 (PST)
Received: from mb-HP-ZBook-Power-16-inch-G11-Mobile-Workstation-PC.dynamic.ziggo.nl (2001-1c00-1106-0900-938c-4ed8-a3bb-093f.cable.dynamic.v6.ziggo.nl. [2001:1c00:1106:900:938c:4ed8:a3bb:93f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b57feb668bsm886834a12.13.2026.11.05.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:38:18 -0800 (PST)
From: Mario Behn <mario.behn@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mario Behn <mario.behn@gmail.com>
Subject: [PATCH v1 0/2] spi: zynq-qspi: use a flash larger than 16 MiB
Date: Thu,  5 Nov 2026 21:37:32 +0100
Message-ID: <20261105203734.979168-1-mario.behn@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zynq-7000 QSPI controller sends at most 3 address bytes. spi-nor
needs 4-byte addresses for a flash larger than 16 MiB, so on a board
with a 32 MiB W25Q256 (the ADALM-PLUTO+ has one) the probe fails with
-EINVAL and no mtd device appears.

These two patches keep the flash in 3-byte mode and handle an operation
with a 4-byte address inside the controller driver, through the flash's
Extended Address Register (EAR): write enable, write EAR with
addr >> 24, the operation in its 3-byte form, then the EAR back to 0.
The EAR is 0 between operations, so a warm reset leaves the BootROM and
U-Boot in bank 0.

Patch 1 makes the flash readable (every other operation is refused).
Patch 2 adds program and erase, which need the write enable again after
the EAR write, a check of the bank register before the operation, and
waiting for the flash to be idle before the EAR is restored.

Tested on an ADALM-PLUTO+ (Zynq-7010, W25Q256, JEDEC id ef4019) with
v7.3 plus these patches:
 - the four partitions (mtd0 to mtd3, the last one 30 MiB and crossing
   the 16 MiB bank boundary) read back with the same md5 as on a vendor
   6.12 kernel that handles the 4-byte addresses in spi-nor;
 - the U-Boot environment in mtd1 is written with fw_setenv, survives a
   reboot and is read back;
 - one 64 KiB block in bank 1: erase, program a random pattern, read
   back (equal), restore;
 - 14 MiB (224 erase blocks) in bank 1: erase, program, read back
   (equal), restore; about 110 s each way;
 - a 26 MB firmware image written into the 30 MiB partition from the
   running system and verified byte for byte, after which the board
   boots from QSPI;
 - no driver error in the kernel log during any of it.

Not tested: other flash chips, boards with a flash on another chip
select, or the quad program path with a flash that is not a W25Q256.

Mario Behn (2):
  spi: zynq-qspi: read flash above 16 MiB via the extended address register
  spi: zynq-qspi: program and erase flash above 16 MiB via the EAR

 drivers/spi/spi-zynq-qspi.c | 1 file changed
