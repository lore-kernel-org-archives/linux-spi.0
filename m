Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851391;
	b=NEd/pE0BU2mWLkkW0vwl/mG+JWlAcznzU+zq0ivMQyW1W5Zd14KB0QGWO9nd8DjaKoBm
	 9AvKkgArvrWTunqtumkIsKmGW/EdkXRJTgTVvZWVBXNa0Y5uzQO/f9Y8roZlhsbi9xFEu
	 jzwSf5Q0dkEu0Ff07JCJ+rmuz5YaZdolyu+QUlnynY/EFPxO2cSrRc7KdxfcHgumqbaRR
	 4Qv119i7okgvaB/de6xTkvLzAfAIC61rlsw0eT4bGFmZQi6Kia/682SIXigqij6zqjq0q
	 0bOZudIME4RW1BmiwwsDfSYbEUlrg5UJQJsz6QkiDaSocFcbb1/hIEyku6GT0iUxZdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aIH2VHjoKtn/WNIHLXQ2g0UJF7eASn5szYjtsYIKi2w=;
	b=qfHtWS1Q3Qwocde7ABqX2VY0e3sQsk9Te/vClqZk0HoK2ovIrfi6OdLCm17Jt18YzZai
	 T9NpqGjhBHtZ3/bZ+Xh0dWT5/a7jqUyuXm5qJdK5EvVqxmNOFBeJQcGPz/bbutDBwPiAk
	 JFB4/2ichC5x9skkRY1G+f8nAt18AncYFKXbGW9JjfGBx3hPn0vEjaJgIguaDeW1dNzbY
	 F8rN1faDmUe6FqMmS0dcZ2I39M1remNhY+jlsnex+HswkPHzsLxZ0TvjkMkAtHH0twn6F
	 UTPxTalzHasfy7MSGfvxcPc2RNKqMxW76zGUk2/VpJbT/S/73fw0UMrLsYKw2i1Gsfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6aBC7on;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755AA606A326
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 04:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x6aBC7on
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso560160a12.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 20:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793851391; x=1794456191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aIH2VHjoKtn/WNIHLXQ2g0UJF7eASn5szYjtsYIKi2w=;
        b=x6aBC7onBJb8jy4NU1gxCCoc3w0znZuyU8GXlJKcROQ3vxEm3Ie6nrRgui6EjtOxD3
         avP+OObkWAQNNAHyLa1Xu51NSzh58UHxB4CUO+yBiueOz8M5btV9i9dxYz219rJ9edXT
         Yi0zeivezDAn/zEkmns8wIaHe2uz40wLgD8pPUUd3eevjgaLYtsIktOY98HebmOEZtpv
         PyLUuMRWeGKBM4ZCJ8tN7KjiZnlirRgTnnq8oFrcMF1q6YWIXJvvpR7w16iCsnxBT69l
         gn/g/U6iU7ipTaZ38ziVPPHpsulP60ZuEh57BCIg/iUXUgSYE8eYl5dK8TxoQQ8GYB75
         0C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851391; x=1794456191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aIH2VHjoKtn/WNIHLXQ2g0UJF7eASn5szYjtsYIKi2w=;
        b=v1eggQ0nx2AzJ/Se10+f4gtmyCp6f6VL56rIC8zgbi2ftmWiMpKmYBN6u8KrgEjZ76
         F+h118YvDDwNpdG8geSFve0gilMTXjGNQulrGFd+UIZmkNrqGktsY/llgz1osPBYVDj1
         4fm4iqxywZO0ohM9DeTqbfwHiw/9ZSnNUprSbXfe7AzHWHB1G17s6/7mcHtP6sh6xFoY
         OwtK6qsEk87+n9K/BRJghMFwOHYQ2V7sWuRbFWiLcXfN39f2KkkN2rKNR1g8a1wX7nNC
         VPqBi2ADBJOXM2D6ZM+oayfHrYj1+7uipdWVQ5kzdn8tRGvxAX9uDRRdcBuDFlL6CwcM
         c7xw==
X-Gm-Message-State: APuU4Z8rKqvHMuSFTxfcIdtPQV8kAcdk9TySwcPQqcbyGFGqw4e4FS03
	mzFQCvID5it+MBckvlFfPwmcQ+yw0ay5HWvuhdTgJ+a7XQykBMKIiV5v
X-Gm-Gg: AYBFou0qTTCYw0duIIk5B9nk20Dzo6cMleTw8ty6jRC7OBRqCigGf+AAcT0ncQBwrET
	9LIyP2c/rO0BW/Cl1tpD7eXq+o7tf3QSUG+hg+a5unnkhrl1lJRbKLX7/C5E0U0PJRwdOirRs5p
	TRSgYm/dhUwnZmMBjbUJebfwbMq/ofH5gZzB8w68DAF6ML1C5nok8SvYkGOKlQdejWFSIXZVti4
	refe3Kkqg48uHw8NCw9LDvz3I6RDlhU055QvGufLTCkCRWnLD+D+c0qnE8fpCclLG00NnT2Yq49
	xSJ8XaNKs1VpNPnqf+2ww2KsZecj5gjkk/X+9rIYO4umXJaeCWDWiVp4loqWDoo56Kbow7gGpFG
	B4vUtqKQ6+R4A93nt8Tnf7aWwTCcqZWmJNW7GQvL88dknOv2PphIZ0YUX0FX48v3oNRd5f/QX1o
	dIAoFEzdRCowpqs2Z3sJumkUOnpXJ1g4o6wu1aEO4+O04vJ/oLM/Ssz8099wMrq4ZN7OFNZopj6
	TJWbg/kEYcwD2Ep2QTl3SuEHi4Myy+dUK/ir4x7+yt7+TIdQJEYCIVre3ZUEDEqsTJSRuucdMAO
	GeeO824Ec7xlJsUs5Yddvc6pbB3d/2qLwttUgCIyudjxFtmMP5mBToOp1u+XGj+Ejkr4138mQ3H
	InOXTcnW8yqkSmhwfw/sY6ptkip1hD80qHzsRuJ8Ft7xdwXNQSyxZnOgP1egsYGvEeW96PerDH3
	YIZ9NBYv8KcSc/2Y3WZbfglAkT7BMreHjtplhQ+MX5zwGncqhp1VKjsJTf/5q6oz8aEkfP
X-Received: by 2002:a17:90b:4b8a:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3ae89771679mr14588079a91.44.1793851389618;
        Wed, 04 Nov 2026 20:03:09 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3163383sm1581750a91.7.2026.11.04.20.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:03:08 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: Re: [PATCH v2 0/5] spi: spi-mux: error handling and delay fixes
Date: Thu,  5 Nov 2026 04:03:04 +0000
Message-ID: <20261105040304.1550366-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <3c7775a8-c639-40c7-8ba6-3aab8f1db6d6@sirena.org.uk>
References: <20261103225308.3633046-1-jctchan@gmail.com> <3c7775a8-c639-40c7-8ba6-3aab8f1db6d6@sirena.org.uk>
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

On Wed, Nov 04, 2026 at 03:00:38PM +0000, Mark Brown wrote:
> This also does not apply against current code, please check and resend.
> It is not sustainable for me to manage some stack of random
> interdependencies between multiple in flight serieses, please do not
> spam out stacks of things that can't even be applied without each other.

Sorry about that, and thanks for explaining. I will wait for the SPI core
series to be applied, then resend the others one at a time so that each
one applies on its own against your tree.

Thanks,
Joseph
