Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713005;
	b=U+9St+r0QOJIGgB0QK/A7/0fp/ACLvB6wiqu6tPGQB5I8/GLcE28MbkB+1UVRggqrYQX
	 D9A2zhthJz+cL0ju6Rk91AtLexyUt1VPwb4kDfxj/NRdejjQpGA9xYw3tKDlH3KthUqJ6
	 hpr0dAH4tufsWhqEPLummysRSXV79BOb0EqOXMHWXF5U2PcKg9Lryr6mNjrlr3CmppfPx
	 F7M4cMPONopCBLr0mESCj4H6KRvxT4KGDAd+WV9wTD+/GDv/pJGFXe4BWiYoHF9TNDuas
	 iCz2wRXKZCz1HsIOJw10UVkYwEbo/Vy3ssntCygc0C24OpbHlR/0qaUQLI3jvo4qGSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
	b=XqVKKxwVzZHv/khiHsB6/5S3UaP4SWPjCqZGx6v4Zl6YhPgZ8fsX/gwTQ1sGoLZ+e5mV
	 Xgzy0JAxI1JI3HYhuqDWEN4Ul+kth/rgo7/0eNLJs+0mE+BffANBr9DuIXOKovJjrs0az
	 wdHI9AuKFG3or7zQKtkIzX/Jpw+hBo0CLC3UENzhQAVo1VtxIpjuFyYIDXdwyrgANalrg
	 icSJqOGv/1DivG1Bgv/6D+bia9gdYaEsb04udRDh218fdcyKddl81SSgzvYeHdT8Ht9CJ
	 ByNCkm7xYResH9mVHUZx2IVyev6WADM+0ckwg6X+6Vv6C01GAfpChm5zRcIkFkIg2jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+2Z1fmo;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D69606A332
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 13:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D69606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+2Z1fmo
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so5480546c88.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713004; x=1794317804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
        b=E+2Z1fmoNcTkqQ3th537OvfMIa4NZoYHdDl7AVRl84h1LYzeHaZpFZScTVrFJBqkUK
         JIJ/AbsyeaWadb5t+w6s0Bh/Y5hVYZfbe2skMnsh+AXAXusS2QBCSSK9hqOlg0IjHdgK
         LDbNgo7Ll4jU5lZorxqjvTjexd1LRDt5PZ0v1OwhGMJXJJ/xZUzmcIRFrbB44HC/oMru
         k98sXmmyt5kMVnyH7gDOB6vYbeKQsXoxeEJsDFgpw6MLPknjE3lWjzl1d9o8+2VcNs6D
         fvidzrs4P10T4tT6hJVo+Td3dstpl7kKauv4j8nJu4CV6oyIOTNxXuH9XJXINSq+EHpt
         GILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713004; x=1794317804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4DWsW24byfCh1xGFx+Wl8eJwcEsJtuyX6O6+zehZDdA=;
        b=qw5SofW1lA79s6UrZbSwzGfQ2v6zkkz3tmnda4do1G6aEA2k2vNMeU1UICI8S1kWZd
         ivq+g20JPuikrPy3C3AEki6QVObu83n04Z/Kc0jusdM8NW9lJZh//vkoIhYIWJ2ij9/N
         9n5blygGSdw4P7b1WqSOzrRNOlgROaGLh8RyU5SGCNlv4ttEhGhCxR7u041QrFv64JGr
         mmRTpPEDuHOocDPO647WopOwWf6jrBl3TamwMK8y2KrYjoCm9rqo8rObV3pJB1YuFM85
         jYPiBs37fnvXBT6zLjvTQ8FrV+jkahykf3XPG8d4nwwpMfabbZGcikmGVvu4NVrREdx3
         35tw==
X-Forwarded-Encrypted: i=1; AKwUvBzFCMRkpE0/xMy8BMva3GoTY7gvpaPK9Daf/ak9C4hbxx2fdwdvFnyNL/CJkk8pfJqSiY9hajTdEjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KPfHEdZ5zp70LueW8raGhFERhDLf1lpXbK0b3vZEqL2xcylY+
	ZGyvzH7UT0tyMiDq34HG6d44HvFmJEjbEYhh8TTWoSiXAarQ4WmWyd+5
X-Gm-Gg: AYBFou2fYpHVZajoXv7lRcrq8oJrgwNJIl6V1C3283egDDxjsZCx93CrALbDiypeQoT
	hZpQdbDCpwFWUSyrF/Fe95Zdw7TIEuimr4xW6b6Y1rETM4BqUz3iMTvkemg65ulmDASYCDlyCDP
	voXE6IR3ulpdHmJmk/sbIfJprRu2OZRWkdXUPGNhCghzFKoPzrPGCnbIL38/82FNP+HrdzmhlRU
	vmOWl3GLd6YqB1/kRhfD4yffiHBFIxGhjY8+NYd+4WTyIljPQQ7JlbXkAUrfY4rgIpiAzzaS4K6
	DBZGqgWMVQtThw3bjBgZXuMb20W4lPig2YpCwrdialORTuKN94g4kJak/J3uEotQu3GEdydlGNo
	yIS/tbJl11ftPMzpkMntCFFenkiq2LXbLfRlfCU36Va/vIQJ1QDPSxpzMdb1dgedHA+eoRC4bsV
	KT6yi3HWEGQgRqeysMCMDxrQIq53Zp0RhzhGEcQlDMR9MQ0bova6R5PBI1v2/rrGY4gyeKgnm91
	aIMMW5u6lyBmEoymrLK5Pgne/CRjzhwRQTG/YIpri4Fb4unWayQz6f/xNZs7l4OmSMIqt3Gcmtb
	m2lU+kqLNV9mYBMFYxtRR/5mvRElep8AfBJcDV9/bTxX35/icKkVngZPOtDaIOw5Wg==
X-Received: by 2002:a05:701b:4283:10b0:166:f097:6f12 with SMTP id a92af1059eb24-1ac5cb1a303mr20255880c88.15.1793713003679;
        Tue, 03 Nov 2026 05:36:43 -0800 (PST)
Received: from arpith-debian ([2402:3a80:40d:48cf:34b0:c816:2853:c60c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c27cdsm73904112c88.10.2026.11.03.05.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:36:42 -0800 (PST)
From: Arpith Alexander <arpith99@gmail.com>
To: liuwb@xiaopeng.com
Cc: broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	lixu.zhang@intel.com,
	sakari.ailus@linux.intel.com,
	stable@vger.kernel.org,
	wentong.wu@intel.com
Subject: Re: [PATCH v2] spi: ljca: validate the response length before copying the data
Date: Tue,  3 Nov 2026 19:06:08 +0530
Message-ID: <20261103133608.29246-1-arpith99@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013031717.3933277-1-liuwb@xiaopeng.com>
References: <20261013031717.3933277-1-liuwb@xiaopeng.com>
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

On Tue, 13 Oct 2026 11:17:17 +0800, Weibin Liu wrote:
> Check that the response carries the full header before reading
> r_packet->len, then reject responses whose payload is not contained in
> the data received or is longer than the requested transfer.

This breaks SPI writes on a Dell XPS 13 9340: the LJCA acks a write with
only the packet header (len = bytes written, no payload), so every write
now fails with -EIO and the IVSC behind it no longer initialises.

Fix posted here:
https://lore.kernel.org/linux-spi/20261103131435.21838-1-arpith99@gmail.com/
