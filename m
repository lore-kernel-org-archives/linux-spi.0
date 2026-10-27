Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098262;
	b=UJpSl7ky4ibJU8qRJHaRNkUNDPujeyY3aW13q2dnIWXo/thBIP4SDcMVrRAkg/F5uUEY
	 K+kd0FoWTarnpXmmLUWs9z0w8K6+3BaXOik1rUH1SH0x1bFLI2fFliaz/M4H3PV0z+HGD
	 U9fjnJoSmcry4q7nbIVyyRP2Rzh55sXpcUozn7ZiOUYqGjgKC9Q6HWh0bpC5RS2Lp1mjn
	 mCgOxUXcnhuuiXpS0WLges9GlHsZPmBww1Ghtlh9eyHY7ZUcSmh2Jlq2uZsklKtiABieG
	 5TEviyxtG9pCqza0WdSRn/rmP15fBCv2VadlWSsvyjwVeyJN/I+1BkDJ0oODgsPiwpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098262;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=AwIRDSVIZlaoTPRqqTyp6BwANPNi3GUs2aLH5r38dzI=;
	b=TTP0Ly6aaFLmQ5w/Wl7dnxLrtaLo1dE1ZIbyEsgXtXUcZ4W7dXUmLzJ7QkJWxZYjZZ/1
	 kOj+WO8IVnr+SH7t+MkYJlhSXyF8A+QKs5coeETwKzV244M3dQH0WXQVc8A5qVDWzwm8D
	 4RDF4nfzDHtJaJ6aGLud2kn35jmIl+tpFW6q2uZL/qP6U4IgZ+jh1RHNr5FrDG75Vyve/
	 C+6cYf3DluVOaLfHmwim1plx40q6TwDUcU1rMFAPO+Fooovj0v/R94BIIMVv0wKnqicTF
	 lgWYrx7lGlEh41KFoih/hhZJmpwlk8C8EQPl+DNAD09AHntinOucoG6cF2tFJ2Ji23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TQkNZj9O;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D7C60A3820
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 10:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D7C60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TQkNZj9O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793098260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwIRDSVIZlaoTPRqqTyp6BwANPNi3GUs2aLH5r38dzI=;
	b=TQkNZj9O0Y3ZyqJrXYOSE4P97vCi8KTidUQuegXO/I4JE+7UL4jpHuDuRyecsVbdo+5o2u
	+JOEt29k2bwKNrIu/QBhSODrx/8AO17kXDut4CvW4UN8uiI5Th0aC0cSOzP488i2eFPIU2
	jkCsY55LsKlZUGncZQ1MDZfWLOD2C4A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240--JtTgVkoPnKJcLCeplcSEQ-1; Tue, 27 Oct 2026 06:50:57 -0400
X-MC-Unique: -JtTgVkoPnKJcLCeplcSEQ-1
X-Mimecast-MFC-AGG-ID: -JtTgVkoPnKJcLCeplcSEQ_1793098256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso29840025e9.0
        for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 03:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098256; x=1793703056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwIRDSVIZlaoTPRqqTyp6BwANPNi3GUs2aLH5r38dzI=;
        b=dUjcfHxgn2W+w2ywSzi4hrPcakO468m4Vtn1AMMS/+6LkTIY2s0vzPW2j1/gFdlxAG
         NE8zFtXhJ3MV4N4DE4kI2shoBUncq3Gq857Y13K79M1kXQLqiy5t1IF8zpfP22wZFDAi
         0pZtX37qE12/sJCgNHDQhR6oy+UUbpZlFUKYeeYPzIlKlCDQq62Rib1F626aHiOuppUR
         QNwrdOR7UAJ6a/4MWHVqTGnRzOFDSEqX4ZrKiL5OXorMqXnpEGhIBQcUUhJq6K+qYXOU
         6DET/qYqE9IxaXR2lv/tnAWDjlIMe76h70zfcsxE9tjbWtmhTtoGASXgQQLwsvhxk8Qs
         P1bA==
X-Forwarded-Encrypted: i=1; AKwUvBxCe7lAdWox/tIHld9sPy3ImjM4qS3rvxcIWuz3v1L2LMm4EX1tD4VrB2hcyEBGV9up0PTuYYFogcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOZLd2U8hTN9p7WZ2tNtkQv6XI6i5yKWX0r87wVoVxo2REpr92
	HEYJpZs6LG2NH+GXtp59mTjlT+3kzMK5EGu//dNObON5RH/wOp81V1ClLL1lRN38GYTtXfZhjiG
	ERLOM1njY3ivpekAFmcsvXD0rj41in20H01CTkZRMuoiNxKZmImQsr8O5YUSN4g==
X-Gm-Gg: AYBFou2JVAHq1cxg5ti9H6aLwxVbCsYn/mFU2sRKVrJS62oJ2ykFkRqGyky1MposDvT
	qVAeqrgTXmlnEJo5EG76BN+Etofol6JM/Iz7+7vo3VWdxBAlqAZCSsawIYJv46MsDl6Vo0OzjJw
	NgmyCNY9P9bLn2a/U8sK6Smd+ePxY1GfgKyTl0tHaMmiAnPDDenwZt1wSuefjSB7R/9Hr1jaTg4
	LuCq39NVFzwwRAFwBSjijQ0xyHrrQId4Y3HIgdGaJji3Vw4hfOoFjOOltQMhAWsbcNNvMkOMFRv
	TMHbRUNBie9mJN8NQevpMvgNshS3is3gOAZ9JLSIIbkqgxkVo3uEliWMb/AJOdBGQss=
X-Received: by 2002:a05:600c:4e0e:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a35ac9d227mr178192075e9.8.1793098255883;
        Tue, 27 Oct 2026 03:50:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0e:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4a35ac9d227mr178191625e9.8.1793098255318;
        Tue, 27 Oct 2026 03:50:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm171269355e9.3.2026.10.27.03.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:50:54 -0700 (PDT)
Date: Tue, 27 Oct 2026 06:50:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Francesco Valla <francesco@valla.it>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 0/2] Add devicetree bindings for spi-virtio
Message-ID: <20261027065001-mutt-send-email-mst@kernel.org>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wmy_1GElVhFpbfW0Y2UEdN3_nVsE2QRHJjnPw9pvyNw_1793098256
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 08:26:32AM +0100, Francesco Valla wrote:
> When a virtio transport exposes a non-discoverable bus, the devicetree
> can be used to declare its child devices (if any) and/or other
> properties. To allow for that, the virtio framework searches for a node
> with a suitable compatible in virtio_device_of_init() when registering
> a device [1]; such compatible takes the form "virtio,deviceXX", where
> XX is the hexadecimal representation of the virtio device ID as defined
> by the virtio specification.
> 
> This patchset thus does not introduce a new functionality, but allows
> proper validation of nodes tied to spi-virtio devices, aligning SPI to
> what is already being done for e.g. I2C and GPIO virtio devices.
> It was sent initially as part of a different patchset [2], but since it
> complements a functionality that is de-facto already there and is useful
> beyond that specific use case it was sent separately (also following the
> maintainer's feedback there to separate it from remoteproc-specific
> changes).
> 
> This was tested both with virtio-mmio using qemu-system-aarch64 and with
> remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> parts still not not upstreamed - see [2]).
> 
> I added myself as reviewer for the spi-virtio driver to be CC'd on any
> patch involving the new bindings.
> 
> Thank you!
> 
> Regards,
> Francesco
> 
> [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---

I hope this can be merged through the devicetree maintainers,
I have no idea.
MAINTAINERS changes needs an ack from existing maintainers, of
course.

> Changes in v2:
> - Expanded the commit message to better explain the functionality and
>   the chosen compatible.
> - Redundant pieces dropped from bindings.
> - Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it
> 
> To: Haixu Cui <quic_haixcui@quicinc.com>
> To: Francesco Valla <francesco@valla.it>
> To: Mark Brown <broonie@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: virtualization@lists.linux.dev
> Cc: linux-spi@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Francesco Valla (2):
>       dt-bindings: spi: add spi-virtio
>       MAINTAINERS: add Francesco as spi-virtio reviewer
> 
>  .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +
>  2 files changed, 48 insertions(+)
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20260927-spi-virtio-bindings-f4e350b2709a
> 
> Best regards,
> --  
> Francesco Valla <francesco@valla.it>

