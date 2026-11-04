Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793768246;
	b=MfqDNiOSQANRKMxY2vyFUZ5iggkUOIuz2q0EIRfX23E2GRVEN3AOm8Fk6sqiGB9v0S8x
	 ju5xAj3rYxGvGS++MQtytc9dJ1yhA9E5nYw4OuBgE4z2huGQ45oWzbNFFpexf38MYidqj
	 rF5/RIEnaTWsByTUvaibVFDqTN8g47/DsFsP8JGsg6Un1ly1BlaSNMyNb8Q+9LEh/0A7X
	 qvtBptKC2aeda4iU3PUrH3FH5kOgOX5QDkr3fEDKpQZp27VJQ/eLKycJQNA/H9PlRETSU
	 Ef6EIfp2UG39VVD+DuKBzYEV1FAQ0FzHTS9PHZfCcUaF08xg5oJpSx2ULR1McnzpC9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=oSQWRaHuT9P3jPPbUAbS1V5b/cTlk91uVXvr0QmSpEM=;
	b=kP5+49rSGY2M0Q/hWYsB1+hW+VBmDecHRMNWGUs6gi7OE8Gv/I67A+o4RgiDZuP4BiIQ
	 xOXJi/TDH+f1WIhjoX+XF9ShcC4iTiYOll+oInwjNDXcNB9053kdXoZZkDmlaJ+LSsipd
	 dbTp/Tj5FgOrNEb8lBljW0jGQZJlj++BqoIKuWtDnLk1UFtwmeOOeZc1HVMcwJKY6ycNc
	 hhEd9Pj5wJsONjAblHr2wjnB86hf1/UvkxTabergE4jfu063tY9q2BYTA9QeReDtUwxMc
	 mTrrlw7mgmI4SIbCqlLPL83g/ubIJMM1Zjr2CNcMzjlRO8eF67v4NWVA1f9hgbqLwVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mf7yzasZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C4606A31B
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 04:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 421C4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mf7yzasZ
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070755c8cso177268b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 20:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793768245; cv=none;
        d=google.com; s=arc-20260327;
        b=lXD9tPib3/zk/PMJzo/DOdoogFSdEf0uQX3bzmx50iJ4qBE+Vf8chtsVBPj1MQW0AZ
         DUKAPKwhYtbo+n0uIHHHf0+2ewnLmtxM7g5B7ZBWnfPYPLlJM8o24hGWVot6p+KZVf//
         68WI8L0+E+E0b+vemgn8RNr0NSbV9HJ2zdVIBstE3Sr9iFL9SpWI3EjtOBxLMckDbjzP
         HNwOkksYWQuhoXUOvPqsQRjkFxhwVq/FnHefI+pF0L65wmlOp7Ywe8v/KbUFT2C3sr+D
         s6cf4X5DuT0E4huyGBpGDwlLawmjyFOO2s90LPH2XyFRvzvQRuaafbtKOGC36VDpO60R
         tO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oSQWRaHuT9P3jPPbUAbS1V5b/cTlk91uVXvr0QmSpEM=;
        fh=PaI/noymJnvcLszgp1vBZpd9ZkqAAiLo2cR7cOLCUKA=;
        b=NdUPPEUYWup1VNbX6TlY0+3klwFD7eMQLCl6cfSkrNQUTBnwntOZCeAh/dxHUyCWB6
         E8s9hf4N3aLvJC2MrfxnqqbRCwZekBKZrDzG2OWwGWXfb8DsKcmDuXnIWgDeXJDwzeuE
         J15aVkOSUfk0Vda6Wcoi8CR63dhkcA7rMGwvWpaSIw/SUaJ6luKWEZlOWZoNN51WODa6
         VZ0NNdesWhc8/gVz8AaVKw1SMDO3mVpO6AiJiGzepKhFHK/0pFcxnF6LCsvnBakAaMpI
         D42UJYUuRpyDYeq2x8LxsFMb2bU5+YfsHHXhOGWt8hzU0qLTIgheUzv+kTdRLcXLKw4D
         r0Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793768245; x=1794373045; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSQWRaHuT9P3jPPbUAbS1V5b/cTlk91uVXvr0QmSpEM=;
        b=mf7yzasZQZ0QcK2Pz7Q4re3BDFWEdVUySDWbvmDqRUuJ8F9t+drd+JXZc8S6QBl3vS
         RfTnoJ023pYWHTR+f7j5HUbh3lpEgDVQr/2zkP0S6H0LCMjhjZsPY5OjTuJExCF0cJ6q
         Nb5e8EUSp8erOOsEoNt7HuSxXYFuKgobpFLVYHR1r5PEm9MQUgdoku0WK1oNPNOXTQ3X
         5ao8woIZhNyZ5QmmNG1BJmBBaQ2akRuaWVx7nvSBNoEdeph17qZqTMC/sEzz/yGanWKs
         Nrp9g9YoXNNYIOC07ZnZL//tiyDFcSyF4vGXTT3bHXsE8rm7JmxXg1heWt/dOvx0YYaD
         RYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793768245; x=1794373045;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oSQWRaHuT9P3jPPbUAbS1V5b/cTlk91uVXvr0QmSpEM=;
        b=d67AAy7u173Rqc+hBOKXFHbXSWVB4FrPmoPNre0Z6FXtZQ3cGB+EjCpmRjjqq7rL2A
         ReOjkZ6YBEeDZH5eZiioFoOPjBvrQE6suhB79R1VzbDjR4Gin9KVcdBykPeKO1ABREfT
         1OtSu7ji3Prgbj/RFvhqhgGzIo3P2c6mkWAnFfnVxULnts68pvyQiLueT6Rx00YIZhR/
         QnrvtMTlGzZuxkGkGrM3XAslG4Ac1xV7u2ezQivpPlvEh0hWSwFnVOtfiev1VVKI0R/k
         CA7OuI/AmkCw3qgAvj3KKsL2RJuwxO6eeRyildvUZyAAaDxoOsfN9XJ/eGb5UyPBrX07
         tprw==
X-Gm-Message-State: APuU4Z+AjZ40M8DNh/cycRfToqmTzKCH9SG3BrDYOOUjovXVnuQnFqE6
	YsBxyJszhM7wcFfCBvdimlm201v9bXyJKgaig0W1dipVM9Lm0bH1NW/T5a56sE/OOOTKekku0kh
	nT97b5DzbElOINmr3IMa9nDsFUIfN/5LMYoUdd7ty6Q==
X-Gm-Gg: AYBFou3KiRUmxrp+NDKDK59KaeaaUPeSrk10Ce4Kmh706y5o3hGq7ZbSCMjiuvrO3G0
	6aBM4eRqjLVGs+0PxyWXCKYqRY3CvZmIWwSFSpFCL0gG4NyBvC9nLVJazXnfv6Hk1P7U2q+p0px
	xks+vPbrCnMnWCh2SEzPkiHcDaipQRTnbM/+bXz7s7h2LQI6Af9HysZyWP2NHaLVdNSw4TYA5To
	DpE4mCdG5wdobeyLrdsIL1ABNbiWMcaCvtZume4/5xWSiu2RINz1ihfUsKliPg7+brKS5mGvCz+
	9WKYB/GY6n34PgO+DOxNACZqsgBF+Fy4YICBkGg1yRbXM4LVth2F8pfj54rN5s1VXl2JpYTwsJg
	6UQRQ7diH2FsNUy1hVD33qxJHzCNEKaOXpsOj1TJ4Ia1bytPexQFiLl7YQ1wW6fIRC+7Q
X-Received: by 2002:a05:6a00:a909:b0:878:3538:8f7e with SMTP id
 d2e1a72fcca58-8a9bffd147emr12603280b3a.44.1793768245422; Tue, 03 Nov 2026
 20:57:25 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: zhang san <shunsheng1218@gmail.com>
Date: Wed, 4 Nov 2026 12:57:12 +0800
X-Gm-Features: AclHuK_9sX6apGpL7I3jhbMpE7I-fnGbe34tz6B2DEkf1dEoT8V9eyumRzrqBaU
Message-ID: <CAGTEBTY2EhOHwmWhB0_YdnP-nMyGzzhnwH+ta9yeynHD-Y0JyQ@mail.gmail.com>
Subject: [RFC] spi: handling a stuck queue worker during controller unregister
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We would appreciate guidance on the cleanup policy when the SPI queue
worker does not stop during controller unregister.

If spi_stop_queue() times out, spi_destroy_queue() may return without
destroying the worker. Our reading of the subsequent
spi_unregister_controller() cleanup path suggests that the controller
and child spi_device objects can be released while a stuck
__spi_pump_messages() operation still accesses them.

Using a synthetic SPI controller whose transfer_one() stalls beyond
the queue-stop timeout, we reproduced 80 KASAN use-after-free reports
on Linux v7.4-rc1 (6628e7d4c6b2). We explored three approaches:

A. Keep an additional reference to the controller while allowing
normal cleanup. This left 16 KASAN reports, involving released child
spi_device state.
B. Preserve the controller and child-device tree on queue teardown
failure. This removed the observed KASAN reports but leaves
substantial resources registered and allocated.
C. Preserve the child devices while continuing some controller-level
unregister operations. This is a design option that has not been
implemented or tested.

We do not propose approach B as a ready-to-merge fix: keeping the
entire registered tree can have unacceptable resource and visibility
consequences. Nor do we have evidence yet that approach C is correct.

Would it be preferable to ensure per-message ownership of the
controller and child device until the pump has definitely terminated,
or is there a safer failure policy already used elsewhere in the SPI
core?

We can provide the prototype diffs, KASAN traces, and test setup
privately. The experiments used a synthetic controller, so hardware
equivalence remains to be established.

If a patch is proposed, please CC me so I can run our KASAN reproducer
against that exact revision and offer a Tested-by tag after a
successful test. If the reported lifetime issue or a concrete design
suggestion informs a later fix, please feel free to reference this
thread in the commit message for attribution and review history.

This analysis originated from an AI-assisted audit and was reviewed
and tested by us.

Best regards
Yaohan Li
