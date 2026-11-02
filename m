Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639248;
	b=OxeYjQf/ldlPLpJkd19nqUny5tlI9XerIviyQ5F7k5hqNL9T8lbZqStf7gZVrxjb/nc9
	 52qJQYPzZcN+Oc+KFKtu4Mc7f8TpGDyH6+KVX6Okg0+diCytHjaa5Lg7SV1THnOji6kbZ
	 bLQGE5dq6qrL715EuMXbqR0CT/YiGdh/HGbu5AegUfPs8OcLd5ymctY8Z/Bc/HPJ6WNRR
	 CJtlnNJaiDGR2xyLkRrEpSp/R2smz8pOUaDvB1UrkvHEIcTwt/MOrG/wijwNoXwf04TFI
	 q7swtf9DPr8NzURRXvP/7znhxIZfmJPScdGs3bJh/x+DCbDxtTO6lGHyawlvsEcDsAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4zAAEY+oHQQmxlVkW5gRRX7pAPn0A/gwpsIb41Bbaa8=;
	b=pGFw7KIDa5Rv3Dmbjc1cWnnBHN+XzDMu0NLorub7ptSOx3ef1TkTYPB89MmnLDMuPqRu
	 gP1O0NhxGHeZ+X56U/CmBnPAhoavkcXNaClHM8E7ciZRiVmoaaaneAYb/YDODr5CZjHTQ
	 BdwAfLLGVjPB3lCgkJ0b6fLMYbQAJr7IsoNzNQg9H2574Z9c10Z0IoDN48d6dTiK421Om
	 SzCN/kFlmwreYqQw+iO4wJF0pcK3AZg1oAdxQ+NJf55NMDtpchRCkpFOCzj8GAdwast+o
	 vAa8IwqrSqrCXvZ8+nX4fcOpXKaLzYOmxMu3OJXp5F5PUuZXoYdI1piimwu36MxoNFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bixFuc4H;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61DB606A905
	for <linux-spi@vger.kernel.org>; Mon,  2 Nov 2026 17:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61DB606A905
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bixFuc4H
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b1afdf5196so1053555eaf.2
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793639247; x=1794244047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zAAEY+oHQQmxlVkW5gRRX7pAPn0A/gwpsIb41Bbaa8=;
        b=bixFuc4H344fFEOcZ7VrcoekwQYoauFULMAyK9WZL5p1jcsbx3k3MTJhfi6tTMrBSo
         QVw9GkqqZ84Y+jDIUA48oqkvsc73V0WaMI5JVa2pRNTA9CQ9ox1VW/FKrRDHtvWdC72E
         CsmD6TcozqO+iUhDH38gvYrzxh6CIyn4LAopRb1L6fypOuKozEMaX/VAsNC7BqiBMplz
         7QqCSNBysyI6V8yHVCpnZKx8QTfDTMzALSAoyNGLZJkEMKUV1rkTF6y9wrZLxaL4tk+d
         qcoCsASmvcCam1WDBvRFXvpm8FFx63vejsRd9bVvSbTuZHANAUNcmHaa7ZMQYCxlZDPG
         PTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793639247; x=1794244047;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zAAEY+oHQQmxlVkW5gRRX7pAPn0A/gwpsIb41Bbaa8=;
        b=S4iBeMGbW0NBe825f5hzZBMxg5ZQwcXVKB6fNOtHcZCRMHvk0NMSeQIqYlf7MiAni/
         y1/ZbkQkAVlLMQ3kr2tfq+Bl/qyYFJBWzepgTE4bTdXpLbVSxiZiBDyHuzQ016LteiCi
         IjFpexN963T0cbdkATeYmPovKTASlICkPeDxtIPbiPk1jZFUfJPPRLG40UCncE/WffWX
         K0UYfd3SDTQbqjeGGSDmhUB1TgCLNUhAw53RT8tExo3VIIB9ZXdVL4W8v9uB+HTum/rO
         UL5ovN4uNexcEXwglfWd09ksSiYt/F71kXFS6+PIqCk69jydXFUOK/zJyZpjft98WsSP
         GD3g==
X-Forwarded-Encrypted: i=1; AKwUvBw7AcJfUbSZgliHcOo6Jy41LqLsa6bYhHNQ9mHcJKcviD1aveO3uNuvT1NlBvUUvH5s2F7jTCwuZfw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXXoCWAAMN/yXGPwMLhYRIG5usSNZ9qQutARHq8fegKN2Gy/gA
	WiS0PqcsINP0geSqZsdAnTpzuRXsP28JmvK/aNPx6Sqvxcz/0fx3FhfwD0va3t88OmI=
X-Gm-Gg: AYBFou2+EDhWjBiCk9d63jdTvinSlej1ZrRyQ9UKBZ+rVVoW7/KOwYtBxBn37I1tW4A
	SYc53rHfTTYSziBdh+fdgqJAQFaxnoFZB6BY+kkZ2b+t5OicVQtaK5JLMtUHuyb6aAlFfl+JMll
	RoUci+dTdfLl6k912FHbflRUq+NnsA9NLIVDAIYUVLa2iKPDPJ9i4y2XdWKIsFLebGfXcKMR2O5
	VaiKpfhWpeLBnDiscfi3SEC2Ip8iUpdtoh2uf140s8hbLtAuuGgNPNHrPeY/XduAf5SYtM48j2U
	oUZjIeFv/dDV8jCiHcDAuFBwIgdYUi0bVmcltk67SgCQlGL2/29eg2Yjx7vYkLWe8TfnEHg78EH
	U4Su/aiOHvMAKjda12irEWYWrnoFGLQUYkDLBTV7Ckd70XKrEQ7cV5cGD/iloDQ5JgCa7jcNwLp
	fPBoBK7OkKdMfYWXZeyzq1N+0Z0xaZjNpE3QXtQJ5/XwbAiDUSsOlrHIZbFKG5QJlORecdwWzDe
	4mD9E/b9vNV/eEFzO0189zG9ZY5zD9dJMDbPLYGUtB5+J8M5m8PjXUA2aL5fpBm91PnKrElQHGg
	L8CAVfF3S4VCQ2kaGSwJGDeZ2se6VK1ocJzdwKshnDPzviyIV/I/G6B0UlZp4RUqcG5sQyyrpF+
	uxw==
X-Received: by 2002:a05:6820:1ca7:b0:70d:8086:e48e with SMTP id 006d021491bc7-714f28d0394mr4953365eaf.20.1793639246682;
        Mon, 02 Nov 2026 09:07:26 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:1432:12c3:1aa3:969f? ([2600:8803:e7e4:500:1432:12c3:1aa3:969f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9219f28b9sm7835916fac.12.2026.11.02.09.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 09:07:25 -0800 (PST)
Message-ID: <405feb2a-6df0-4edb-ab10-b4a70eae0671@baylibre.com>
Date: Mon, 2 Nov 2026 11:07:24 -0600
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
Subject: Re: [PATCH 00/14] spi: spi-mux, core, ti-qspi: error handling, delay
 fixes, KUnit tests, and lock context annotations
To: Joseph CT Chan <jctchan@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Conor Dooley <conor.dooley@microchip.com>, linux-spi@vger.kernel.org,
 Joseph CT Chan <josephctchan@google.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 10:30 AM, Joseph CT Chan wrote:
> From: Joseph CT Chan <josephctchan@google.com>
> 
> Hi Mark,
> 
> This series fixes four categories of error-handling and configuration

For future reference, it is easier on maintainers/reviewers if you split
up independent patches into separate series.

For example, patches 1 and 7 could have been a series on it's own. 7
depends on 1, but none of the other patches are related AFAICT.

> propagation bugs across the SPI core, spi-mux, and spi-ti-qspi
> (Patches 1-6), adds three KUnit test suites on ARCH=um with detailed
> inline comments explaining the expected vs. broken states at each
> assertion (Patches 7-9), and enables Clang compile-time lock context
> analysis across the SPI subsystem (Patches 10-14).
> 
