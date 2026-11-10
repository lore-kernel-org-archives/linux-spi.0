Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345495;
	b=1GPRuvbG/3Rig/NPdrGWm+Hd11RLfdUK+bzW6o5NY1O9b4OboBdY6/kOD+qXh0pdulKC
	 faEvcSPT/Yb0pW4+1OCJF81JsasrhINoCHmRLXA/aznJZJxsyoGxiAeLyyd4vbgGpylTY
	 YB95p366y55QTbyNsCMUQKTO42bxliOBaed05svLygZWSClzojOUjvdL2cEYgeWbHZbfm
	 IOVlZUrvwJI33rm3FtE+veg/puTRo5TZoPRXh+hpcfzXhdzkffFPRYF0CSxqudyd5eZeu
	 zztlHCQABJgiSEUr41kHJWrKnn5efDHUBzw1ohA9keBDyOjg3n2Kmy5UlHezn9aQP8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WhS5MxHt8T8zhDgGML2bIOGXpz4OhhZ+txf4npSt+gk=;
	b=e9wC8hP9mwXfG2MRaHp2oEZxnVIeFiEjxTMm887PU7bq0fh5ZAnT8ZvSvTTbziwGiq4h
	 x7JUAw5ZMH+RnSE35C4SQGjB+qT6TfGK8haEOdt9d36GxjPnG+TdMJMrNUfR90GIhls3M
	 2T4uq1FohCHRbAwn/fYH9St+iOMKfafzbldBoLzE3v2aw3sBPSr9lwHbuYP7Zw1fXrlDd
	 cVs+i9M8x+SLdFu1k3QfUWrEu6pSBnXeqzbIpdP5W/w5C0sOl8NxNIm0OoVCJzwn6kcDN
	 AxO9Xqx4EgAU1cT9+n+Ngln/HRFaytWyf2Bet824wsUuGfXQuHT76qOYblF1Yc4QoRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDBs3YyS;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9D606A31C
	for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 21:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E9D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDBs3YyS
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so27025895e9.3
        for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794345493; x=1794950293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhS5MxHt8T8zhDgGML2bIOGXpz4OhhZ+txf4npSt+gk=;
        b=RDBs3YySmyUiRCa8rFsW1OX+nazVdAIHlsWNBr4dRsy/fueei0xcpJUxa1bPZHg8x7
         5SR5YSFm+uf6pzQyP2fwyEkwRjQ2Nmk8HQa9GGY11M1H31GpdwGBuXkCHNRBZ/e7oD0E
         Hjfx27prIwkgnNZoFOsm1j+Qy5+FRPdJXoLIh7pNqEslRQ4hZRwu5s1Op3XTbqT7uMxR
         nYvXhjwEHD8mHSXJ+sTIXB0ALOfUUIOIV+jxqvrwhL7L5mwW3HYN9Lob3H6eFllhkG7K
         NWlbgrUnEhJX4DB/I3aXdWJxTJJcGIeGdJ4/CxbHJLk6rethULCQomvYABMe08YBR1gC
         2Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794345493; x=1794950293;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WhS5MxHt8T8zhDgGML2bIOGXpz4OhhZ+txf4npSt+gk=;
        b=i81AGhPYTz3zQvdimHUncLjsF2TWXRE2X9WDWPg3Gssi/OyYtGxuOKO/OlGcQsO8qi
         B9pKvf86k6G2BICsPj1gL+rPR1ouHItzNsuP589dojibfRwkMTtpTBjkDMa9XSwbQQsR
         5VBtofp0UfQJ6/hmL6uvA4Wmmaw4kqfi4qHOBbtt5vCIAbTsvrjGxmETli1/Fx9ld0/U
         3rBsADoi3Z7pk1nkOjj+ok8YWIiQbL5lzP0gmY86aVOjNHQwXroin0Pig8mphbXRIHSR
         mYKcrhRfuAmp/wqmw9drPfN6xBy+twkSySOuZNxkwJ2PY7VbUCIhDygZ+aGfp6tKCL6P
         B5fQ==
X-Forwarded-Encrypted: i=1; AL+hErHorIdTUmSI/bav11Gbmm2iFB0MJb93QNYjTc13vKrdiZx5TUyHZhP1H2OyEOXlmijCIA5NS2N5V6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T8kYGOlErxyCVw5KcyEX7aEYyu+MgJuO4wq58VyILbUTN3T4K
	QPvte0UZ7wbGge72eghog8F1AAvuKJudooig7BWDGZxEzYCdE4UE9H5z
X-Gm-Gg: AYBFou0mqOI50cSMP3uTOEIpeASJ2LGcvlISc9ITcMgLpq70e/dO3FXsI7zli7zYqS+
	3PrHQCvfVz0aJ4+E34qLqdwLShwP0vbsmd5wSbrdQZ6o5aprjtlKtNQ2W4NgtQG3Y6nNfdZ739R
	33f9wGch3jMZvkExvHszLwhZT+H71WW5jNdo1Svge65fPSXBVGEgPCW8j8XFQOk9r0bZOHRVsd7
	LGznRiL7+hQJ3qwbJmz2Cpzd+OTvsiEIlLpWp7NC7qcX/Rmb9yaT0m2ufoz2b/9a4v2EgBmjiuY
	YBWcVnrk45dgHJ48fRaydMYltGozShSKufcCmlcD/PP0puMm0qyZOVPcPjAziyU/aHD1jWg9e2V
	cLmso6gAHNA6n/AxU+583vGg4FbVn4XIKjW3Is+mQfOhr1dnSvYvCeSAnr2JbhkaKDjQ3qKoKbU
	M0Wh1U/lV63+T3HoJOYr4t+GN4KbZ/3t/dXHt3ebW5HZt6HRr3cm/2GxbnLoEjjKPr3q993vpY1
	JjsrBkvQ09g2nCKCj/YL58I+vIW6OjULjjaGyAEenAx2GZGIXe8yPG/hti5bJZCgPv2cdkFmv0o
	BzV/PwHOdRpcsf3qNJxbMwkeYsu7nZrOMGgz5/BatF21WmSRqVmCQdlRUHIVFEqoeuLp
X-Received: by 2002:a05:600c:4455:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4ba0931f006mr4996055e9.3.1794345492930;
        Tue, 10 Nov 2026 13:18:12 -0800 (PST)
Received: from [192.168.20.170] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm141664205e9.11.2026.11.10.13.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 13:18:12 -0800 (PST)
Message-ID: <f75c615e-0a92-4775-803a-8bc2aa3b4261@gmail.com>
Date: Tue, 10 Nov 2026 22:18:11 +0100
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] spi: spi-qpic-snand: use generic code from the
 'qpic_common' module
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
 <25dfb787-27ce-4d47-a619-e9600f4f7902@sirena.org.uk>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <25dfb787-27ce-4d47-a619-e9600f4f7902@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026. 11. 10. 19:46 keltezéssel, Mark Brown írta:
> On Mon, Nov 09, 2026 at 08:41:01PM +0100, Gabor Juhos wrote:
> 
>> base-commit: 4a8faaea975be15cb636646c0d4c6ff1c2110baa
>> change-id: 20261028-qpic-snand-use-common-functions-12b18fc7a1e5
>> prerequisite-change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5:v2
>> prerequisite-patch-id: 7f8a48bccb2e3c8de950bbddacfefe052cea50b8
> 
> I can't apply this to anything, please resend when it can be applied.

Sorry for the trouble, it depends on the following patch:

Link:
https://lore.kernel.org/r/20261106-qpic-snand-fix-singlecw-readloc-v2-1-18de8226fe15@gmail.com
I will resend the series once that one gets applied.

I assumed that adding the prerequisite-change-id is enough to claim the
dependency. I will state the dependencies explicitly next time.

Regards,
Gabor
