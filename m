Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794011610;
	b=riUf06Trr5CvGQQ5oYniSOZdKHy8htAiRnSyS7jo3GhM249yVfpEAZbA/d4i6RsQMFPC
	 q54glYjnJQ6pJCzOQqyr0lxCa3ptGzxeSjLP30g24OdNG8LVwb5jKjKlusjC+/jlZ2UtJ
	 cWK7SB/BQ/4fOW6f5zzneBvqqDNKYYR6+XHhZXgDGxzWeikbkZ9XMtAANDhe6TZU/b6RP
	 RM7ye425bHBE0e9hJ8KYHBGtX7QYkO8E9Rji/OOhI75Mi+nJD+CUOAGt7kWQqvQGURDCW
	 f3A7b3t5UYN3g/SCkwIVCphsZsnYzGdU1+9OwT7qOZN7T6N5on6N0D/kLVCfcog4PiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011610;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=E3RVJFr6ZUPogzBkgGP2loWx7cvpSKnyKS/nkizj98k=;
	b=5SUScd+Qt+Ics8VAG4Bw9yhvEoEY6ie4itHMkLTpaF0kb5w35zmIhzhEFYewWu4kGDgl
	 sgQ68Dfu4cgYHLa3gvbQK5tf1eiXd0i0ny6BwkyJlJTCbaVfyMtzp30e3jUOEhiMtH8+h
	 yFwCmg4ax4YHL4BF3URKMfG1ukAkONsKPmm6hEOxeDAA9SgxJiDgjmteRHJF/HVRkC5Ae
	 cKt9C1sI2Y0MGKFTB6XLrisjZ53+REsLDqcLJHkGeZQ9DBW2vghTLYQ5x+Wh5nKcj76zu
	 lkRyJ3X9EZ/4geGVUnEPL4WaRJ+BEUntTYLwyekpgDsa2oUiLFftCiE6xjoQJAHtObg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DLUHulDf;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE421606A32C
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 00:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE421606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DLUHulDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794011608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3RVJFr6ZUPogzBkgGP2loWx7cvpSKnyKS/nkizj98k=;
	b=DLUHulDfyFrvBVANQqOBJ/wUgMFzLm3iVeM59vY9AnV7VgFcF9U+wqEccrNgRfDxlo0W9S
	/EP4xzApRx21xkM6s/DXwzE2mG0uq5Ri3qylwZeNTvc0HLs++QS4mwXmkwexvAJEC+7pba
	cMFoSRTD6FLTB61Mn7zLAQJD0LBEMoY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-0oppzHqGOum117kiz4eayQ-1; Fri, 06 Nov 2026 19:33:25 -0500
X-MC-Unique: 0oppzHqGOum117kiz4eayQ-1
X-Mimecast-MFC-AGG-ID: 0oppzHqGOum117kiz4eayQ_1794011605
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so279991785a.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 16:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794011605; x=1794616405;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E3RVJFr6ZUPogzBkgGP2loWx7cvpSKnyKS/nkizj98k=;
        b=1NZjQrCPUGHnOuqug56V1Xy5K2BvGW6+XbVATkdXZE/gVhPHfq6y9o9ZQ8p+4gKM9l
         TOh7hIhl9ULqaZtkGxPgcYgpwhd1Y0n89wq2XyYEQTQr/09MB5IW9vBiwdbmo4pYgpm4
         krTZVmBVexQc3/CU4+0fD1gA5K/XN+vWPoq2oEtNfwgZF/GTbxvdLh+kv7zcDv0JwEyK
         0Zu0V/YqZbxVg6q3nYFCBGnVOb4K42i7pCs6G3zgtxZhH/nzYsQXlw9hEi7BwLEHK0dM
         xFyOPIVWDuNlraA7SwB8s27Y2ML6JwNHTmo2b9BTzk3HxPgHnKJJq2hDToVNz5dkh6g7
         b5iQ==
X-Gm-Message-State: APuU4Z/uU6QpBfMZFQZ+zimBG/8Yw/MnBjVfKzWbDmKiFrsR5dvPT/3x
	zhKjc6Z95nLDX9AQaGc0akP/0JJUdGniUy/1FW5ztRzAzZ9B/Vcc4dT13VJ8ugvGsNQbfRAelAq
	zjssSx4yKf6COXm/4Am+uCetAXqk06JM0Uot+QmY4FUulkUTEmPMNpsQfaV4fgg==
X-Gm-Gg: AYBFou3xOpvmdNN8ZZ8DINFnogRll7Ato0TDKX9N4PfYjmrDnRtnSFdAqonHMvIp1X+
	qKKwdyc5asD3Z1s14MJw2SJ1YuqdeH7pp+oZW3SAtVdLzKkuqz7msMdT3ycrrZsyXEs4Fx+dMCt
	oghC6z7ehFYgx5vAPY/EC+vPXmVTfkawdus0ljR90xXocfjPz1Y52S180gson/DK7RCXTB7rgG0
	wiXfkMnz/+QsSVgyzCnLQkqJlTjU15G1v1TYMTr0dLojsZWiMV5WuRamlPuyfQPQdHLPD3rNdpI
	PqUGo8xaAfZwzmEc9Pa8InO/i85SajXiDJhoM1Ld2Su0PyiWeoK/v4wmUdDmmEwqIpb/BOhLq5d
	fxovSZxB+uIfnOYj5F3E1ifxrwMf7zxkh56+yPymdqzamzPhuicjw9dYIF/5Pd3hdkpkc4jcK5g
	CSKmtPRZ0ICsg+CvU5
X-Received: by 2002:a05:620a:4541:b0:943:e135:525e with SMTP id af79cd13be357-945f35df6aemr679392585a.64.1794011605053;
        Fri, 06 Nov 2026 16:33:25 -0800 (PST)
X-Received: by 2002:a05:620a:4541:b0:943:e135:525e with SMTP id af79cd13be357-945f35df6aemr679386985a.64.1794011604452;
        Fri, 06 Nov 2026 16:33:24 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c5d9sm32684126d6.10.2026.11.06.16.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:33:23 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH 0/2] spi: convert to subsys_platform_driver()
Date: Fri, 06 Nov 2026 19:33:07 -0500
Message-Id: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4as0s9akLRpxFbEoBmNB00GIuLti+
 SXv/RcwBkKGUlwQcCemZY7QiYB2dPOAkrpoMMpYrZWV7Eny1vDJMjU6t64rVKZSiAcfsKfji1X
 177icsF3fAtz3A0/01BtuAAAA
X-Change-ID: 20261106-spi-subsys-32156ad80403
To: Mark Brown <broonie@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=714; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=cIQXJAsIsjkJ34lMdb75pVRHd+pc+H4nZCxj/MzmMlk=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLeFZ5qcOWcvczJwniSi3iPR8yiM3Uf8q/N3WDFesZar
 f6+qaNiRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABM5acHIsEUhtY+b/+OxZQKx
 76O+fbW+puK/avkau+k3A869usQrpMXwV36KfIX6uqAZTJHyU7sMI3qvfH511WPVr/fKLn4r6nn
 9+AE=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXfQVDqPKqlNopJDGXzIFyFGvXXnAKNfAAk1KvFhpOg_1794011605
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Reduce boilerplate code in these drivers and convert them over to use
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (2):
      spi: omap-uwire: convert to subsys_platform_driver()
      spi: pxa2xx: convert to subsys_platform_driver()

 drivers/spi/spi-omap-uwire.c      | 14 +-------------
 drivers/spi/spi-pxa2xx-platform.c | 14 ++------------
 2 files changed, 3 insertions(+), 25 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261106-spi-subsys-32156ad80403

Best regards,
--  
Brian Masney <bmasney@redhat.com>

