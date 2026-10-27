Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106479;
	b=WgqEqVoeBC3+flKQzDL4Ya65sAK0XibUrhKl4MuQfndVC9EEHSi81yoPM0F1GpwZxyin
	 CMjmPTjKdQWEGt0F5529G7gDTJlP6n6mm4708E6e+R3eRHewqWRL4FwhgoHJL0imB8SjI
	 v4hkZtPKposQheqxhUkp3e2947ye+RygbIl3Bgg9cf28CHYYMHLWyDMiL6Ddcj93s+ik1
	 1I7v/XEoeMGktQpvSbhKAmTD3ofdcPFAzMvtA3aVycyc6e8NjHqGitfNI9qv/UdnVMPLu
	 Tv9f2yWDifQB9hgeqsUlyBQ8ilUk/OMr7zbUfrQ3jf0dZbb349StOEHB5JiX52VHTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106479;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
	b=FQmPtHmmhMIyws6hXmxPquyayaWaArrZXKVIJUI+Wn2ez9IgZR8FzfMgV7P9cmxXWucP
	 TdhQsPn+mGrfUeG8518RpwNuTSMgCv/d6bpMB2ooaqPrypsecUNq2TyRD4EhrIxns2s/S
	 0BIy2tQWI0umqDioR66ldphTKiNGKPxG7ZRNDupcuVa/OeCaE+xY+jRQlB0zN+dmvnLjL
	 hhlzg4E4I/kwUP4+NFDslcEC7azyB3IotU6xD8IOqNGSw7FVBmCJC11Cav5zEQ/RCKwQV
	 qUjeFg72ruCfopnXCRlKsQ+6c1sj70BlqKrrPtWJzI3XqMQtXm+sl/1uwNgzyQRAyMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ditaDXmi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A26606A32F
	for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 13:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A26606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ditaDXmi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793106478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
	b=ditaDXmiYnUUIUrC6/Q2QgT1gBwgH9eVmbExIB87SCG7Llnn31o3D5MALKs9b12MCdeoCP
	WVomGraWql+pFKLRKs4MFW2pzQJia7YPQSTWaR1kXVenlO+aMmkgiLlZHG11TKLUkSP5gh
	co6xhlwHSkP3NKW+sgcIM9+Zun44vdE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-33JQeiLeMBiP6GFKC6DZTg-1; Tue, 27 Oct 2026 09:07:55 -0400
X-MC-Unique: 33JQeiLeMBiP6GFKC6DZTg-1
X-Mimecast-MFC-AGG-ID: 33JQeiLeMBiP6GFKC6DZTg_1793106474
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso24827815e9.1
        for <linux-spi@vger.kernel.org>; Tue, 27 Oct 2026 06:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106474; x=1793711274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATvxORBZny1s5fn8dz62jBylTwd8vo+fNFXQREv2wUs=;
        b=Q+CCXi+1syKH+lZePv2evC/Qac1vU6OePXm+B3MxVYjUqlmwprclt63656YAxxvNGP
         9NynAQXggvN5Qj0sbpGmcu2wPcIuuC8H1tUoSHzcTWlQaRxfnEY+ARqRcs4Hh1SM2K0c
         csyyoVPBLR/cpvgLajB7kKY+5qPFjFxMZ2dANtzlxzvskUPxXIzUMRVdbfwnaisSjj1n
         VtYn/6cM7dTsWXv4f9jfTNXeJnp+NX21Gs0hhO4Yc1eS16U7JlwV+Jrt760xwBevD5UG
         fL6lE/PWjSK/dB1cnzFRHZZrC14PwCZdoAmeeivilfz+nf7TnH2Yu6Cq8bJtIr5cjF+B
         cnlA==
X-Forwarded-Encrypted: i=1; AKwUvByAUh9j0bP4uyQqg8CDysC7Z28k/95YW21VPbHxVbWWB72h9KHAes/7W3i3VPvxP+aFndncWJdvjfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkeKNSNftkwuiiB/IAbdPKTEX129UnvUxEpPyn5EZgbtE2q21T
	eHhPZ1COIXiwvG+RzD6PBOMM8OSudYMQ21h9NUNM1r0pQ/gbZpqdwLVbl2+dCMqNYbZYCmi/xXb
	3ydN5rEkABX0C4a9KfolqrYyFMPh5TYZdb9qnacJ48oAe7WFAcBPuMoK4/j8ueQ==
X-Gm-Gg: AYBFou2b4uxbcdWPJSZLA2PPwx2WsQ/Q0tE5nqqyFewLghhJshOD9zsCJf75BzroyCr
	ZLGoAgtK4eh/Dk6EzMwKH+R89T+jDAqunH9wOnAEhFmaW7Q9Z7ZRWGyaUgrn/PY8K0hP6Tk2jfh
	hueTlUwDiScgHwq1eWS9Y2+E2g1e9mubvsrPuK9owx0kGDofKJDnRWd5xUMXxC/ey0uOF4KdM9P
	m1ZhjLR3X3lff0OmRxK+/637gWoWmM9S9YmAPoyhqb2vc0M10QqnGCAnMXtq9WbI+3EA8BTrNrn
	LAsCvO87K5qEE4agtg+GcMUM+j2+DDa2DEhry+caQ/YxNd+wRL1QksdesTV30wS1zVY=
X-Received: by 2002:a05:600c:6388:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a35acaed66mr171606515e9.18.1793106473519;
        Tue, 27 Oct 2026 06:07:53 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:4a1:e9c2:6c84 with SMTP id 5b1f17b1804b1-4a35acaed66mr171605725e9.18.1793106472915;
        Tue, 27 Oct 2026 06:07:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm691723785e9.1.2026.10.27.06.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:07:51 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:07:47 -0400
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
Message-ID: <20261027090324-mutt-send-email-mst@kernel.org>
References: <20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it>
 <20261027065001-mutt-send-email-mst@kernel.org>
 <auCb8_ROuyXdTkQ4@bywater>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <auCb8_ROuyXdTkQ4@bywater>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t69L2euf1ZEhcqHHkk7liTb1TVaU8g-YskMYazA8MiU_1793106474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2026 at 01:46:35PM +0100, Francesco Valla wrote:
> Hello Michael,
> 
> On Tue, Oct 27, 2026 at 06:50:51AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 27, 2026 at 08:26:32AM +0100, Francesco Valla wrote:
> > > When a virtio transport exposes a non-discoverable bus, the devicetree
> > > can be used to declare its child devices (if any) and/or other
> > > properties. To allow for that, the virtio framework searches for a node
> > > with a suitable compatible in virtio_device_of_init() when registering
> > > a device [1]; such compatible takes the form "virtio,deviceXX", where
> > > XX is the hexadecimal representation of the virtio device ID as defined
> > > by the virtio specification.
> > > 
> > > This patchset thus does not introduce a new functionality, but allows
> > > proper validation of nodes tied to spi-virtio devices, aligning SPI to
> > > what is already being done for e.g. I2C and GPIO virtio devices.
> > > It was sent initially as part of a different patchset [2], but since it
> > > complements a functionality that is de-facto already there and is useful
> > > beyond that specific use case it was sent separately (also following the
> > > maintainer's feedback there to separate it from remoteproc-specific
> > > changes).
> > > 
> > > This was tested both with virtio-mmio using qemu-system-aarch64 and with
> > > remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> > > parts still not not upstreamed - see [2]).
> > > 
> > > I added myself as reviewer for the spi-virtio driver to be CC'd on any
> > > patch involving the new bindings.
> > > 
> > > Thank you!
> > > 
> > > Regards,
> > > Francesco
> > > 
> > > [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> > > [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> > > 
> > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > ---
> > 
> > I hope this can be merged through the devicetree maintainers,
> > I have no idea.
> > MAINTAINERS changes needs an ack from existing maintainers, of
> > course.
> > 
> 
> This might prove... difficult. My e-mails to the maintainer (Haixu Cui
> @quicinc.com) continue to be bounced back by the Qualcomm postmaster
> with a RecipientNotFound error. Maybe someone from Qualcomm can give me
> a lead on how to contact them?

Indeed, so it did for me.  Oh that's no good at all.

Mark, what's your take? The maintainer is MIA but we have a volunteer
maintainer here.

As far as I'm concerned

Acked-by: Michael S. Tsirkin <mst@redhat.com>




> > > Changes in v2:
> > > - Expanded the commit message to better explain the functionality and
> > >   the chosen compatible.
> > > - Redundant pieces dropped from bindings.
> > > - Link to v1: https://patch.msgid.link/20260929-spi-virtio-bindings-v1-0-6a0eef3213b3@valla.it
> > > 
> > > To: Haixu Cui <quic_haixcui@quicinc.com>
> > > To: Francesco Valla <francesco@valla.it>
> > > To: Mark Brown <broonie@kernel.org>
> > > To: Rob Herring <robh@kernel.org>
> > > To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > > To: Conor Dooley <conor+dt@kernel.org>
> > > Cc: virtualization@lists.linux.dev
> > > Cc: linux-spi@vger.kernel.org
> > > Cc: devicetree@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > 
> > > ---
> > > Francesco Valla (2):
> > >       dt-bindings: spi: add spi-virtio
> > >       MAINTAINERS: add Francesco as spi-virtio reviewer
> > > 
> > >  .../devicetree/bindings/spi/spi-virtio.yaml        | 46 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  2 +
> > >  2 files changed, 48 insertions(+)
> > > ---
> > > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > > change-id: 20260927-spi-virtio-bindings-f4e350b2709a
> > > 
> > > Best regards,
> > > --  
> > > Francesco Valla <francesco@valla.it>
> > 
> 
> Regards,
> Francesco

