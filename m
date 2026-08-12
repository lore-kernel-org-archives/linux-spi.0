Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F2360EC9
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513164; cv=none; b=erqlfeo82yTpvYzbL+qud9Zm5auVF90E7+eED9fq7XPqJ1sqOYHfTNTIBBQ0grYFVaO1ESHy3hXMJQiCCJDbupFMOIO5K8ZrCmZIcoQzNE0W8gh6Ff4W8AR5tccp8QpNeti7iZ8WbLtrrrTVPSNMHEZ5H2rfh+fvR4Oi2+Ug8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513164; c=relaxed/simple;
	bh=rshymzHNkjh9WYmEAoUmyq/eAcpLbkbezQvZS8VArdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIaD+6uxXmnyZ9iUdvPwcvDXB5n+RdaqF7N5e1Q0+1vxbE6RQAmUKSIvF+RPQT4v89bkpUHe6415UqPo5gergaAMo/JmKfKss1VcH9I3ZYUhJhhxUb9Wwy+GytXDFX6euySwmhrJWqgev/KyG+sH01AOe04lQ/os96wzA+BMVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=UHOP4WYk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="UHOP4WYk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso273914a12.0
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1786513162; x=1787117962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIGIocDN60oZirKSz5V0y/eK1WaD8jPpFzqaWatj/vk=;
        b=UHOP4WYk0BPmg+p6vdOAcSssvflwvIaFuY+aZQo9NBB8y25vDatvnkt34R4uoCb1ip
         BkC176M7n+uDj/zuj3L0NPhI50QXzcIhxeBHFxZBrBO1Gm5aAy2Bz5cz8D5U7qer0vPi
         KTYRVSEXKqdJJYt81m/7x08lXOB0mSc7LNgHpedbQQ5nxA6VtDQrPilvReI1fmi7Hepo
         m128YmNJc9NnW1rXAn4nwqfK76jJc5yXPoO+CEW+gziS1hICzmybnea6uT/Zg9JokgvM
         bK5IsJh/7ZstePqq6W+sH8SOy01cc64flxe7Kfam6FkSh7rbOLyemJhTdvu4vf29Fd+R
         1ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513162; x=1787117962;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIGIocDN60oZirKSz5V0y/eK1WaD8jPpFzqaWatj/vk=;
        b=UA+GmLWsuV3/aKR1tFmSByk6FxmNwTJX7UrP9bbSe+N11rsqZ4xdPSQdPm/YDfk7eu
         ZdTuZh4wuqF+LwYE2SskFa1Dh5B0O7oL/dijfIskLLGlXEisIU9O45fVaJuW/KXEYU6Q
         mqLOdChOsd9JJ71RoPlSJFlwVAb+mhPeuyNbLUX+X1B3thwOEmKdV/ksU0EcRPHAvAkA
         nlj9TaD0f4Dg7DH8rnBPSxc8/1jRDQIRMR9B5oqv/88Pp9s6SibRf8zkskBQHAgYE1QG
         ybNY1OiGrv70jYwjMjQWkxqE0OkIuf1ERCKIRga41qvo/cSwM3+/eQIDnn/5OZfob07L
         Q6+A==
X-Forwarded-Encrypted: i=1; AHgh+RovdA9WzYySgkgz0knObXY0PySvQl4MSFptsbU5yKMttJppmz55H9juZinNcAu2N02DTxQ+NwtMtNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygw6It/rB3ajJlpQo/11xB9S5Xw7EACqY8II6u+3whBU+k01gR
	er2LPHPlsPCSx7jN+xtzoAjm8UHKbAUaoVlcer5CoftoCA3urG5TfMVzudQ1tiSAIMU=
X-Gm-Gg: AR+sD11yD3ZtQlTqDRzPXQXo6dtioargydAME9+3AEGCu9GoLJDWaK/SVd9OGF3RP/j
	KLovpxEjgznGGjp8s+1zLsKJaqZ3YuSLcCQMPkklOehgk9+BTjDtsam+dTy7fnOxEtzGpuz6OcE
	q8PwRsluJ9t1/40pQqR+3qwgocoOfpH5i7l2LP0LGzpJR7Z3UdWrn6XjZVyKBm6Od1+vuTborsE
	7Tt+CLYe4K22k8x0qGwF3N1GEOcRD/T5pjnAvlVMkZYea3QnCfcKlrxlCsKmJGoofYTSHZzqK8e
	wZehQ4xkGlR4NmVZ1h+CaEWY098kotZxatrsQlSOaz/nXEndGCpKvMU6q1uqJjxPR73nqiPiSpb
	BoBes2dAngq3ECpt30ocoRFRTcfnyTCkZTeleypt3JpgvG0wSnYu8XkDFx3wJ3JTdObSkc3Iqjf
	fcGODVOv68LqvRVBsRQAl/kKpci+4imkJQl0/50792JYm6ZxPN9xhqM6Vuu/1NQzXVgXx/QznvQ
	RZbkrk/fb6zrwB2q0f+T9HmQIPIWIbVHKI7dg==
X-Received: by 2002:a05:6300:6713:b0:3c3:b57b:6459 with SMTP id adf61e73a8af0-3cc3f520551mr2525975637.7.1786513162207;
        Tue, 11 Aug 2026 22:39:22 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:a70a:1a8f:5e73:54fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f9cfbsm5961233eec.13.2026.08.11.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:39:21 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Abraham Zukor <abe@maticrobots.com>,
	Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: tegra114: initialize native chip selects inactive
Date: Tue, 11 Aug 2026 22:38:59 -0700
Message-ID: <20260812053905.70799-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <5pH8Hvm9Tn-0PY-swUeCwA@nvidia.com>
References: <20260731030134.4182688-1-abe@maticrobots.com> <5pH8Hvm9Tn-0PY-swUeCwA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, Jul 31, 2026 at 04:13:31PM +0900, Mikko Perttunen wrote:
> I don't think this is a problem, as the device tree is supposed to
> describe the visible hardware.

Fair, I noticed it when testing, so I figured I should bring it up.

> Why do we need to consider cs-gpios? If a device has a cs-gpio,
> whatever we program here wouldn't reach the device.

To maintain signal for signal backwards compatibility, I kept the
(unused) native CS lines low. Nothing should be using those lines, so I
will drop it in v3 unless you say otherwise.

> The if condition is also very difficult to read -- please use multiple
> if statements and normal error  handling patterns.

Will fix in V3.

Thanks,
Abe
