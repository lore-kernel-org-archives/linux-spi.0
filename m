Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268801;
	b=u7ReTCepkQ9BqnYFzzyJyCbgzrAT5ACumsOYtwey0QQaZoyocWwMLd2uCzrrQl3e2N2s
	 g8qjfxlbyp/qDdUUPhcT3I9A2v9nO8FX0M5sMTLiPBqDN7jEaccFzVFIU1WC76ji8E5Hk
	 zv+OFrH34AjuX7nDsojPJ8iRpWf9uGZzH1jguG4EgeGoGMPsmACWYIeU4UePeGWKgnJze
	 afZ2bJdXw+0dQqDKrHb1sO72Umx2umTAtfTegRnhDex+zjtcYlbyUEgKAZB0gMbG1NhPp
	 hICZXfaCwc56zKkapfxfqg2ClM0wAe0om4VmaBuo0yHC9SwUlLXMqL8HZtbvY17p0bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268801;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
	b=10qx8DpHUHKe70AFWwLG3g3x1aO4l53BIcNztzVXOHmLsVRlZjTBHOE2LU1Fb8dQ1xMt
	 ZkDs+vvNDzpwn/LngL8324yIOhEqMYZDTIC6LbGjMYdkeSfq3H7Jjz58W1irUi0CAUvTI
	 DlEPeQOh1osCetjGTGTYrb6GJRmSpJdLfvg/B2BqALHzhElUC3WdgHjYxFUZD8J//6LOs
	 9YRjpVBxCOyGWAj3Umbur9pVV4nlNkcdiUhvZZ29zgbe536M33XEDXKAvULhFu3jpgJ2J
	 WJwA3Dfki/1S15mv5+xZ+BUaXMjGaAJlZ1tpIz9LcIm9uXyvBgDl0o6/P//nvjAp9HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="G/XQfEtB";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A768606A322
	for <linux-spi@vger.kernel.org>; Thu, 29 Oct 2026 10:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A768606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G/XQfEtB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793268799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
	b=G/XQfEtBXkndTUnk0epYFPFVwqNLSE5e5gBKnovUGus0JxgrbOoElfR1NenERKnqGOe94W
	yr/YZEo9CiPkZNDfnaQq5qrMpp5Oa6p6M0hwIEvKaXZ5ksLlZZTH+zYKKucZrvibuBkXSO
	5aXESFOquZyuVSTSSS1Ym2POBXfik/w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-A_bnDYVLNqiHGv6dQ2u2Kw-1; Thu, 29 Oct 2026 06:13:18 -0400
X-MC-Unique: A_bnDYVLNqiHGv6dQ2u2Kw-1
X-Mimecast-MFC-AGG-ID: A_bnDYVLNqiHGv6dQ2u2Kw_1793268797
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b027578a4so1537589f8f.3
        for <linux-spi@vger.kernel.org>; Thu, 29 Oct 2026 03:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268797; x=1793873597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0F6MwB09+OApBTQzzcClsM6qT4Lh0F0TCX0d9TCv1AI=;
        b=F2E2pHrotevTcy22iQXBEBZXaf7WVHKar3Akrdwpa/GO+YOfW36CpuUYJre7GP2+Vr
         ZfguplSRPN7VaMkJG4xjeQLkZ9FQGeDeJf6XCUh/090Uzb1btZCJgJRGOCP3gppHf7rh
         F8Ua7QYD6AzTHkFG2rHkNHRlNkbdtK5y+SqOZ3ZmLQG9yHNibUExBq2ID34RHE4l8i8G
         u7dz+3tMcObg9R61gW4s9Oe+9fRwCPJZGFQQaTFHBewmTwyRKvtYha0BpFQS/OffRhee
         4Y/R8BulFaZv4knU5wKzH7KtG2yF0YaqTO8jCTMbgZ1FEkVsIhjWImqukxItBleNof3k
         1iKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeUstv4zeFPKC6/EbDOUGo43lUbn9V4CZ+ENJMaFzV830WkDdSA8cAvWjMkdrj0G1IqxsHDDBW1GE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLW4RA/OoIuTK9oOONnsMqcxGhEc+ks4qAPHttOjAFwQDAfhLwN
	fITJvHEBvihyskp/uyLrR162i1rIrFORYJMPVlrAE8eKDDKwyOTTA4EhH/NzslnjpRktijBQSPg
	fHO0rLwRi1uxkrJ/FGY2QT+fTRW69g8xYAOIYj+htnYC3ETHfWzZeekG/2xpdcw==
X-Gm-Gg: AYBFou2SyV2UzlUKOksOPckovqDg4hdoJOZa/Oka6687NHlocFoLoYseJ30ZvzPUNEG
	msctTx9RfZcGKkcgdIF5lhBrWtaD4H9RTYoIqfQotfKobn0sTrUL1YRyuPbXOnS4XzrHtpz+Rez
	OzVeZYADxHQAMk4WbvJnSkMmp+1J4hKsF4vwXr9jeJC9GAiwlWA1gKDOcVTsu2pQzl6vT/XAGJY
	vZADfDjhqbeWJFVO9yidYJg4FJaAW+xacCy505hmiCN5Ag3L3Qn0kdm9NcPBitS390uydFD7P1d
	56TyFEdJaNrovzEsVaWUk5J3CJPM2ccoHEXgyrQ1t3+bej1QmeE+IR3bpU3S+NxUqMoDR74GeiL
	EoqPwHHv3EttxPlEdUl0TG56/69dT9Ci3ZuUmEqvk4yI=
X-Received: by 2002:a5d:64ee:0:b0:48e:6309:cefd with SMTP id ffacd0b85a97d-48e6309d0fbmr6302493f8f.46.1793268796694;
        Thu, 29 Oct 2026 03:13:16 -0700 (PDT)
X-Received: by 2002:a5d:64ee:0:b0:48e:6309:cefd with SMTP id ffacd0b85a97d-48e6309d0fbmr6302426f8f.46.1793268795997;
        Thu, 29 Oct 2026 03:13:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1501:b100:9ea2:fd21:b361:8dab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm33021365f8f.42.2026.10.29.03.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:13:15 -0700 (PDT)
Date: Thu, 29 Oct 2026 06:13:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Francesco Valla <francesco@valla.it>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 2/2] MAINTAINERS: add Francesco as spi-virtio reviewer
Message-ID: <20261029061258-mutt-send-email-mst@kernel.org>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027-spi-virtio-bindings-v2-2-67927b24b9d4@valla.it>
 <20261029-lucky-vanilla-spider-f9cefd@quoll>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261029-lucky-vanilla-spider-f9cefd@quoll>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDWubpf0OPwyB_p-i8cawJgtWor3zLnYtnUscow2Jd0_1793268797
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2026 at 09:26:00AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2026 at 08:26:34AM +0100, Francesco Valla wrote:
> > Add myself as reviewer for spi-virtio, following the introduction of the
> > devicetree bindings for it.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5724645bf703..45a29ad08096 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -29673,6 +29673,7 @@ F:	sound/virtio/*
> >  
> >  VIRTIO SPI DRIVER
> >  M:	Haixu Cui <quic_haixcui@quicinc.com>
> 
> Please drop this email with reasoning:
> Email bounces and maintainer did not update it after changing
> employerment.
> 
> Best regards,
> Krzysztof

Makes sense, ack that.

