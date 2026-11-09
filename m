Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258615;
	b=xJZT0RStsxqacdRHoqtG+1RY6sMkRHu3WMgp9C5k8ijonYI4gSdBu+bJ7vsZQiJXHdxf
	 7r6U+mWRWpOlWl71Ymopilg/xAFRRxSaKrQr0U828rYeDbO9bNfV2tgYdnjiYE1l8fI/q
	 ohfe+BSOqZxc5RLL5NI/f48Xrp8C8PNnImVgXtqCe5wpyaUgm1gfrAoAIzz5Obyf6ELcN
	 CM/CMpanPwjFj2q+drQumExoN5/+TkZdubnYUwVYd8V8nv/kfsyRN+8V58D5W/7lm1WmZ
	 AYzKPcVGzMl1KVyh2wrZxSHJ+8RtJGzymsBfPjr1qsltjotJfNGGGkUo+T8pWKR1R5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258615;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:User-Agent:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=1H7zaCpieKBLh84LxvwJhxxRE643HHbqTw00oHfOz4M=;
	b=C3oebfQ4hI8tSGkw2aJmvG4pkeq0gF18KWHcVonMvXqlDwS9zv7x5BwINt3WI/M3TbZn
	 ilLqZtnd/A04jKLfbilz3oZH+OiOg1GiqhExPhGhBEaMN1HuNrdozvmmaEPm6JJ4NF6yD
	 uhp1miaEq+MrfMyQsao7MKjZU4sd5CAB6Vipf4CLyMOiQP3TC5XFEiPy1dhdZ3Jvb2GW1
	 Q1urRDGxBuMRJy4MuZexMEMkqAlKxbzhOZ+FOQgy2m6FB1RqkV6zTP3IcJCTiXFf3pSco
	 Bn3itD3b4x5ZgLgUrmr0pZbd3cihAC1UR5HDdp+z02h0d3vjbMRWxPYQC2st/QaIDVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JMuVRsUF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B252606A31C
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 21:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B252606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JMuVRsUF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794258613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1H7zaCpieKBLh84LxvwJhxxRE643HHbqTw00oHfOz4M=;
	b=JMuVRsUFNk9cuIX+zwtr3SP238wHdc6lW0O0zI+JHWiFPxYy/JLIkooU12IGJqP9iPmvdD
	nejnXcenJ2TEG/QOtg7JBigtGQVw9ivQLRJbcO1MzGbR0SUQPsY/86fcPpgnBMgUB30/Ta
	MWKAIQggif9ICAhuHo6AE6TIK1ruXZk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SAz94-siOnKYLJ3OpbhZiw-1; Mon, 09 Nov 2026 16:10:11 -0500
X-MC-Unique: SAz94-siOnKYLJ3OpbhZiw-1
X-Mimecast-MFC-AGG-ID: SAz94-siOnKYLJ3OpbhZiw_1794258611
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b304fbfa2fso13279667b3.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 13:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794258611; x=1794863411;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1H7zaCpieKBLh84LxvwJhxxRE643HHbqTw00oHfOz4M=;
        b=N2c94Ci0uY2GBHCPDFMPRFcKlp+WVarTkWhZi68EtV+yaFuAUqi/bRF6WFkq5o71c8
         55W6Bgs681Q4O+ya5+8fQdwHWxpMPNz8R6wqSK9ZYfRz+aFXEaFisHnUx6Eu7qNzBzre
         dHpwBI9DaHvPeuy71QVvyOT7jcjj0X5GfyXEOF2QhmmAZPgcaVqF8/1r75AwN8xNeVL5
         Cu4iwPpzO6Qz4uoOG8a7J7SE/WeajOcGyrRr74Hz2Z05F+Z5VVXrQ0jRhp4L6P3jnyfX
         /FyDQ7WSs5EMqIrs+Mic36iM9nR+mfFj7OrvWLGGm/jGu1RZV4pd/IRSqAWAnHfeMykq
         TaHw==
X-Forwarded-Encrypted: i=1; AL+hErHLz6gpZgEFZ2yFeMWerW+8bE1cHlZ/pYTrhy3b7t2hxSo9qYpkvFN4KYU8OYQUrYTrVm3dB8cTndc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q84KR2EDKaPqVu7ReRdmMWHa6XH06AUJRlWWi7gzPlYOEZ9hF
	+yOAvu04wcI4Jd8h6+NPodykxSnuCnlYp4fEZUmrd2LenqGPYfny0ark9kn28DN9hn7ASmEp3Yj
	J13Y+GyYvlBlCtHnuOeI34fE4LpWh/y2X/J14JS9lcRLY0jqEARvvYYe5hTu0GkYK9dmiWA==
X-Gm-Gg: AYBFou2nTT97NtdkFYt8EDtooT9I+hOs+9lKBzI+4zO3872flgm4NwXG+7c5WL7m6Kj
	kuycUJcUVp39SOogXa4kkj6h8qZs0arata6NjhP7piFFyWvdJ2TbsCp2O8TcrrfDzpUScIdQdPR
	BeyNxg0JWWSdHSk8rHAveIMLKQEQijYvwQp03353nX+GH/3Osbhn9SgWdvCQM1WBqq5j06yfVjM
	3w3elno0YaphQnYX0xZtQn4L2/37BfsVQsLAm4uf9gor2TMdIPA+GXvwUkHBBkyvELAyTNhLF7R
	85IubeJFLqevNKl90ZIlxyvnvBnkOMh1LFBD4qX5/SJQQqsNDDo1MHRDltbjyxuCCsfvHTKpSMU
	QDQUUx44vCkWoonuKfHWxNEibBnOuu1riWikMwcZAadohE1HSgTJFx0Mk5q1SVivBrVtQ1Q7BNL
	Te
X-Received: by 2002:a05:690c:ec6:b0:8b3:361f:5d7a with SMTP id 00721157ae682-8b392aa0a33mr3430037b3.41.1794258611092;
        Mon, 09 Nov 2026 13:10:11 -0800 (PST)
X-Received: by 2002:a05:690c:ec6:b0:8b3:361f:5d7a with SMTP id 00721157ae682-8b392aa0a33mr3429887b3.41.1794258610682;
        Mon, 09 Nov 2026 13:10:10 -0800 (PST)
Received: from redhat.com ([2600:381:e227:64a:814:7bae:8aaa:cea9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393421a3esm3583157b3.32.2026.11.09.13.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:10:07 -0800 (PST)
Date: Mon, 9 Nov 2026 16:10:05 -0500
From: Brian Masney <bmasney@redhat.com>
To: Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] spi: convert to subsys_platform_driver()
Message-ID: <avI2rf-04L3FOfSv@redhat.com>
References: <20261106-spi-subsys-v1-0-a51a08f21cf2@redhat.com>
 <e86963ef-6080-4aa2-ac80-e06d16d9b092@sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <e86963ef-6080-4aa2-ac80-e06d16d9b092@sirena.org.uk>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ynAyjTutGS25P7B1tB-ksUbn35t-QJ9zEApeSVyM-5o_1794258611
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

On Mon, Nov 09, 2026 at 07:14:33PM +0000, Mark Brown wrote:
> On Fri, Nov 06, 2026 at 07:33:07PM -0500, Brian Masney wrote:
> > Reduce boilerplate code in these drivers and convert them over to use
> > the macro subsys_platform_driver().
> 
> This doesn't apply against current code, please check and resend.

I see that Peng Fan already beat me to this! There's nothing else to add
from my series, so there will be no follow up from me.

Peng: Just a heads up that I posted patches across the tree Friday for
this migrated. I think I changed everything that can be easily migrated.
I suspect we may have collided in other subsystems.

Brian

