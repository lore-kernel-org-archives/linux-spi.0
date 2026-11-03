Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745735;
	b=gMkeGqFh2k4qenduC6uEbcZ5mnhJ6M4RHMFZclSNT/UsycumyC5Ah8G1cgTHVNrnmY4Q
	 bqeA+fTmQW6YTvaSx/00Q3lkDz097Gmaaim7zFtUGCR/ER4O1dmylqHpiN/nXF2AfvZI5
	 jApVwSlTmjSfzhm5VEYBKG5Tsm7mdDAIhSGAyWq6wqeClxrRVrA6EfzwJby57cY3Nmyad
	 qx0fFgrPnvqxFFfMmiW2F5CxdF/RKk09ryf0gNP3UEJ5oi4AKDyjkcfzMvib/0nIYUPIs
	 0HmlrGpVVjur/mhYLAx8AS7YAn/72+rbh8e7VaRtIT9OjVs2QMTgSqASDQJ3zKCQtew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KqPM0/WkA/1G/0bccHe9RrVMUn1AgSF/gkXhBl2PL5E=;
	b=11s3MYULhvUcisPXuB3YAu8Sw2v8HUOgW4mbv03BnW95ARyVRWXTdUYvUw5ANNrDdrVv
	 iW9Pd3j2o4f4yaHj6TjL5aUagj1HVx3Tu+i8vUnCyRdPW9tRDgFXtOwSlJf7nb0dBgHTP
	 IVo6nT7uHEyorcqkN/9cGHJupcnuleD1bRGwAit3uHK7D5L6lM9dnulBY73HK5RH3L9CQ
	 lIh0vEckLQEUDQ+w2U5NloxEAtY9c+fidgcbeNj8wb4h4Rzdvpyl+9z8MaKZHQ5mKfGrX
	 hr1NJHPiy7InLFz+puqEVnWQAcAcAuSW946/+CVthJf8LWI/OSNW5j4EtPAh6oryL1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQbxGK6a;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C6606A31B
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 226C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oQbxGK6a
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so118611a91.3
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793745734; x=1794350534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KqPM0/WkA/1G/0bccHe9RrVMUn1AgSF/gkXhBl2PL5E=;
        b=oQbxGK6aL4bfL8qMGw7dQugzCjTKWNpDDGZ7MPrIBIWu4RrluiFsmvcXiO1JAZml8G
         m3ZQZJXnqJnQBW5RwIuF4pV4SzC+jSrv1neQhjYk7PUhjXqE3qZ1Is/v1OocSw9e58nJ
         5xmSt44JY1rm1qdSxY+9mIDtxCN32C/iN0rNZCMu0uRt2bm0rZSFGymMV3s+SYlZ7tau
         SuEMkq5ZmiG2xMtQ5RZZ7+Ql84yXOCAM2SPgGx9SGQEJHRnfGPWPqRIGXaNtacxWg8QZ
         1un3Jwa6VqWrdtoTnqoamyNe+7dEnTUdG6oqwiPZSKbHA1ml+820P+Ai4crEF9dZLMb5
         g/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793745734; x=1794350534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KqPM0/WkA/1G/0bccHe9RrVMUn1AgSF/gkXhBl2PL5E=;
        b=We/LELp+5LWiZ7JU5/DRZrtkW4F7122VvqNURGWBTEk3k/e16XVYJR2s3NBPHg/h+N
         yi/6RiipGTuYmQFW3/5XlkGqT+Pc2rOmLhqlgJV9HXZRci9PU7xiRpXcuKPvQ3UwT1So
         2lQ2EBfbJdnQqMJ7UkKrTt017mEW6Of9f2RkAG/51PB6Ck9ZR443LP/5wnsVpBrz9Fjs
         +L6WuERkKR3i2/vfjdtx7bYubsUMeK4u9bO9Aa1YjsCmGR82Gl+u69iIGhJROo/uBUr6
         +EUd0A7UPKHcnNEIPMU4VlU77OTMFeNSq8AMi87fTLsdgGWuWn58FWleJkqABcD6McCk
         fS7g==
X-Gm-Message-State: APuU4Z/XpdQc8mwvbjadXPQXZ+5vjf4qTPPLrc1H4rwTg9Y27B8Ozu0V
	rZ61IMocaiwDzAgWkhLydg0m8swsrqgq9vtSr8AYHY3ghYVlFnU0E/Kl/sV2cd8HI2nGbg==
X-Gm-Gg: AYBFou0uiksqGjHAPBBoWmRIr+QkxIg3T4zSA5zmxlEpEruj/V1yBEQiYO+g30vrhXr
	rXgTRhjx9CiLMsJk0rc+GENkNoZdZpS1oAgQptVx+i8d8WaPFS0g2U8JKLrXVXxUrPKVx8GTnpn
	JVAsqbJxWy6ufkahJ6UIhTg8y1v+gontZglQ0iutHDAlgucnkiJYAg+cAQjmER1IYrbLIyW1hqp
	QHHOsoRHDJ2mymYPrqf52zBbcitWBtKyhi5BPNDYXd1FrBaQT/OsXOaO8Fmlyt5KwqCPsqYvEy8
	Bj1HWejjGjoaeZ8lhgecHT29jDlK+ygE2cgHQUL+iic+NOKU5MwUgxobMWmt7uUh0JSi8LPcuNA
	sMmHlxv1+TQmH/vRZzLY1Sfggw6oSWhIqgcNiFfxrmPXF9nVaWdv5xE4u0I1Hofzwa5hiEmWUM9
	0zpbmpL2J0LeTSDHIJPnDuqz9J0LNplG8Cc7YRLHR0nbRKHTZU1S2jPrc9W4sRjD2AjSvZ+CsIV
	VKVxyBaxKwR7E2iyqxG6kyBPmN5z8WFiGSRRsfum6SqU99I1CJyUgjkjdfUVTGbbEDw/1tUnoQ5
	keUZsHLyFswQEaADLDCWfqpmCl+qE6LcPDxVKF/6hgQIs3IJGkm0fkHsoBkHWkKFQ3uwo7cHn6Z
	1RBPUD/grmRDCQ75HzdLvHXzX4L6+ndwpS8d5dY3dJ+eBcPsuHYZwcSurAXMsExbdr4VhPTx5x7
	4qJF0pZM85R7E847x2xgmJa6xstMSPxpDsiLJyOTox5rSoiTNDqWCFjwSwxfXJqbEBiOfh
X-Received: by 2002:a17:90b:3c08:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3ae89812f18mr12434074a91.37.1793745734533;
        Tue, 03 Nov 2026 14:42:14 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d41bsm271887a12.12.2026.11.03.14.42.13
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:42:13 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: linux-spi@vger.kernel.org
Subject: Re: [PATCH 00/14] spi: spi-mux, core, ti-qspi: error handling, delay fixes, KUnit tests, and lock context annotations
Date: Tue,  3 Nov 2026 22:41:33 +0000
Message-ID: <20261103224133.3582678-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <405feb2a-6df0-4edb-ab10-b4a70eae0671@baylibre.com>
References: <20261102163023.2574632-1-jctchan@gmail.com> <405feb2a-6df0-4edb-ab10-b4a70eae0671@baylibre.com>
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

On 11/2/26 11:07 AM, David Lechner wrote:
> For future reference, it is easier on maintainers/reviewers if you split
> up independent patches into separate series.
>
> For example, patches 1 and 7 could have been a series on it's own. 7
> depends on 1, but none of the other patches are related AFAICT.

Thanks, that makes sense. I will send v2 as four series, with patches 1
and 7 on their own. One thing I found while splitting: the spi-mux test
for a locked parent bus also needs patch 1, because spi-mux forwards the
message with spi_async() on the parent and that is the path patch 1
fixes. The spi-mux and spi-ti-qspi fixes themselves apply on their own.

Thanks,
Joseph
